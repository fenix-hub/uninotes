<template>
  <div @click="$emit('addNote')"
    class="note-card p-6 border-dashed border-gray-400 bg-gray-50 flex flex-col items-center justify-center text-center min-h-[250px]">
    <div class="sketch-icon text-4xl mb-3 opacity-60">➕</div>
    <h3 class="text-lg font-semibold text-gray-600 mb-2 font-sketch">
      Aggiungi Appunto
    </h3>
    <p class="text-sm text-gray-500 mb-4 font-sketch">
      Carica un nuovo file per condividere i tuoi appunti
    </p>
  </div>
</template>

<script setup>
defineEmits(['addNote'])
</script>

<style scoped>
.note-card {
  background: #fefdf8;
  border: 2px solid #4a4a4a;
  border-radius: 8px;
  position: relative;
  transform: rotate(-0.5deg);
  transition: all 0.3s ease;
  box-shadow: 3px 3px 0px rgba(0, 0, 0, 0.1);
  cursor: pointer;
  height: 16rem;
  width: 16rem;
}
</style>