<template>
  <div class="paper-texture min-h-screen font-architect">
    <!-- Header -->
    <header class="p-6">
      <div class="max-w-4xl mx-auto">
        <h1 class="text-4xl font-bold text-gray-800 sketch-underline mb-2 font-marker">
          📚 I Miei Appunti Universitari
        </h1>
        <p class="text-lg text-gray-600 italic transform rotate-0.2 font-shadows">
          "La conoscenza è l'unico tesoro che cresce quando viene condiviso"
        </p>
      </div>
    </header>

    <!-- Area Upload -->
    <section class="max-w-4xl mx-auto px-6 mb-8">
      <div class="sketch-border p-6">
        <h2 class="text-2xl font-bold text-gray-800 mb-4 sketch-underline font-architect">
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
          <p class="text-xl text-gray-700 mb-4 font-sketch">
            Trascina i tuoi file qui o clicca per selezionare
          </p>
          <button class="btn-sketch px-6 py-3 text-lg font-semibold text-gray-800 hover:bg-gray-50 font-architect">
            Scegli File
          </button>
          <p class="text-sm text-gray-500 mt-2 font-sketch">
            Supporta PDF, DOCX, TXT, MD e altro...
          </p>
        </div>
      </div>
    </section>

    <!-- Lista Appunti -->
    <main class="max-w-4xl mx-auto px-6 pb-12">
      <h2 class="text-3xl font-bold text-gray-800 mb-6 sketch-underline font-marker">
        📖 I Tuoi Appunti
      </h2>
      
      <!-- Griglia degli appunti -->
      <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
        <!-- Appunti dinamici -->
        <div 
          v-for="note in notes" 
          :key="note.id"
          class="note-card p-6"
          @mouseenter="onCardHover"
          @mouseleave="onCardLeave"
        >
          <div class="flex items-start justify-between mb-3">
            <div class="sketch-icon text-3xl">{{ note.icon }}</div>
            <span class="text-xs text-gray-500 bg-gray-100 px-2 py-1 rounded">{{ note.type }}</span>
          </div>
          <h3 class="text-xl font-bold text-gray-800 mb-2 font-sketch">
            {{ note.title }}
          </h3>
          <p class="text-gray-600 text-sm mb-3 italic font-shadows">
            "{{ note.description }}"
          </p>
          <div class="flex items-center justify-between text-xs text-gray-500 mb-4">
            <span>📅 {{ note.date }}</span>
            <span>📄 {{ note.pages }} pagine</span>
          </div>
          <div class="flex gap-2">
            <button 
              class="btn-sketch px-3 py-1 text-sm flex-1 hover:bg-blue-50"
              @click="viewNote(note)"
            >
              👁️ Visualizza
            </button>
            <button 
              class="btn-sketch px-3 py-1 text-sm flex-1 hover:bg-green-50"
              @click="downloadNote(note)"
            >
              ⬇️ Scarica
            </button>
          </div>
        </div>

        <!-- Card per aggiungere nuovi appunti -->
        <div class="note-card p-6 border-dashed border-gray-400 bg-gray-50 flex flex-col items-center justify-center text-center min-h-[250px]">
          <div class="sketch-icon text-4xl mb-3 opacity-60">➕</div>
          <h3 class="text-lg font-semibold text-gray-600 mb-2 font-architect">
            Aggiungi Appunto
          </h3>
          <p class="text-sm text-gray-500 mb-4 font-sketch">
            Carica un nuovo file per condividere i tuoi appunti
          </p>
          <button 
            class="btn-sketch px-4 py-2 text-sm font-semibold text-gray-700 hover:bg-white font-architect"
            @click="selectFiles"
          >
            📤 Carica File
          </button>
        </div>
      </div>
    </main>

    <!-- Footer -->
    <footer class="border-t-2 border-gray-300 mt-12 py-6 text-center">
      <div class="max-w-4xl mx-auto px-6">
        <p class="text-gray-600 italic font-shadows">
          ✏️ Fatto con ❤️ per condividere la conoscenza • 
          <span class="writing-animation inline-block">Buono studio!</span>
        </p>
      </div>
    </footer>

    <!-- Input file nascosto -->
    <input 
      ref="fileInput"
      type="file"
      multiple
      accept=".pdf,.docx,.txt,.md"
      class="hidden"
      @change="handleFileSelect"
    >
  </div>
</template>

<script setup>
// Dati reattivi
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

const fileInput = ref(null)

// Metodi per gestire i file
const selectFiles = () => {
  fileInput.value?.click()
}

const handleFileSelect = (event) => {
  const files = Array.from(event.target.files)
  console.log('File selezionati:', files)
  // Qui integrerai con Supabase per l'upload
  alert(`${files.length} file selezionati!`)
}

// Gestione drag & drop
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
  console.log('File droppati:', files)
  alert(`${files.length} file caricati!`)
}

