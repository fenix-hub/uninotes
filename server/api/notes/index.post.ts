import { serverSupabaseClient, serverSupabaseUser } from '#supabase/server'
import type { Database, NoteInsert } from '~~/types/database.types'

import { createError } from 'h3'

export default defineEventHandler(async (event) => {
    try {
        const user = await serverSupabaseUser(event)
        const client = await serverSupabaseClient<Database>(event)
        const body = await readBody(event) as Partial<NoteInsert>

        const noteData: NoteInsert = {
            ...body,
            user_id: user!.id,
            title: body.title || 'Untitled Note',
            subject: body.subject || 'General',
            created_at: new Date().toISOString(),
            updated_at: new Date().toISOString()
        }

        const { data, error } = await client
            .from('notes')
            .insert(noteData)
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
