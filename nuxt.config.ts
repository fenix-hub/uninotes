import type { RedirectOptions } from "@nuxtjs/supabase";

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-27',
  css: [
    '~/assets/css/fonts.scss',
    '~/assets/css/selection.scss',
  ],
  modules: [
    '@nuxtjs/tailwindcss',
    '@nuxtjs/google-fonts',
    '@nuxtjs/supabase'
  ],
  runtimeConfig: {
    public: {
      supabaseCallback: process.env.CONFIRM_REDIRECT_URL || '/confirm'
    }
  },
  supabase: {
    url: process.env.SUPABASE_URL,
    key: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
    redirect: true,
    redirectOptions: {
      login: "/auth/login",
      callback: "/auth/confirm",
      saveRedirectToCookie: true,
      exclude: ["/", "/login", "/register", "/confirm"], // Exclude these paths from redirection
    } as RedirectOptions
  },
  googleFonts: {
    families: {
      'Playwrite+Polska': [100, 200, 300, 400]
    }
  },
  components: true,
  devtools: { enabled: true }
})