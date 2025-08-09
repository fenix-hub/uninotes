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

      <!-- Loading State -->
      <div v-if="pending" class="space-y-6">
        <LoadingNoteDetail />
      </div>

      <!-- Error State -->
      <div v-else-if="error" class="text-center py-20">
        <div class="bg-white p-8 sketch-border shadow-lg transform rotate-1 max-w-md mx-auto">
          <div class="text-6xl mb-4">😵</div>
          <h1 class="text-2xl font-bold text-gray-800 mb-2">Errore nel caricamento</h1>
          <p class="text-gray-600 mb-4">{{ error.message || 'Impossibile caricare la nota.' }}</p>
          <button 
            @click="refresh()"
            class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded-lg font-medium transition-colors"
          >
            Riprova
          </button>
        </div>
      </div>

      <!-- Note Not Found -->
      <div v-else-if="!data?.data" class="text-center py-20">
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
                <div class="text-4xl">{{ getSubjectIcon(data.data.subject) }}</div>
                <div>
                  <h1 class="text-3xl font-bold text-gray-800">{{ data.data.title }}</h1>
                  <p class="text-lg text-gray-600">{{ data.data.subject }}</p>
                </div>
              </div>
              <div class="flex items-center gap-2">
                <span 
                  class="px-3 py-1 rounded-full text-sm font-medium"
                  :class="getStatusClass(data.data.status)"
                >
                  {{ data.data.status.toUpperCase() }}
                </span>
                <span v-if="data.data.is_favorited" class="text-yellow-500 text-2xl">⭐</span>
                <span v-if="data.data.is_public" class="text-green-500 text-xl">🌍</span>
              </div>
            </div>

            <!-- Course Info -->
            <div v-if="data.data.course_code || data.data.professor" class="mb-4 p-4 bg-blue-50 rounded-lg">
              <div class="grid md:grid-cols-2 gap-4 text-sm">
                <div v-if="data.data.course_code">
                  <span class="font-medium text-gray-700">Corso:</span>
                  <span class="ml-2">{{ data.data.course_code }}</span>
                </div>
                <div v-if="data.data.professor">
                  <span class="font-medium text-gray-700">Professore:</span>
                  <span class="ml-2">{{ data.data.professor }}</span>
                </div>
                <div v-if="data.data.academic_year">
                  <span class="font-medium text-gray-700">Anno:</span>
                  <span class="ml-2">{{ data.data.academic_year }}</span>
                </div>
                <div v-if="data.data.semester">
                  <span class="font-medium text-gray-700">Semestre:</span>
                  <span class="ml-2">{{ data.data.semester }}</span>
                </div>
              </div>
            </div>

            <!-- Tags -->
            <div v-if="data.data.tags && data.data.tags.length > 0" class="mb-4">
              <div class="flex flex-wrap gap-2">
                <span 
                  v-for="tag in data.data.tags" 
                  :key="tag"
                  class="bg-blue-100 text-blue-700 px-3 py-1 rounded-full text-sm font-medium"
                >
                  #{{ tag }}
                </span>
              </div>
            </div>

            <!-- Meta Info -->
            <div class="flex items-center justify-between text-sm text-gray-500 border-t pt-4">
              <span>📅 Creato il {{ formatDate(data.data.created_at) }}</span>
              <span>📝 Aggiornato il {{ formatDate(data.data.updated_at) }}</span>
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

            <!-- File Loading -->
            <div v-else-if="fileLoading" class="p-4">
              <h3 class="text-xl font-bold text-gray-800 mb-4 flex items-center gap-2">
                📎 Documento allegato
              </h3>
              <div class="w-full h-[70vh] border rounded-lg bg-gray-100 flex items-center justify-center">
                <LoadingSpinner class="w-8 h-8" />
                <span class="ml-2 text-gray-600">Caricamento file...</span>
              </div>
            </div>

            <!-- Text Content -->
            <div v-if="data.data.content" class="p-6">
              <h3 class="text-xl font-bold text-gray-800 mb-4 flex items-center gap-2">
                📝 Contenuto testuale
              </h3>
              <div 
                class="prose prose-lg max-w-none text-gray-700 leading-relaxed"
                v-html="formatContent(data.data.content)"
              />
            </div>

            <!-- No Content Message -->
            <div v-if="!pdfUrl && !data.data.content && !fileLoading" class="p-8 text-center text-gray-500">
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
            <div v-if="data.data.note_files && data.data.note_files.length > 0" class="space-y-3">
              <div 
                v-for="file in data.data.note_files" 
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
                  :disabled="downloadingFiles.has(file.id)"
                  class="bg-blue-500 hover:bg-blue-600 disabled:bg-gray-400 text-white px-3 py-1 rounded text-xs font-medium transition-colors flex items-center gap-1"
                >
                  <LoadingSpinner v-if="downloadingFiles.has(file.id)" class="w-3 h-3" />
                  <span>{{ downloadingFiles.has(file.id) ? 'Download...' : 'Download' }}</span>
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
                v-if="data.data.is_public"
                @click="shareNote"
                class="w-full bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg font-medium transition-colors flex items-center justify-center gap-2"
              >
                🔗 Condividi nota
              </button>
              <button 
                @click="toggleFavorite"
                :disabled="favoriteLoading"
                class="w-full bg-yellow-500 hover:bg-yellow-600 disabled:bg-gray-400 text-white px-4 py-2 rounded-lg font-medium transition-colors flex items-center justify-center gap-2"
              >
                <LoadingSpinner v-if="favoriteLoading" class="w-4 h-4" />
                <span>{{ data.data.is_favorited ? '⭐ Rimuovi dai preferiti' : '⭐ Aggiungi ai preferiti' }}</span>
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
import { ref, onUnmounted, watch } from 'vue'
import type { NoteResponse } from '~~/types/api.types'

