<template>
  <main class="max-w-4xl mx-auto px-6 pb-12">
    <!-- <h2 class="text-3xl font-bold text-gray-800 mb-6 sketch-underline font-sketch">
      📖 I Tuoi Appunti
    </h2> -->
    
    <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
      <NoteCard 
        v-for="note in notes" 
        :key="note.id"
        :note="note"
        @view="$emit('viewNote', $event)"
        @download="$emit('downloadNote', $event)"
      />
      
      <AddNoteCard @add-note="$emit('addNote')" />
    </div>
  </main>
</template>

<script setup>
import { useSupabaseClient } from '#imports'

// const supabase = useSupabaseClient()
// const { data: notes, error } = await useAsyncData('notes', () =>
//   supabase.from('notes').select('*')
// )

var notes = ref([
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
]) // Placeholder for notes data

var error = ref(null)

if (error.value) {
  console.error('Error loading notes:', error.value)
}

defineEmits(['viewNote', 'downloadNote', 'addNote'])
</script>
