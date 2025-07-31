<template>
  <div 
    class="note-card p-6 flex flex-col"
    :style="{ transform: `rotate(${rotation}deg)` }"
    @mouseenter="onCardHover"
    @mouseleave="onCardLeave"
    @click="$emit('view', note)"
    >
    <!-- Header with status and favorite -->
    <!-- <div class="flex items-start justify-between mb-3">
      <div class="flex items-center gap-2">
        <div class="sketch-icon text-2xl">{{ getSubjectIcon(note.subject) }}</div>
        <span 
          class="text-xs px-2 py-1 rounded font-tag"
          :class="getStatusClass(note.status)"
        >
          {{ note.status.toUpperCase() }}
        </span>
      </div>
      <div class="flex items-center gap-1">
        <span v-if="note.is_favorited" class="text-yellow-500 text-lg">⭐</span>
        <span v-if="note.is_public" class="text-green-500 text-sm">🌍</span>
      </div>
    </div> -->

    <!-- Title -->
    <h3 class="text-xl font-bold text-gray-800 mb-2 line-clamp-2">
      {{ note.title }}
    </h3>

    <!-- Subject and Course -->
    <div class="mb-3">
      <p class="text-gray-700 font-medium text-sm">
        {{ note.subject }}
      </p>
      <p v-if="note.course_code" class="text-gray-500 text-xs">
        {{ note.course_code }} - {{ note.professor }}
      </p>
    </div>

    <!-- Academic info -->
    <div v-if="note.academic_year" class="mb-3 text-xs text-gray-600">
      📚 {{ note.academic_year }} • {{ note.semester }}
    </div>

    <!-- Tags -->
    <div v-if="note.tags && note.tags.length > 0" class="mb-3 flex flex-wrap gap-1">
      <span 
        v-for="tag in note.tags.slice(0, 3)" 
        :key="tag"
        class="text-xs bg-blue-100 text-blue-700 px-2 py-1 rounded-full"
      >
        #{{ tag }}
      </span>
      <span v-if="note.tags.length > 3" class="text-xs text-gray-500">
        +{{ note.tags.length - 3 }}
      </span>
    </div>

    <!-- Footer info -->
    <div class="mt-auto flex items-center justify-between text-xs text-gray-500">
      <span>📅 {{ formatDate(note.created_at) }}</span>
      <div class="flex items-center gap-2">
        <span v-if="note.note_files && note.note_files.length > 0">
          📎 {{ note.note_files.length }}
        </span>
        <span v-else class="text-gray-400">📝 Solo testo</span>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import type { Note } from '~~/types/note.types'

const rotation = ref(0)
onMounted(() => {
  rotation.value = Math.random() * 2 - 1
})

interface Props {
  note: Note
}

defineProps<Props>()
defineEmits(['view', 'download'])

const onCardHover = (event: MouseEvent) => {
  const target = event.currentTarget as HTMLElement
  target.style.transform = 'rotate(0deg) scale(1.02)'
}

const onCardLeave = (event: MouseEvent) => {
  const target = event.currentTarget as HTMLElement
  target.style.transform = `rotate(${rotation.value}deg) scale(1)`
}

// Get icon based on subject
const getSubjectIcon = (subject: string): string => {
  const icons: Record<string, string> = {
    'Matematica': '📐',
    'Analisi Matematica': '📊',
    'Fisica': '⚛️',
    'Informatica': '💻',
    'Algoritmi e Strutture Dati': '🔄',
    'Machine Learning': '🤖',
    'Database': '🗃️',
    'Sistemi Operativi': '⚙️',
    'Reti di Calcolatori': '🌐',
    'Economia': '💰',
    'Microeconomia': '📈',
    'Macroeconomia': '🏦',
    'Finanza Aziendale': '💼',
    'Ingegneria': '🔧',
    'Sistemi Embedded': '🔌',
    'Medicina': '🏥',
    'Neuroanatomia': '🧠',
    'Chimica': '🧪',
    'Chimica Organica': '⚗️'
  }
  return icons[subject] || '📚'
}

// Get status styling
const getStatusClass = (status: string): string => {
  const classes = {
    'published': 'bg-green-100 text-green-700',
    'draft': 'bg-yellow-100 text-yellow-700',
    'archived': 'bg-gray-100 text-gray-700'
  }
  return classes[status as keyof typeof classes] || 'bg-gray-100 text-gray-700'
}

// Format date to Italian locale
const formatDate = (dateString: string): string => {
  return new Date(dateString).toLocaleDateString('it-IT', {
    day: 'numeric',
    month: 'short',
    year: 'numeric'
  })
}
</script>

<style scoped>
/* Card degli appunti con effetto sketch */
.note-card {
  background: #fefdf8;
  border: 2px solid #4a4a4a;
  border-radius: 8px;
  position: relative;
  transition: all 0.3s ease;
  box-shadow: 3px 3px 0px rgba(0,0,0,0.1);
  cursor: pointer;
  height: 18rem;
  width: 16rem;
}

.note-card:hover {
  box-shadow: 5px 5px 0px rgba(0,0,0,0.15);
}

/* Clamp text to prevent overflow */
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

/* Smooth tag transitions */
.note-card .text-xs {
  transition: all 0.2s ease;
}
</style>