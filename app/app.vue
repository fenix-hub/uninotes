<template>
  <div class="paper-texture min-h-screen flex flex-col font-sketch">
    <AppHeader />
    <main class="flex-1">
      <NuxtPage />
    </main>
    <AppFooter />
  </div>
</template>

<script setup>
// ...existing head setup if any (useHead)...
</script>

<style>
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