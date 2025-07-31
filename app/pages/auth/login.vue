<script setup lang="ts">
const supabase = useSupabaseClient()
const email = ref('')
const isLoading = ref(false)
const isEmailSent = ref(false)
const error = ref('')

const signInWithOtp = async () => {
  if (!email.value) {
    error.value = 'Inserisci un indirizzo email valido'
    return
  }
  
  isLoading.value = true
  error.value = ''
  
  try {
    const { error: authError } = await supabase.auth.signInWithOtp({
      email: email.value,
      options: {
        emailRedirectTo: `${window.location.origin}/auth/confirm`
      }
    })
    
    if (authError) {
      error.value = authError.message
    } else {
      isEmailSent.value = true
    }
  } catch (err) {
    error.value = 'Errore durante l\'invio dell\'email'
  } finally {
    isLoading.value = false
  }
}

const resetForm = () => {
  isEmailSent.value = false
  email.value = ''
  error.value = ''
}
</script>

<template>
  <div class="flex justify-center">
    <div class="max-w-md w-full">
      <div class="login-card p-8">
        <!-- Success State -->
        <div v-if="isEmailSent" class="text-center space-y-6">
          <div class="sketch-emoji text-6xl animate-bounce">
            📧
          </div>
          <div class="space-y-4">
            <h2 class="text-2xl font-bold text-green-800 transform -rotate-1">
              Email Inviata! ✅
            </h2>
            <p class="text-gray-600">
              Controlla la tua casella di posta e clicca sul link per accedere
            </p>
            <div class="bg-green-50 border-2 border-dashed border-green-300 p-4 rounded-lg transform rotate-0.5">
              <p class="text-sm text-green-700">
                📧 Email inviata a: <strong>{{ email }}</strong>
              </p>
            </div>
          </div>
          <button 
            @click="resetForm"
            class="sketch-button-secondary w-full"
          >
            🔄 Invia un'altra email
          </button>
        </div>

        <!-- Login Form -->
        <div v-else class="space-y-6">
          <div class="text-center mb-6">
            <h2 class="text-2xl font-bold text-gray-800 transform -rotate-0.5">
              Accedi ai tuoi appunti ✏️
            </h2>
          </div>

          <!-- Error Message -->
          <div v-if="error" class="error-message">
            <div class="flex items-center space-x-2">
              <span class="text-xl">⚠️</span>
              <p class="font-sketch">{{ error }}</p>
            </div>
          </div>

          <!-- Email Input -->
          <div class="space-y-2">
            <label class="block text-sm font-bold text-gray-700 transform rotate-0.2">
              📧 Indirizzo Email
            </label>
            <input
              v-model="email"
              type="email"
              placeholder="la.tua.email@università.it"
              class="sketch-input"
              :disabled="isLoading"
              @keyup.enter="signInWithOtp"
              required
            />
          </div>

          <!-- Submit Button -->
          <button 
            @click="signInWithOtp"
            :disabled="isLoading || !email"
            class="sketch-button w-full btn-primary"
          >
            <span v-if="isLoading" class="flex items-center justify-center space-x-2">
              <div class="animate-spin text-xl">📝</div>
              <span>Invio in corso...</span>
            </span>
            <span v-else class="flex items-center justify-center space-x-2">
              <span>🚀</span>
              <span>Accedi con Email</span>
            </span>
          </button>

          <!-- Info -->
          <div class="bg-blue-50 border-2 border-dashed border-blue-300 p-4 rounded-lg transform -rotate-0.3">
            <div class="flex items-start space-x-3">
              <span class="text-xl">💡</span>
              <div class="text-sm text-blue-700">
                <p><strong>Come funziona:</strong></p>
                <ol class="list-decimal list-inside mt-2 space-y-1">
                  <li>Inserisci la tua email universitaria</li>
                  <li>Riceverai un link magico nella tua casella</li>
                  <li>Clicca sul link per accedere istantaneamente!</li>
                </ol>
              </div>
            </div>
          </div>
        </div>

        <!-- Footer -->
        <div class="mt-8 pt-6 border-t-2 border-dashed border-gray-400">
          <p class="text-center text-xs text-gray-500 italic">
            Problemi con l'accesso? 
            <a href="mailto:support@uninotes.com" class="sketch-link font-bold">
              📞 Contatta il supporto
            </a>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
/* Carta sketch style */
.login-card {
  background: #fefdf8;
  border: 3px solid #4a4a4a;
  border-radius: 12px;
  position: relative;
  transition: all 0.3s ease;
  box-shadow: 4px 4px 0px rgba(0,0,0,0.15), 
              8px 8px 0px rgba(0,0,0,0.05);
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

/* Input sketch style */
.sketch-input {
  width: 100%;
  padding: 12px 16px;
  border: 2px solid #4a4a4a;
  border-radius: 8px;
  background: #fefdf8;
  font-size: 16px;
  transform: rotate(-0.2deg);
  transition: all 0.2s ease;
  box-shadow: 2px 2px 0px rgba(0,0,0,0.1);
}

.sketch-input:focus {
  outline: none;
  transform: rotate(0deg) scale(1.02);
  box-shadow: 3px 3px 0px rgba(0,0,0,0.15);
  border-color: #2a2a2a;
}

.sketch-input:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

/* Button sketch style */
.sketch-button {
  width: 100%;
  padding: 14px 20px;
  border-radius: 8px;
  color: white;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
  transform: rotate(-0.3deg);
  transition: all 0.2s ease;
  box-shadow: 3px 3px 0px rgba(0,0,0,0.2);
}

.sketch-button:hover:not(:disabled) {
  transform: rotate(0deg) scale(1.02);
  box-shadow: 4px 4px 0px rgba(0,0,0,0.25);
}

.sketch-button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
  transform: rotate(-0.3deg);
}

.sketch-button-secondary {
  width: 100%;
  padding: 12px 20px;
  border: 2px solid #4a4a4a;
  border-radius: 8px;
  background: #fefdf8;
  color: #4a4a4a;
  font-size: 14px;
  font-weight: bold;
  cursor: pointer;
  transform: rotate(0.2deg);
  transition: all 0.2s ease;
  box-shadow: 2px 2px 0px rgba(0,0,0,0.1);
}

.sketch-button-secondary:hover {
  transform: rotate(0deg) scale(1.02);
  box-shadow: 3px 3px 0px rgba(0,0,0,0.15);
  background: #f5f3f0;
}

/* Error message */
.error-message {
  background: #fef2f2;
  border: 2px dashed #ef4444;
  border-radius: 8px;
  padding: 12px;
  color: #dc2626;
  transform: rotate(-0.2deg);
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
.-rotate-0\.2 { transform: rotate(-0.2deg); }
.-rotate-0\.3 { transform: rotate(-0.3deg); }
.-rotate-0\.5 { transform: rotate(-0.5deg); }
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
</style>
