<template>
  <div class="min-h-screen py-8">
    <div class="max-w-6xl mx-auto px-6">
      <!-- Navigation Back -->
      <div class="mb-6">
        <button 
          @click="$router.back()"
          class="bg-white px-4 py-2 rounded-lg sketch-border shadow-lg hover:shadow-xl transform hover:-rotate-1 transition-all duration-200 text-gray-700 hover:text-gray-900"
        >
          ← Torna agli appunti
        </button>
      </div>

      <!-- Note Not Found -->
      <div v-if="!note" class="text-center py-20">
        <div class="bg-white p-8 sketch-border shadow-lg transform rotate-1 max-w-md mx-auto">
          <div class="text-6xl mb-4">😵</div>
          <h1 class="text-2xl font-bold text-gray-800 mb-2">Nota non trovata</h1>
          <p class="text-gray-600">Impossibile caricare il documento richiesto.</p>
        </div>
      </div>

      <!-- Note Content -->
      <div v-else class="grid lg:grid-cols-3 gap-8">
        <!-- Main Content Area -->
        <div class="lg:col-span-2 space-y-6">
          <!-- Note Header -->
          <div class="bg-white p-6 sketch-border shadow-lg transform -rotate-0.5">
            <div class="flex items-start justify-between mb-4">
              <div class="flex items-center gap-3">
                <div class="text-4xl">{{ getSubjectIcon(note.subject) }}</div>
                <div>
                  <h1 class="text-3xl font-bold text-gray-800">{{ note.title }}</h1>
                  <p class="text-lg text-gray-600">{{ note.subject }}</p>
                </div>
              </div>
              <div class="flex items-center gap-2">
                <span 
                  class="px-3 py-1 rounded-full text-sm font-medium"
                  :class="getStatusClass(note.status)"
                >
                  {{ note.status.toUpperCase() }}
                </span>
                <span v-if="note.is_favorited" class="text-yellow-500 text-2xl">⭐</span>
                <span v-if="note.is_public" class="text-green-500 text-xl">🌍</span>
              </div>
            </div>

            <!-- Course Info -->
            <div v-if="note.course_code || note.professor" class="mb-4 p-4 bg-blue-50 rounded-lg">
              <div class="grid md:grid-cols-2 gap-4 text-sm">
                <div v-if="note.course_code">
                  <span class="font-medium text-gray-700">Corso:</span>
                  <span class="ml-2">{{ note.course_code }}</span>
                </div>
                <div v-if="note.professor">
                  <span class="font-medium text-gray-700">Professore:</span>
                  <span class="ml-2">{{ note.professor }}</span>
                </div>
                <div v-if="note.academic_year">
                  <span class="font-medium text-gray-700">Anno:</span>
                  <span class="ml-2">{{ note.academic_year }}</span>
                </div>
                <div v-if="note.semester">
                  <span class="font-medium text-gray-700">Semestre:</span>
                  <span class="ml-2">{{ note.semester }}</span>
                </div>
              </div>
            </div>

            <!-- Tags -->
            <div v-if="note.tags && note.tags.length > 0" class="mb-4">
              <div class="flex flex-wrap gap-2">
                <span 
                  v-for="tag in note.tags" 
                  :key="tag"
                  class="bg-blue-100 text-blue-700 px-3 py-1 rounded-full text-sm font-medium"
                >
                  #{{ tag }}
                </span>
              </div>
            </div>

            <!-- Meta Info -->
            <div class="flex items-center justify-between text-sm text-gray-500 border-t pt-4">
              <span>📅 Creato il {{ formatDate(note.created_at) }}</span>
              <span>📝 Aggiornato il {{ formatDate(note.updated_at) }}</span>
            </div>
          </div>

          <!-- Content Display -->
          <div class="bg-white sketch-border shadow-lg transform rotate-0.5">
            <!-- File Viewer -->
            <div v-if="pdfUrl" class="p-4">
              <h3 class="text-xl font-bold text-gray-800 mb-4 flex items-center gap-2">
                📎 Documento allegato
              </h3>
              <iframe
                :src="pdfUrl"
                class="w-full h-[70vh] border rounded-lg"
                title="Documento PDF"
              />
            </div>

            <!-- Text Content -->
            <div v-if="note.content" class="p-6">
              <h3 class="text-xl font-bold text-gray-800 mb-4 flex items-center gap-2">
                📝 Contenuto testuale
              </h3>
              <div 
                class="prose prose-lg max-w-none text-gray-700 leading-relaxed"
                v-html="formatContent(note.content)"
              />
            </div>

            <!-- No Content Message -->
            <div v-if="!pdfUrl && !note.content" class="p-8 text-center text-gray-500">
              <div class="text-6xl mb-4">📄</div>
              <p>Nessun contenuto disponibile per questa nota.</p>
            </div>
          </div>
        </div>

        <!-- Sidebar -->
        <div class="space-y-6">
          <!-- Files List -->
          <div class="bg-white p-6 sketch-border shadow-lg transform rotate-1">
            <h3 class="text-lg font-bold text-gray-800 mb-4 flex items-center gap-2">
              📎 File allegati
            </h3>
            <div v-if="note.note_files && note.note_files.length > 0" class="space-y-3">
              <div 
                v-for="file in note.note_files" 
                :key="file.id"
                class="flex items-center justify-between p-3 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors"
              >
                <div class="flex items-center gap-3">
                  <div class="text-2xl">{{ getFileIcon(file.file_type) }}</div>
                  <div>
                    <p class="font-medium text-gray-800 text-sm">{{ file.file_name }}</p>
                    <p class="text-xs text-gray-500">{{ formatFileSize(file.file_size) }}</p>
                  </div>
                </div>
                <button 
                  @click="downloadFile(file.id, file.file_name)"
                  class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-1 rounded text-xs font-medium transition-colors"
                >
                  Download
                </button>
              </div>
            </div>
            <div v-else class="text-center text-gray-500 py-4">
              <div class="text-3xl mb-2">📄</div>
              <p class="text-sm">Nessun file allegato</p>
            </div>
          </div>

          <!-- Quick Actions -->
          <div class="bg-white p-6 sketch-border shadow-lg transform -rotate-1">
            <h3 class="text-lg font-bold text-gray-800 mb-4">Azioni rapide</h3>
            <div class="space-y-3">
              <button 
                v-if="note.is_public"
                @click="shareNote"
                class="w-full bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg font-medium transition-colors flex items-center justify-center gap-2"
              >
                🔗 Condividi nota
              </button>
              <button 
                @click="toggleFavorite"
                class="w-full bg-yellow-500 hover:bg-yellow-600 text-white px-4 py-2 rounded-lg font-medium transition-colors flex items-center justify-center gap-2"
              >
                {{ note.is_favorited ? '⭐ Rimuovi dai preferiti' : '⭐ Aggiungi ai preferiti' }}
              </button>
              <button 
                @click="printNote"
                class="w-full bg-gray-500 hover:bg-gray-600 text-white px-4 py-2 rounded-lg font-medium transition-colors flex items-center justify-center gap-2"
              >
                🖨️ Stampa
              </button>
            </div>
          </div>

          <!-- Note Stats -->
          <div class="bg-white p-6 sketch-border shadow-lg transform rotate-0.5">
            <h3 class="text-lg font-bold text-gray-800 mb-4">Statistiche</h3>
            <div class="space-y-3 text-sm">
              <div class="flex justify-between">
                <span class="text-gray-600">Visualizzazioni:</span>
                <span class="font-medium">--</span>
              </div>
              <div class="flex justify-between">
                <span class="text-gray-600">Download:</span>
                <span class="font-medium">--</span>
              </div>
              <div class="flex justify-between">
                <span class="text-gray-600">Dimensione totale:</span>
                <span class="font-medium">{{ getTotalFileSize() }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useRoute, useRouter } from 'vue-router'
