import { serverSupabaseClient, serverSupabaseUser } from '#supabase/server'
import { createError } from 'h3'
import type { Database } from '~~/types/database.types'

export default defineEventHandler(async (event) => {
  try {
    const user = await serverSupabaseUser(event)
    const client = await serverSupabaseClient<Database>(event)
    
    // Get file ID from URL params
    const fileId = getRouterParam(event, 'id')
    
    if (!fileId) {
      throw createError({
        statusCode: 400,
        statusMessage: 'File ID is required'
      })
    }

    // Get file information from database
    const { data: fileRecord, error: fileError } = await client
      .schema('uninotes')
      .from('note_files')
      .select(`
        *,
        notes!inner(
          id,
          user_id,
          is_public,
          status
        )
      `)
      .eq('id', fileId)
      .single()

    if (fileError || !fileRecord) {
      throw createError({
        statusCode: 404,
        statusMessage: 'File not found'
      })
    }

    // Check access permissions
    const note = fileRecord.notes
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
        statusMessage: 'Access denied. You do not have permission to download this file.'
      })
    }

    // Download file from Supabase Storage
    const { data: fileData, error: downloadError } = await client.storage
      .from('note-files/' + fileRecord.note_id)
      .download(fileRecord.file_name)

    if (downloadError) {
      console.error('Storage download error:', downloadError)
      throw createError({
        statusCode: 500,
        statusMessage: 'Failed to download file from storage'
      })
    }

    // Convert blob to buffer
    const buffer = Buffer.from(await fileData.arrayBuffer())

    // Set appropriate headers
    setHeader(event, 'Content-Type', fileRecord.mime_type || 'application/octet-stream')
    setHeader(event, 'Content-Disposition', `attachment; filename="${fileRecord.file_name}"`)
    setHeader(event, 'Content-Length', buffer.length)
    setHeader(event, 'Cache-Control', 'private, max-age=3600') // Cache for 1 hour

    // Return file buffer
    return buffer

  } catch (error: any) {
    console.error('File download error:', error)
    throw createError({
      statusCode: error.statusCode || 500,
      statusMessage: error.message || 'File download failed'
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
