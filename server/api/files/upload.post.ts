import { serverSupabaseClient, serverSupabaseUser } from '#supabase/server'
import { createError } from 'h3'
import type { Database, NoteFileInsert } from '~~/types/database.types'

type FileType = 'pdf' | 'docx' | 'txt' | 'md' | 'image' | 'audio' | 'video'

const getFileType = (mimeType: string): FileType => {
  if (mimeType.includes('pdf')) return 'pdf'
  if (mimeType.includes('word') || mimeType.includes('document')) return 'docx'
  if (mimeType.includes('text')) return 'txt'
  if (mimeType.includes('markdown')) return 'md'
  if (mimeType.includes('image')) return 'image'
  if (mimeType.includes('audio')) return 'audio'
  if (mimeType.includes('video')) return 'video'
  return 'txt' // default
}

export default defineEventHandler(async (event) => {
  try {
    const user = await serverSupabaseUser(event)
    const client = await serverSupabaseClient<Database>(event)
    const formData = await readMultipartFormData(event)
    
    if (!formData) {
      throw createError({
        statusCode: 400,
        statusMessage: 'No form data received'
      })
    }

    const noteId = formData.find(item => item.name === 'note_id')?.data.toString()
    const file = formData.find(item => item.name === 'file')
    const isPrimary = formData.find(item => item.name === 'is_primary')?.data.toString() === 'true'

    if (!file || !noteId || !file.filename) {
      throw createError({
        statusCode: 400,
        statusMessage: 'File and note_id are required'
      })
    }

    // Verify user owns the note
    const { data: note, error: noteError } = await client
      .from('notes')
      .select('id')
      .eq('id', noteId)
      .eq('user_id', user!.id)
      .single()

    if (noteError || !note) {
      throw createError({
        statusCode: 403,
        statusMessage: 'Note not found or access denied'
      })
    }

    // Generate unique file path
    const fileExt = file.filename.split('.').pop()
    const fileName = `${Date.now()}-${Math.random().toString(36).substring(2)}.${fileExt}`
    const filePath = `${noteId}/${fileName}`

    // Upload to Supabase Storage
    const { data: uploadData, error: uploadError } = await client.storage
      .from('note-files')
      .upload(filePath, file.data, {
        contentType: file.type || 'application/octet-stream'
      })

    if (uploadError) throw uploadError

    // Create database record
    const fileRecord: NoteFileInsert = {
      note_id: noteId,
      user_id: user!.id,
      file_name: file.filename,
      file_path: filePath,
      file_size: file.data.length,
      file_type: getFileType(file.type || ''),
      mime_type: file.type,
      is_primary: isPrimary || false
    }

    const { data, error } = await client
      .from('note_files')
      .insert(fileRecord)
      .select()
      .single()

    if (error) throw error

    return { data, uploadPath: uploadData.path }
  } catch (error: any) {
    throw createError({
      statusCode: error.statusCode || 500,
      statusMessage: error.message || 'File upload failed'
    })
  }
})
