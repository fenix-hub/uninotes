export interface Database {
  uninotes: {
    Tables: {
      notes: {
        Row: {
          id: string
          title: string
          content: string | null
          subject: string
          course_code: string | null
          professor: string | null
          academic_year: string | null
          semester: string | null
          tags: string[] | null
          status: 'draft' | 'published' | 'archived'
          is_public: boolean
          user_id: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          title: string
          content?: string | null
          subject: string
          course_code?: string | null
          professor?: string | null
          academic_year?: string | null
          semester?: string | null
          tags?: string[] | null
          status?: 'draft' | 'published' | 'archived'
          is_public?: boolean
          user_id: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          title?: string
          content?: string | null
          subject?: string
          course_code?: string | null
          professor?: string | null
          academic_year?: string | null
          semester?: string | null
          tags?: string[] | null
          status?: 'draft' | 'published' | 'archived'
          is_public?: boolean
          user_id?: string
          created_at?: string
          updated_at?: string
        }
      }
      note_files: {
        Row: {
          id: string
          note_id: string
          file_name: string
          file_path: string
          file_size: number | null
          file_type: 'pdf' | 'docx' | 'txt' | 'md' | 'image' | 'audio' | 'video'
          mime_type: string | null
          is_primary: boolean
          uploaded_at: string
          user_id: string
        }
        Insert: {
          id?: string
          note_id: string
          file_name: string
          file_path: string
          file_size?: number | null
          file_type: 'pdf' | 'docx' | 'txt' | 'md' | 'image' | 'audio' | 'video'
          mime_type?: string | null
          is_primary?: boolean
          uploaded_at?: string
          user_id: string
        }
        Update: {
          id?: string
          note_id?: string
          file_name?: string
          file_path?: string
          file_size?: number | null
          file_type?: 'pdf' | 'docx' | 'txt' | 'md' | 'image' | 'audio' | 'video'
          mime_type?: string | null
          is_primary?: boolean
          uploaded_at?: string
          user_id?: string
        }
      }
      note_shares: {
        Row: {
          id: string
          note_id: string
          shared_by: string
          shared_with: string
          permission_level: 'read' | 'write' | 'admin'
          created_at: string
        }
        Insert: {
          id?: string
          note_id: string
          shared_by: string
          shared_with: string
          permission_level?: 'read' | 'write' | 'admin'
          created_at?: string
        }
        Update: {
          id?: string
          note_id?: string
          shared_by?: string
          shared_with?: string
          permission_level?: 'read' | 'write' | 'admin'
          created_at?: string
        }
      }
      note_favorites: {
        Row: {
          id: string
          note_id: string
          user_id: string
          created_at: string
        }
        Insert: {
          id?: string
          note_id: string
          user_id: string
          created_at?: string
        }
        Update: {
          id?: string
          note_id?: string
          user_id?: string
          created_at?: string
        }
      }
      user_profiles: {
        Row: {
          id: string
          username: string | null
          full_name: string | null
          university: string | null
          major: string | null
          graduation_year: number | null
          avatar_url: string | null
          bio: string | null
          is_public: boolean
          created_at: string
          updated_at: string
        }
        Insert: {
          id: string
          username?: string | null
          full_name?: string | null
          university?: string | null
          major?: string | null
          graduation_year?: number | null
          avatar_url?: string | null
          bio?: string | null
          is_public?: boolean
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          username?: string | null
          full_name?: string | null
          university?: string | null
          major?: string | null
          graduation_year?: number | null
          avatar_url?: string | null
          bio?: string | null
          is_public?: boolean
          created_at?: string
          updated_at?: string
        }
      }
    }
  }
}

export type Note = Database['uninotes']['Tables']['notes']['Row']
export type NoteInsert = Database['uninotes']['Tables']['notes']['Insert']
export type NoteUpdate = Database['uninotes']['Tables']['notes']['Update']

export type NoteFile = Database['uninotes']['Tables']['note_files']['Row']
export type NoteFileInsert = Database['uninotes']['Tables']['note_files']['Insert']

export type NoteShare = Database['uninotes']['Tables']['note_shares']['Row']
export type NoteShareInsert = Database['uninotes']['Tables']['note_shares']['Insert']

export type NoteFavorite = Database['uninotes']['Tables']['note_favorites']['Row']
export type UserProfile = Database['uninotes']['Tables']['user_profiles']['Row']
export type UserProfileInsert = Database['uninotes']['Tables']['user_profiles']['Insert']
export type UserProfileUpdate = Database['uninotes']['Tables']['user_profiles']['Update']