import { ref, onUnmounted } from 'vue'
import type { NoteResponse, NotesResponse } from '~~/types/api.types'
import type { Note } from '~~/types/note.types'

const route = useRoute()
const router = useRouter()
const noteId = route.params.id
const note = ref<Note>()
const pdfUrl = ref<string>('')

// Fetch note from API
const noteResponse = await $fetch<NoteResponse>('/api/notes/' + noteId, {
  headers: useRequestHeaders(['cookie'])
})

// Extract note from the response
if (noteResponse && noteResponse.data) {
  note.value = noteResponse.data
}

// Update head with note data
useHead({
  title: note.value ? `${note.value.title} - UniNotes` : 'Nota non trovata - UniNotes',
  meta: [
    { 
      name: 'description', 
      content: note.value 
        ? `${note.value.subject} - ${note.value.content?.substring(0, 150) || 'Appunti universitari'}...`
        : 'Nota non trovata' 
    }
  ]
})

// If note has files, download the first file and create a blob URL
if (note.value && note.value.note_files && note.value.note_files.length > 0) {
  try {
    const primaryFile = note.value.note_files.find(f => f.is_primary) || note.value.note_files[0]
    const fileArrayBuffer = await $fetch<ArrayBuffer>('/api/files/' + primaryFile?.id, {
      headers: useRequestHeaders(['cookie']),
      responseType: 'arrayBuffer'
    })
    
    // Convert ArrayBuffer to Blob
    const blob = new Blob([fileArrayBuffer], { 
      type: primaryFile?.mime_type || 'application/pdf' 
    })

    // Create object URL for the blob
    pdfUrl.value = URL.createObjectURL(blob)
    
    // Cleanup the object URL when component is unmounted
    onUnmounted(() => {
      if (pdfUrl.value) {
        URL.revokeObjectURL(pdfUrl.value)
      }
    })
  } catch (error) {
    console.error('Error loading file:', error)
  }
}

