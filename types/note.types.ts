export type NoteStatus = 'draft' | 'published' | 'archived'
export type NoteFileType = 'pdf' | 'docx' | 'txt' | 'md' | 'image' | 'audio' | 'video'

export interface Note {
    id: string
    title: string
    content?: string
    subject: string
    course_code?: string
    professor?: string
    academic_year?: string
    semester?: string
    tags: string[]
    status: 'draft' | 'published' | 'archived'
    is_public: boolean
    user_id: string
    created_at: string
    updated_at: string
    note_files?: NoteFile[]
    is_favorited?: boolean
}

export interface NoteFile {
    id: string
    note_id: string
    file_name: string
    file_path: string
    file_size: number
    file_type: NoteFileType
    mime_type: string
    is_primary: boolean
    uploaded_at: string
    user_id: string
}
