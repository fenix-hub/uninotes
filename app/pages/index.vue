<template>
  <NotesGrid 
    :notes="notes"
    @view-note="viewNote"
    @download-note="downloadNote"
    @add-note="selectFiles"
  />
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useHead } from '#imports'

const router = useRouter()

useHead({
  title: 'I Miei Appunti Universitari',
  meta: [{ name: 'description', content: 'Condividi i tuoi appunti universitari con stile sketch su carta' }]
})

// ...existing notes array...
const notes = ref([
  {
    id: 1,
    title: 'Analisi Matematica I',
    description: 'Limiti, derivate e integrali spiegati con esempi pratici',
    type: 'PDF',
    date: '15 Gen 2025',
    pages: 23,
    icon: '📐'
  },
  {
    id: 2,
    title: 'Fisica Generale',
    description: 'Meccanica classica e termodinamica con esercizi svolti',
    type: 'DOCX',
    date: '12 Gen 2025',
    pages: 31,
    icon: '⚛️'
  },
  {
    id: 3,
    title: 'Programmazione Web',
    description: 'HTML, CSS, JavaScript e frameworks moderni',
    type: 'MD',
    date: '08 Gen 2025',
    pages: 45,
    icon: '💻'
  },
  {
    id: 4,
    title: 'Chimica Organica',
    description: 'Reazioni e meccanismi con schemi riassuntivi',
    type: 'PDF',
    date: '05 Gen 2025',
    pages: 28,
    icon: '🧪'
  }
])

const handleFileSelect = (files) => {
  console.log('File selezionati:', files)
  alert(`${files.length} file selezionati!`)
}

const selectFiles = () => {
  console.log('Trigger file selection')
}

const viewNote = (note) => {
  router.push(`/notes/${note.id}`)
}

const downloadNote = (note) => {
  console.log('Scarica:', note.title)
  alert(`Scaricando: ${note.title}`)
}
</script>
