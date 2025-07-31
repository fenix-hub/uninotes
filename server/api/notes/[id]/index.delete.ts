import { serverSupabaseClient, serverSupabaseUser } from '#supabase/server'
import { createError } from 'h3'
import type { Database } from '~~/types/database.types'

export default defineEventHandler(async (event) => {
  try {
    const user = await serverSupabaseUser(event)
    const client = await serverSupabaseClient<Database>(event)
    const noteId = getRouterParam(event, 'id')
    
    if (!noteId) {
      throw createError({
        statusCode: 400,
        statusMessage: 'Note ID is required'
      })
    }

    // Get associated files before deletion
    const { data: files } = await client
      .from('note_files')
      .select('file_path')
      .eq('note_id', noteId)
      .eq('user_id', user!.id)

    // Delete files from storage if they exist
    if (files && files.length > 0) {
      const filePaths = files.map(file => file.file_path)
      const { error: storageError } = await client.storage
        .from('note-files')
        .remove(filePaths)
      
      if (storageError) {
        throw createError({
            statusCode: 500,
            statusMessage: 'Error deleting files from storage'
        })
      }
    }

    // Delete the note (cascades to note_files, note_shares, note_favorites)
    const { error } = await client
      .from('notes')
      .delete()
      .eq('id', noteId)
      .eq('user_id', user!.id) // Ensure user owns the note

    if (error) throw error

    return { success: true, message: 'Note deleted successfully' }
  } catch (error: any) {
    throw createError({
      statusCode: error.statusCode || 500,
      statusMessage: error.message || 'Internal Server Error'
    })
  }
})
