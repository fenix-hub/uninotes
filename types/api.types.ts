import type { Note } from './note.types'

export interface PaginationMeta {
    page: number
    limit: number
    total: number
    pages: number
}

export interface PaginatedResponse<T> {
    data: T[]
    pagination: PaginationMeta
}

export interface NotesResponse extends PaginatedResponse<Note> {
    data: Note[]
}

export interface NoteResponse {
    data: Note
}