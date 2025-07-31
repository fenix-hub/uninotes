import { serverSupabaseClient, serverSupabaseUser } from '#supabase/server'
import { createError } from 'h3'
import type { Database } from '~~/types/database.types'

export default defineEventHandler(async (event) => {
  try {
    const user = await serverSupabaseUser(event)
    const client = await serverSupabaseClient<Database>(event)
    
    // Get note ID from URL params
    const noteId = getRouterParam(event, 'noteId')
    
    if (!noteId) {
      throw createError({
        statusCode: 400,
        statusMessage: 'Note ID is required'
      })
    }

    // Check note access permissions first
    const { data: note, error: noteError } = await client
      .schema('uninotes')
      .from('notes')
      .select('id, user_id, is_public, status')
      .eq('id', noteId)
      .single()

    if (noteError || !note) {
      throw createError({
        statusCode: 404,
        statusMessage: 'Note not found'
      })
    }

    // Check access permissions
    const hasAccess = 
      // User owns the note
      note.user_id === user?.id ||
      // Note is public and published
      (note.is_public && note.status === 'published') ||
      // Check if note is shared with user (if user is authenticated)
      (user && await checkNoteSharedWithUser(client, note.id, user.id))

    if (!hasAccess) {
      throw createError({
        statusCode: 403,
        statusMessage: 'Access denied. You do not have permission to view files for this note.'
      })
    }

    // Get all files for the note
    const { data: files, error: filesError } = await client
      .schema('uninotes')
      .from('note_files')
      .select('*')
      .eq('note_id', noteId)
      .order('is_primary', { ascending: false })
      .order('uploaded_at', { ascending: false })

    if (filesError) {
      throw createError({
        statusCode: 500,
        statusMessage: 'Failed to fetch files'
      })
    }

    return {
      data: files || [],
      note: {
        id: note.id,
        canEdit: note.user_id === user?.id
      }
    }

  } catch (error: any) {
    throw createError({
      statusCode: error.statusCode || 500,
      statusMessage: error.message || 'Failed to fetch note files'
    })
  }
})

// Helper function to check if note is shared with user
async function checkNoteSharedWithUser(
  client: any, 
  noteId: string, 
  userId: string
): Promise<boolean> {
  const { data: shareRecord, error } = await client
    .schema('uninotes')
    .from('note_shares')
    .select('id')
    .eq('note_id', noteId)
    .eq('shared_with', userId)
    .single()

  return !error && !!shareRecord
}