// Helper functions
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
    'Chimica': '🧪'
  }
  return icons[subject] || '📚'
}

const getStatusClass = (status: string): string => {
  const classes = {
    'published': 'bg-green-100 text-green-700',
    'draft': 'bg-yellow-100 text-yellow-700',
    'archived': 'bg-gray-100 text-gray-700'
  }
  return classes[status as keyof typeof classes] || 'bg-gray-100 text-gray-700'
}

const getFileIcon = (fileType: string): string => {
  const icons: Record<string, string> = {
    'pdf': '📄',
    'docx': '📝',
    'txt': '📃',
    'md': '📋',
    'image': '🖼️',
    'audio': '🎵',
    'video': '🎬'
  }
  return icons[fileType] || '📎'
}

const formatDate = (dateString: string): string => {
  return new Date(dateString).toLocaleDateString('it-IT', {
    day: 'numeric',
    month: 'long',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
}

const formatFileSize = (bytes: number): string => {
  if (bytes === 0) return '0 Bytes'
  const k = 1024
  const sizes = ['Bytes', 'KB', 'MB', 'GB']
  const i = Math.floor(Math.log(bytes) / Math.log(k))
  return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i]
}

const formatContent = (content: string): string => {
  // Basic markdown-like formatting
  return content
    .replace(/\n/g, '<br>')
    .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
    .replace(/\*(.*?)\*/g, '<em>$1</em>')
    .replace(/^# (.*$)/gm, '<h1 class="text-2xl font-bold mb-4 mt-6">$1</h1>')
    .replace(/^## (.*$)/gm, '<h2 class="text-xl font-bold mb-3 mt-5">$1</h2>')
    .replace(/^### (.*$)/gm, '<h3 class="text-lg font-bold mb-2 mt-4">$1</h3>')
}

const getTotalFileSize = (): string => {
  if (!note.value?.note_files || note.value.note_files.length === 0) return '--'
  const total = note.value.note_files.reduce((sum, file) => sum + file.file_size, 0)
  return formatFileSize(total)
}

// Actions
const downloadFile = (fileId: string, fileName: string) => {
  const link = document.createElement('a')
  link.href = `/api/files/${fileId}`
  link.download = fileName
  link.click()
}

const shareNote = () => {
  if (navigator.share) {
    navigator.share({
      title: note.value?.title,
      text: `Guarda questi appunti: ${note.value?.title}`,
      url: window.location.href
    })
  } else {
    // Fallback: copy to clipboard
    navigator.clipboard.writeText(window.location.href)
    alert('Link copiato negli appunti!')
  }
}

const toggleFavorite = () => {
  // TODO: Implement favorite toggle API call
  console.log('Toggle favorite for note:', noteId)
}

const printNote = () => {
  window.print()
}
</script>

<style scoped>
.sketch-border {
  border: 2px solid #374151;
  border-radius: 8px;
  position: relative;
}

.sketch-border::before {
  content: '';
  position: absolute;
  top: -2px;
  left: -2px;
  right: -2px;
  bottom: -2px;
  border: 2px solid #374151;
  border-radius: 10px;
  transform: rotate(0.5deg);
  z-index: -1;
}

.prose h1, .prose h2, .prose h3 {
  color: #1f2937;
}

.prose p {
  margin-bottom: 1rem;
}

.prose strong {
  font-weight: 600;
  color: #374151;
}

.prose em {
  font-style: italic;
  color: #6b7280;
}

@media print {
  .no-print {
    display: none !important;
  }
}
</style>
