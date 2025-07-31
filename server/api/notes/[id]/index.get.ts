import { serverSupabaseClient, serverSupabaseUser } from '#supabase/server'
import { createError } from 'h3'
import type { Database } from '~~/types/database.types'
import { Note } from '~~/types/note.types'

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

    const { data: noteData, error: noteError } = await client
      .schema('uninotes')
      .from('notes')
      .select(`
        *,
        note_files(*)
      `)
      .eq('id', noteId)
      .single()

    if (noteError && noteError.code !== 'PGRST116') throw noteError

    const response: Note = {
      ...noteData,
      is_favorited: true
    }
    
    return { data: response }
  } catch (error: any) {
    throw createError({
      statusCode: error.statusCode || 404,
      statusMessage: error.message || 'Note not found'
    })
  }
})