// Gestione hover delle card
const onCardHover = (event) => {
  event.currentTarget.style.transform = 'rotate(0deg) scale(1.02)'
}

const onCardLeave = (event) => {
  const rotation = Math.random() * 0.6 - 0.3 // Random tra -0.3 e 0.3
  event.currentTarget.style.transform = `rotate(${rotation}deg) scale(1)`
}

// Azioni sui documenti
const viewNote = (note) => {
  console.log('Visualizza:', note.title)
  // Qui integrerai la visualizzazione PDF/documento
  alert(`Visualizzando: ${note.title}`)
}

const downloadNote = (note) => {
  console.log('Scarica:', note.title)
  // Qui integrerai il download da Supabase
  alert(`Scaricando: ${note.title}`)
}

// SEO e Meta
useHead({
  title: 'I Miei Appunti Universitari',
  meta: [
    { name: 'description', content: 'Condividi i tuoi appunti universitari con stile sketch su carta' }
  ]
})
</script>

<style>
/* Font Google Fonts (da configurare in nuxt.config.ts) */
.font-sketch {
  font-family: 'Caveat', cursive;
}

.font-marker {
  font-family: 'Permanent Marker', cursive;
}

.font-architect {
  font-family: 'Architects Daughter', cursive;
}

.font-shadows {
  font-family: 'Shadows Into Light', cursive;
}

/* Texture carta */
.paper-texture {
  background-color: #fefdf8;
  background-image: 
    radial-gradient(circle at 25px 25px, rgba(200,200,200,0.1) 1px, transparent 1px),
    radial-gradient(circle at 75px 75px, rgba(200,200,200,0.05) 1px, transparent 1px);
  background-size: 100px 100px;
  position: relative;
}

.paper-texture::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-image: 
    repeating-linear-gradient(
      0deg,
      transparent,
      transparent 24px,
      rgba(200,200,200,0.1) 25px,
      rgba(200,200,200,0.1) 26px
    );
  pointer-events: none;
}

/* Bordi disegnati a mano */
.sketch-border {
  border: 2px solid #4a4a4a;
  border-radius: 8px;
  position: relative;
  background: #fefdf8;
}

.sketch-border::before {
  content: '';
  position: absolute;
  top: -2px;
  left: -2px;
  right: -2px;
  bottom: -2px;
  border: 2px solid #4a4a4a;
  border-radius: 8px;
  transform: rotate(0.5deg);
  z-index: -1;
}

/* Card degli appunti con effetto sketch */
.note-card {
  background: #fefdf8;
  border: 2px solid #4a4a4a;
  border-radius: 8px;
  position: relative;
  transform: rotate(-0.5deg);
  transition: all 0.3s ease;
  box-shadow: 3px 3px 0px rgba(0,0,0,0.1);
  cursor: pointer;
}

.note-card:hover {
  transform: rotate(0deg) scale(1.02);
  box-shadow: 5px 5px 0px rgba(0,0,0,0.15);
}

.note-card:nth-child(even) {
  transform: rotate(0.3deg);
}

.note-card:nth-child(odd) {
  transform: rotate(-0.3deg);
}

/* Bottoni sketch */
.btn-sketch {
  background: #fefdf8;
  border: 2px solid #4a4a4a;
  border-radius: 6px;
  position: relative;
  transition: all 0.2s ease;
  transform: rotate(-0.2deg);
  cursor: pointer;
}

.btn-sketch:hover {
  transform: rotate(0deg) translateY(-1px);
  box-shadow: 2px 3px 0px rgba(0,0,0,0.2);
}

/* Titoli con sottolineatura disegnata a mano */
.sketch-underline {
  position: relative;
}

.sketch-underline::after {
  content: '';
  position: absolute;
  bottom: -4px;
  left: 0;
  width: 100%;
  height: 3px;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 10'%3E%3Cpath d='M0,5 Q25,2 50,5 T100,5' stroke='%234a4a4a' stroke-width='2' fill='none'/%3E%3C/svg%3E");
  background-repeat: repeat-x;
}

/* Icone disegnate a mano */
.sketch-icon {
  filter: drop-shadow(1px 1px 0px rgba(0,0,0,0.3));
}

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

/* Animazione scrittura */
@keyframes writing {
  from { width: 0; }
  to { width: 100%; }
}

.writing-animation {
  overflow: hidden;
  border-right: 2px solid #4a4a4a;
  animation: writing 2s steps(40, end), blink-caret 0.75s step-end infinite;
}

@keyframes blink-caret {
  from, to { border-color: transparent; }
  50% { border-color: #4a4a4a; }
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .note-card {
    transform: rotate(0deg);
  }
  
  .note-card:nth-child(even),
  .note-card:nth-child(odd) {
    transform: rotate(0deg);
  }
}
</style>