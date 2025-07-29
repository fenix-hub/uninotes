<template>
  <div class="p-4 max-w-4xl mx-auto font-sketch">
    <h1 class="text-2xl mb-4">{{ note?.title || 'Nota non trovata' }}</h1>
    <iframe
      v-if="note"
      :src="pdfUrl"
      class="w-full h-[80vh] border"
    />
    <p v-else>Impossibile caricare il documento.</p>
  </div>
</template>

<script setup>
import { useRoute } from 'vue-router'

const route = useRoute()
const noteId = route.params.id

// esempio dummy data; in produzione, fetch da API/Supabase
const notes = [
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
]

const note = notes.find(n => String(n.id) === noteId)
const pdfUrl = '/Constatazione_amichevole_di_incidente.pdf'
</script>
