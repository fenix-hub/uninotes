<template>
  <NotesGrid 
    :notes="notes"
    @view-note="viewNote"
    @download-note="downloadNote"
    @add-note="selectFiles"
  />
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useHead } from '#imports'
import type { NotesResponse } from '~~/types/api.types'
import type { Note } from '~~/types/note.types'

const router = useRouter()

useHead({
  title: 'I Miei Appunti Universitari',
  meta: [{ name: 'description', content: 'Condividi i tuoi appunti universitari con stile sketch su carta' }]
})

// Initialize with empty array, will be populated by API call
const notes = ref<Note[]>([])

// Fetch notes from API
const notesResponse = await $fetch<NotesResponse>('/api/notes', {
  headers: useRequestHeaders(['cookie'])
})

// Extract notes from the response
if (notesResponse) {
  notes.value = notesResponse.data
}

const handleFileSelect = (files: File[]) => {
  console.log('File selezionati:', files)
  alert(`${files.length} file selezionati!`)
}

const selectFiles = () => {
  console.log('Trigger file selection')
}

const viewNote = (note: Note) => {
  console.log('Visualizza nota:', note.title)
  router.push(`/notes/${note.id}`)
}

const downloadNote = (note: Note) => {
  console.log('Scarica:', note.title)
  alert(`Scaricando: ${note.title}`)
}
</script>