const route = useRoute()
const router = useRouter()
const noteId = route.params.id as string

// Reactive states
const pdfUrl = ref<string>('')
const fileLoading = ref(false)
const favoriteLoading = ref(false)
const downloadingFiles = ref(new Set<string>())

// Async data fetching
const { data, pending, error, refresh } = await useLazyFetch<NoteResponse>(`/api/notes/${noteId}`, {
  key: `note-${noteId}`,
  server: false, // Client-side only for immediate navigation
})

// Watch for data changes and load primary file
watch(data, async (newData) => {
  if (newData?.data?.note_files && newData.data.note_files.length > 0) {
    await loadPrimaryFile(newData.data.note_files)
  }
}, { immediate: true })

// Load primary file asynchronously
const loadPrimaryFile = async (files: any[]) => {
  const primaryFile = files.find(f => f.is_primary) || files[0]
  if (!primaryFile || primaryFile.file_type !== 'pdf') return

  try {
    fileLoading.value = true
    const fileArrayBuffer = await $fetch<ArrayBuffer>(`/api/files/${primaryFile.id}`, {
      responseType: 'arrayBuffer'
    })
    
    const blob = new Blob([fileArrayBuffer], { 
      type: primaryFile.mime_type || 'application/pdf' 
    })

    pdfUrl.value = URL.createObjectURL(blob)
  } catch (error) {
    console.error('Error loading file:', error)
  } finally {
    fileLoading.value = false
  }
}

// Update head with note data
watchEffect(() => {
  if (data.value?.data) {
    useHead({
      title: `${data.value.data.title} - UniNotes`,
      meta: [
        { 
          name: 'description', 
          content: `${data.value.data.subject} - ${data.value.data.content?.substring(0, 150) || 'Appunti universitari'}...`
        }
      ]
    })
  }
})

// Cleanup
onUnmounted(() => {
  if (pdfUrl.value) {
    URL.revokeObjectURL(pdfUrl.value)
  }
})

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
  if (!data.value?.data?.note_files || data.value.data.note_files.length === 0) return '--'
  const total = data.value.data.note_files.reduce((sum, file) => sum + file.file_size, 0)
  return formatFileSize(total)
}

// Actions
const downloadFile = async (fileId: string, fileName: string) => {
  try {
    downloadingFiles.value.add(fileId)
    
    const fileBlob = await $fetch<Blob>(`/api/files/${fileId}`, {
      responseType: 'blob'
    })
    
    const url = URL.createObjectURL(fileBlob)
    const link = document.createElement('a')
    link.href = url
    link.download = fileName
    link.click()
    URL.revokeObjectURL(url)
  } catch (error) {
    console.error('Download failed:', error)
  } finally {
    downloadingFiles.value.delete(fileId)
  }
}

const toggleFavorite = async () => {
  if (!data.value?.data) return
  
  try {
    favoriteLoading.value = true
    
    if (data.value.data.is_favorited) {
      await $fetch(`/api/notes/${noteId}/favorite`, { method: 'DELETE' })
      data.value.data.is_favorited = false
    } else {
      await $fetch(`/api/notes/${noteId}/favorite`, { method: 'POST' })
      data.value.data.is_favorited = true
    }
  } catch (error) {
    console.error('Failed to toggle favorite:', error)
  } finally {
    favoriteLoading.value = false
  }
}

const shareNote = () => {
  if (!data.value?.data) return
  
  if (navigator.share) {
    navigator.share({
      title: data.value.data.title,
      text: `Guarda questi appunti: ${data.value.data.title}`,
      url: window.location.href
    })
  } else {
    navigator.clipboard.writeText(window.location.href)
    alert('Link copiato negli appunti!')
  }
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