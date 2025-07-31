<template>
  <main class="max-w-4xl mx-auto px-6 pb-12">
    <!-- <h2 class="text-3xl font-bold text-gray-800 mb-6 sketch-underline">
      📖 I Tuoi Appunti
    </h2> -->
    
    <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
      <NoteCard 
        v-if="notes.length > 0"
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

<script setup lang="ts">
import type { Note } from '~~/types/note.types'

interface Props {
  notes: Note[]
}

defineProps<Props>()
defineEmits(['viewNote', 'downloadNote', 'addNote'])
</script>
