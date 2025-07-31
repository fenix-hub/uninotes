import { serverSupabaseClient, serverSupabaseUser } from '#supabase/server'
import { createError } from 'h3'
import type { Database } from '~~/types/database.types'
import type { NotesResponse } from '~~/types/api.types'


interface NotesQuery {
    page?: string
    limit?: string
    subject?: string
    status?: 'draft' | 'published' | 'archived'
    search?: string
    tags?: string | string[]
    my_notes?: string
}

export default defineEventHandler(async (event): Promise<NotesResponse> => {
    try {
        const user = await serverSupabaseUser(event)
        const client = await serverSupabaseClient<Database>(event)
        const query = getQuery(event) as NotesQuery

        const {
            page = '1',
            limit = '10',
            subject,
            status = 'published',
            search,
            tags,
            my_notes = 'false'
        } = query

        let supabaseQuery = client
            .schema('uninotes') // Ensure we're using the correct schema
            .from('notes')
            .select(`
                *,
                note_files(id, file_name, file_type, is_primary)
                `, { count: 'exact' }
            )   

        // Apply filters
        if (my_notes === 'true') {
            supabaseQuery = supabaseQuery.eq('user_id', user!.id)
        }

        if (subject) {
            supabaseQuery = supabaseQuery.eq('subject', subject)
        }

        if (status) {
            supabaseQuery = supabaseQuery.eq('status', status)
        }

        if (search) {
            supabaseQuery = supabaseQuery.textSearch('search_vector', search)
        }

        if (tags) {
            const tagArray = Array.isArray(tags) ? tags : [tags]
            supabaseQuery = supabaseQuery.overlaps('tags', tagArray)
        }

        // Pagination
        const pageNum = parseInt(page)
        const limitNum = parseInt(limit)
        const offset = (pageNum - 1) * limitNum

        supabaseQuery = supabaseQuery
            .range(offset, offset + limitNum - 1)
            .order('created_at', { ascending: false })

        const { data, error, count } = await supabaseQuery

        if (error) {
            console.log('Error fetching notes:', error)
            throw createError({ statusMessage: error.message })
        }

        const response: NotesResponse = {
            data,
            pagination: {
                page: pageNum,
                limit: limitNum,
                total: count || 0,
                pages: Math.ceil((count || 0) / limitNum)
            }
        }

        return response
    } catch (error: any) {
        throw createError({
            statusCode: error.statusCode || 500,
            statusMessage: error.message || 'Internal Server Error'
        })
    }
})
