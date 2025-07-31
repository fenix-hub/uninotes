<template>
  <section class="max-w-4xl mx-auto px-6 mb-8">
    <div class="sketch-border p-6">
      <h2 class="text-2xl font-bold text-gray-800 mb-4 sketch-underline">
        ➕ Aggiungi Nuovi Appunti
      </h2>
      <div 
        class="upload-area p-8 text-center"
        @dragover.prevent="onDragOver"
        @dragleave="onDragLeave"
        @drop.prevent="onDrop"
        @click="selectFiles"
      >
        <div class="sketch-icon text-6xl mb-4">📝</div>
        <p class="text-xl text-gray-700 mb-4">
          Trascina i tuoi file qui o clicca per selezionare
        </p>
        <button class="btn-sketch px-6 py-3 text-lg font-semibold text-gray-800 hover:bg-gray-50">
          Scegli File
        </button>
        <p class="text-sm text-gray-500 mt-2">
          Supporta PDF, DOCX, TXT, MD e altro...
        </p>
      </div>
    </div>
    
    <input 
      ref="fileInput"
      type="file"
      multiple
      accept=".pdf,.docx,.txt,.md"
      class="hidden"
      @change="handleFileSelect"
    >
  </section>
</template>

<script setup>
const emit = defineEmits(['filesSelected'])
const fileInput = ref(null)

const selectFiles = () => {
  fileInput.value?.click()
}

const handleFileSelect = (event) => {
  const files = Array.from(event.target.files)
  emit('filesSelected', files)
}

const onDragOver = (event) => {
  event.target.style.background = '#f0f9ff'
  event.target.style.transform = 'scale(1.02)'
}

const onDragLeave = (event) => {
  event.target.style.background = '#fefdf8'
  event.target.style.transform = 'scale(1)'
}

const onDrop = (event) => {
  const uploadArea = event.target
  uploadArea.style.background = '#fefdf8'
  uploadArea.style.transform = 'scale(1)'
  
  const files = Array.from(event.dataTransfer.files)
  emit('filesSelected', files)
}
</script>

<style scoped>
/* Form di upload sketch */
.upload-area {
  border: 3px dashed #4a4a4a;
  border-radius: 12px;
  background: #fefdf8;
  position: relative;
  transition: all 0.3s ease;
  cursor: pointer;
}

.upload-area:hover {
  border-color: #2d2d2d;
  transform: scale(1.01);
}
</style>