<template>
  <div 
    class="note-card p-6 flex flex-col"
    :style="{ transform: `rotate(${rotation}deg)` }"
    @mouseenter="onCardHover"
    @mouseleave="onCardLeave"
    @click="$emit('view', note)"
    >
    <div class="flex items-start justify-between mb-3">
      <div class="sketch-icon text-3xl">{{ note.icon }}</div>
      <span class="text-xs text-gray-500 bg-gray-100 px-2 py-1 rounded font-tag">{{ note.type }}</span>
    </div>
    <h3 class="text-xl font-bold text-gray-800 mb-2 font-sketch">
      {{ note.title }}
    </h3>
    <p class="flex-1 text-gray-600 text-sm mb-3 italic font-sketch">
      "{{ note.description }}"
    </p>
    <div class="flex items-center justify-between text-xs text-gray-500">
      <span>📅 {{ note.date }}</span>
      <span>📄 {{ note.pages }} pagine</span>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const rotation = ref(0)
onMounted(() => {
  rotation.value = Math.random() * 2 - 1
})

defineProps({
  note: {
    type: Object,
    required: true
  }
})

defineEmits(['view', 'download'])


const onCardHover = (event) => {
  event.currentTarget.style.transform = 'rotate(0deg) scale(1.02)'
}

const onCardLeave = (event) => {
  event.currentTarget.style.transform = `rotate(${rotation.value}deg) scale(1)`
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
  height: 16rem;
  width: 16rem;
}

.note-card:hover {
  box-shadow: 5px 5px 0px rgba(0,0,0,0.15);
}
</style>