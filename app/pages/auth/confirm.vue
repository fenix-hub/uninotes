<script setup lang="ts">
const user = useSupabaseUser()
const redirectInfo = useSupabaseCookieRedirect()

watch(user, () => {
  if (user.value) {
    // Get redirect path, and clear it from the cookie
    const path = redirectInfo.pluck()
    // Redirect to the saved path, or fallback to home
    return navigateTo(path || '/') 
  }
}, { immediate: false })
</script>

<template>
  <div class="flex justify-center m-5">
    <div class="max-w-md w-full">
      <div class="confirm-card p-8 text-center">
        <!-- Sketch Icon -->
        <div class="sketch-emoji mb-6">
          🔐
        </div>

        <!-- Loading Animation con stile sketch
        <div class="mb-8">
          <div class="sketch-spinner mx-auto">
            <div class="spinner-inner"></div>
            <div class="spinner-dots">
              <div class="dot dot-1">📝</div>
              <div class="dot dot-2">📋</div>
              <div class="dot dot-3">✏️</div>
            </div>
          </div>
        </div> -->

        <!-- Main Message -->
        <div class="space-y-4 mb-8">
          <h2 class="text-2xl font-bold text-gray-800 transform -rotate-1">
            Conferma in corso...
          </h2>
          <p class="text-gray-600 italic transform rotate-0.5">
            "Stiamo verificando la tua identità e preparando i tuoi appunti"
          </p>
        </div>

        <!-- Progress Indicator sketch style -->
        <div class="flex justify-center space-x-4 mb-8">
          <div class="progress-dot">📚</div>
          <div class="progress-dot" style="animation-delay: 0.3s">🔍</div>
          <div class="progress-dot" style="animation-delay: 0.6s">✅</div>
        </div>

        <!-- Additional Info -->
        <div class="text-sm text-gray-600 space-y-2">
          <p class="transform rotate-0.3">✨ Questo processo richiede solo qualche secondo</p>
          <p class="transform -rotate-0.2"><strong>⚠️ Non chiudere questa finestra</strong></p>
        </div>

        <!-- Footer -->
        <div class="mt-8 pt-6 border-t-2 border-dashed border-gray-400">
          <p class="text-xs text-gray-500 italic">
            Problemi con l'accesso? 
            <NuxtLink to="/login" class="sketch-link font-bold">
              👈 Torna al login
            </NuxtLink>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
/* Carta sketch style */
.confirm-card {
  background: #fefdf8;
  border: 3px solid #4a4a4a;
  border-radius: 12px;
  position: relative;
  transform: rotate(-0.5deg);
  transition: all 0.3s ease;
  box-shadow: 4px 4px 0px rgba(0,0,0,0.15), 
              8px 8px 0px rgba(0,0,0,0.05);
}

.confirm-card:hover {
  transform: rotate(0deg) scale(1.01);
  box-shadow: 6px 6px 0px rgba(0,0,0,0.2), 
              12px 12px 0px rgba(0,0,0,0.08);
}

/* Emoji sketch icon */
.sketch-emoji {
  font-size: 4rem;
  animation: sketch-bounce 2s infinite;
  filter: sepia(0.3) contrast(1.2);
}

/* Underline sketch effect */
.sketch-underline {
  position: relative;
}

.sketch-underline::after {
  content: '';
  position: absolute;
  bottom: -4px;
  left: -5px;
  right: -5px;
  height: 3px;
  background: repeating-linear-gradient(
    90deg,
    #4a4a4a 0px,
    #4a4a4a 8px,
    transparent 8px,
    transparent 12px
  );
  transform: rotate(-0.3deg);
}

/* Spinner sketch style */
.sketch-spinner {
  width: 80px;
  height: 80px;
  position: relative;
}

.spinner-inner {
  width: 100%;
  height: 100%;
  border: 3px solid #e5e5e5;
  border-top: 3px solid #4a4a4a;
  border-radius: 50%;
  animation: sketch-spin 2s linear infinite;
  position: relative;
}

.spinner-inner::before {
  content: '';
  position: absolute;
  top: -3px;
  left: -3px;
  right: -3px;
  bottom: -3px;
  border-radius: 50%;
  border: 2px dashed #ccc;
  animation: sketch-spin 3s linear infinite reverse;
}

.spinner-dots {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

.dot {
  position: absolute;
  font-size: 1.2rem;
  animation: sketch-orbit 3s linear infinite;
}

.dot-1 { animation-delay: 0s; }
.dot-2 { animation-delay: 1s; }
.dot-3 { animation-delay: 2s; }

/* Progress dots */
.progress-dot {
  font-size: 1.5rem;
  animation: sketch-bounce 1.5s infinite;
  filter: sepia(0.2) contrast(1.1);
}

/* Link sketch style */
.sketch-link {
  color: #4a4a4a;
  text-decoration: underline;
  text-decoration-style: wavy;
  text-underline-offset: 3px;
  transition: all 0.2s ease;
}

.sketch-link:hover {
  color: #2a2a2a;
  transform: scale(1.05) rotate(-1deg);
  text-decoration-color: #666;
}

/* Utility rotations */
.rotate-0\.2 { transform: rotate(0.2deg); }
.rotate-0\.3 { transform: rotate(0.3deg); }
.rotate-0\.5 { transform: rotate(0.5deg); }
.-rotate-0\.2 { transform: rotate(-0.2deg); }
.-rotate-1 { transform: rotate(-1deg); }

/* Animazioni sketch */
@keyframes sketch-bounce {
  0%, 20%, 50%, 80%, 100% {
    transform: translateY(0) rotate(0deg);
  }
  40% {
    transform: translateY(-10px) rotate(2deg);
  }
  60% {
    transform: translateY(-5px) rotate(-1deg);
  }
}

@keyframes sketch-spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

@keyframes sketch-orbit {
  0% {
    transform: rotate(0deg) translateX(25px) rotate(0deg);
  }
  100% {
    transform: rotate(360deg) translateX(25px) rotate(-360deg);
  }
}
</style>
