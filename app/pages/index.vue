<template>
  <div class="min-h-screen bg-gradient-to-br from-amber-50 to-orange-100">
    <!-- Hero Section -->
    <section class="relative px-6 py-20">
      <div class="max-w-4xl mx-auto text-center">
        <!-- Main Title -->
        <h1 class="text-6xl md:text-7xl font-bold text-gray-800 mb-6 transform -rotate-1 sketch-border bg-white p-8 shadow-lg">
          📚 UniNotes
        </h1>
        
        <!-- Subtitle -->
        <div class="bg-yellow-200 p-6 transform rotate-1 sketch-border shadow-md mb-8 max-w-2xl mx-auto">
          <p class="text-xl md:text-2xl text-gray-700 font-medium">
            Condividi i tuoi appunti universitari con stile!
          </p>
        </div>

        <!-- Description -->
        <div class="bg-white p-8 sketch-border shadow-lg transform -rotate-0.5 mb-12">
          <p class="text-lg text-gray-600 leading-relaxed mb-4">
            UniNotes è nato con l'intento di <strong>condividere i miei appunti universitari</strong>, 
            e ho deciso di estenderlo a chiunque in maniera pubblica.
          </p>
          <p class="text-lg text-gray-600 leading-relaxed">
            È necessaria l'autenticazione per assicurarmi che non ci siano utilizzi scorretti 
            per il caricamento di contenuti indesiderati sia da parte di umani che di bot. 🤖
          </p>
        </div>

        <!-- CTA Buttons -->
        <div class="flex flex-col sm:flex-row gap-4 justify-center items-center">
          <NuxtLink 
            to="/notes" 
            class="bg-blue-500 hover:bg-blue-600 text-white px-8 py-4 rounded-lg font-medium text-lg transform hover:-rotate-1 transition-all duration-200 sketch-border shadow-lg hover:shadow-xl"
          >
            🔍 Esplora gli Appunti
          </NuxtLink>
          
          <NuxtLink 
            to="/auth/login" 
            class="bg-green-500 hover:bg-green-600 text-white px-8 py-4 rounded-lg font-medium text-lg transform hover:rotate-1 transition-all duration-200 sketch-border shadow-lg hover:shadow-xl"
          >
            ✨ Inizia Subito
          </NuxtLink>
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section class="px-6 py-16 bg-white/50">
      <div class="max-w-6xl mx-auto">
        <h2 class="text-4xl font-bold text-center text-gray-800 mb-12 transform rotate-0.5">
          ✨ Perché scegliere UniNotes?
        </h2>
        
        <div class="grid md:grid-cols-3 gap-8">
          <!-- Feature 1 -->
          <div class="bg-white p-6 sketch-border shadow-lg transform -rotate-1 hover:rotate-0 transition-transform duration-300">
            <div class="text-4xl mb-4">📝</div>
            <h3 class="text-xl font-bold text-gray-800 mb-3">Appunti di Qualità</h3>
            <p class="text-gray-600">
              Appunti universitari scritti con cura, organizzati per materia e facilmente consultabili.
            </p>
          </div>

          <!-- Feature 2 -->
          <div class="bg-white p-6 sketch-border shadow-lg transform rotate-1 hover:rotate-0 transition-transform duration-300">
            <div class="text-4xl mb-4">🤝</div>
            <h3 class="text-xl font-bold text-gray-800 mb-3">Condivisione Sicura</h3>
            <p class="text-gray-600">
              Sistema di autenticazione per garantire contenuti di qualità e prevenire spam.
            </p>
          </div>

          <!-- Feature 3 -->
          <div class="bg-white p-6 sketch-border shadow-lg transform -rotate-0.5 hover:rotate-0 transition-transform duration-300">
            <div class="text-4xl mb-4">🎨</div>
            <h3 class="text-xl font-bold text-gray-800 mb-3">Design Unico</h3>
            <p class="text-gray-600">
              Interfaccia con stile sketch su carta che rende lo studio più piacevole e creativo.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- How it Works Section -->
    <section class="px-6 py-16">
      <div class="max-w-4xl mx-auto">
        <h2 class="text-4xl font-bold text-center text-gray-800 mb-12 transform -rotate-0.5">
          🚀 Come funziona?
        </h2>
        
        <div class="space-y-8">
          <!-- Step 1 -->
          <div class="flex flex-col md:flex-row items-center gap-6">
            <div class="bg-blue-500 text-white w-16 h-16 rounded-full flex items-center justify-center text-2xl font-bold sketch-border shadow-lg transform -rotate-3">
              1
            </div>
            <div class="bg-white p-6 sketch-border shadow-lg flex-1 transform rotate-0.5">
              <h3 class="text-xl font-bold text-gray-800 mb-2">Registrati</h3>
              <p class="text-gray-600">Crea il tuo account in modo semplice e sicuro per accedere alla piattaforma.</p>
            </div>
          </div>

          <!-- Step 2 -->
          <div class="flex flex-col md:flex-row-reverse items-center gap-6">
            <div class="bg-green-500 text-white w-16 h-16 rounded-full flex items-center justify-center text-2xl font-bold sketch-border shadow-lg transform rotate-3">
              2
            </div>
            <div class="bg-white p-6 sketch-border shadow-lg flex-1 transform -rotate-0.5">
              <h3 class="text-xl font-bold text-gray-800 mb-2">Esplora</h3>
              <p class="text-gray-600">Cerca appunti per materia, corso o argomento. Trova esattamente quello che ti serve!</p>
            </div>
          </div>

          <!-- Step 3 -->
          <div class="flex flex-col md:flex-row items-center gap-6">
            <div class="bg-purple-500 text-white w-16 h-16 rounded-full flex items-center justify-center text-2xl font-bold sketch-border shadow-lg transform -rotate-2">
              3
            </div>
            <div class="bg-white p-6 sketch-border shadow-lg flex-1 transform rotate-1">
              <h3 class="text-xl font-bold text-gray-800 mb-2">Condividi</h3>
              <p class="text-gray-600">Carica i tuoi appunti e aiuta altri studenti. Insieme si impara meglio!</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Stats Section -->
    <section class="px-6 py-16 bg-gradient-to-r from-blue-50 to-purple-50">
      <div class="max-w-4xl mx-auto">
        <div class="grid md:grid-cols-3 gap-8 text-center">
          <div class="bg-white p-8 sketch-border shadow-lg transform -rotate-1">
            <div class="text-4xl font-bold text-blue-500 mb-2">📚</div>
            <div class="text-3xl font-bold text-gray-800 mb-1">500+</div>
            <div class="text-gray-600">Appunti Condivisi</div>
          </div>
          
          <div class="bg-white p-8 sketch-border shadow-lg transform rotate-1">
            <div class="text-4xl font-bold text-green-500 mb-2">👥</div>
            <div class="text-3xl font-bold text-gray-800 mb-1">150+</div>
            <div class="text-gray-600">Studenti Attivi</div>
          </div>
          
          <div class="bg-white p-8 sketch-border shadow-lg transform -rotate-0.5">
            <div class="text-4xl font-bold text-purple-500 mb-2">🎓</div>
            <div class="text-3xl font-bold text-gray-800 mb-1">25+</div>
            <div class="text-gray-600">Università</div>
          </div>
        </div>
      </div>
    </section>

    <!-- Final CTA -->
    <section class="px-6 py-20 text-center">
      <div class="max-w-2xl mx-auto">
        <div class="bg-gradient-to-r from-yellow-200 to-orange-200 p-8 sketch-border shadow-lg transform rotate-1">
          <h2 class="text-3xl font-bold text-gray-800 mb-4">
            Pronto a iniziare? 🎯
          </h2>
          <p class="text-lg text-gray-600 mb-6">
            Unisciti alla community di UniNotes e trasforma il tuo modo di studiare!
          </p>
          <NuxtLink 
            to="/auth/login" 
            class="inline-block bg-orange-500 hover:bg-orange-600 text-white px-8 py-4 rounded-lg font-bold text-lg transform hover:-rotate-1 transition-all duration-200 sketch-border shadow-lg hover:shadow-xl"
          >
            🚀 Inizia Ora - È Gratis!
          </NuxtLink>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { useHead } from '#imports'

useHead({
  title: 'UniNotes - Condividi i tuoi appunti universitari',
  meta: [
    { 
      name: 'description', 
      content: 'UniNotes è la piattaforma per condividere appunti universitari di qualità. Registrati gratuitamente e accedi a centinaia di appunti organizzati per materia.' 
    },
    { name: 'keywords', content: 'appunti universitari, condivisione, studio, università, notes, studenti' },
    { property: 'og:title', content: 'UniNotes - Condividi i tuoi appunti universitari' },
    { property: 'og:description', content: 'La piattaforma per condividere appunti universitari di qualità con un design unico sketch su carta.' },
    { property: 'og:type', content: 'website' }
  ]
})
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

/* Hover animations */
@keyframes float {
  0%, 100% { transform: translateY(0px) rotate(var(--rotate, 0deg)); }
  50% { transform: translateY(-5px) rotate(var(--rotate, 0deg)); }
}

.hover\:animate-float:hover {
  animation: float 2s ease-in-out infinite;
}
</style>
