import { serverSupabaseClient, serverSupabaseUser } from '#supabase/server'
import { createError } from 'h3'
import type { Database, NoteUpdate } from '~~/types/database.types'

export default defineEventHandler(async (event) => {
  try {
    const user = await serverSupabaseUser(event)
    const client = await serverSupabaseClient<Database>(event)
    const noteId = getRouterParam(event, 'id')
    const body = await readBody(event) as NoteUpdate
    
    if (!noteId) {
      throw createError({
        statusCode: 400,
        statusMessage: 'Note ID is required'
      })
    }

    const updateData: NoteUpdate = {
      ...body,
      updated_at: new Date().toISOString()
    }

    const { data, error } = await client
      .from('notes')
      .update(updateData)
      .eq('id', noteId)
      .eq('user_id', user!.id) // Ensure user owns the note
      .select(`
        *,
        note_files(*),
        user_profiles(username, full_name)
      `)
      .single()

    if (error) throw error

    return { data }
  } catch (error: any) {
    throw createError({
      statusCode: error.statusCode || 500,
      statusMessage: error.message || 'Internal Server Error'
    })
  }
})
