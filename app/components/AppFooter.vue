<template>
  <footer class="border-t-2 border-gray-500 border-dashed mt-12 py-6 text-center text-">
    <div class="max-w-4xl mx-auto px-6">
      <span class="text-gray-600 italic">
        ✏️ Fatto con ❤️ per condividere la conoscenza •
        Buono studio!
        • <a href="https://nicolosantilio.it">
          <span class="text-blue-600 hover:underline">Nicolò Santilio</span>
        </a>
      </span>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'AppFooter',
}
</script>

<style scoped>
footer {
  width: 100%;
  bottom: 0;
  left: 0;
  background: #fefdf8;
}

.writing-animation {
  overflow: hidden;
  border-right: 2px solid #4a4a4a;
  padding-right: 5px;
  /* animation: blink-caret 0.75s step-end infinite; */
  /* animation: writing 4s steps(30, end) infinite; */
}

@keyframes writing {
  from {
    width: 0;
  }

  to {
    width: 100%;
  }
}

@keyframes blink-caret {

  from,
  to {
    border-color: transparent;
  }

  50% {
    border-color: #4a4a4a;
  }
}
</style>
