import type { RedirectOptions } from "@nuxtjs/supabase";

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-27',
  css: [
    '~/assets/css/fonts.scss',
    '~/assets/css/selection.scss',
    '~/assets/css/palette.scss',
  ],
  modules: [
    '@nuxtjs/tailwindcss',
    '@nuxtjs/google-fonts',
    '@nuxtjs/supabase'
  ],
  supabase: {
    url: process.env.SUPABASE_URL,
    key: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
    redirect: true,
    redirectOptions: {
      login: "/auth/login",
      callback: "/auth/confirm",
      saveRedirectToCookie: true,
      exclude: ["/", "/auth/login", "/auth/confirm", "/notes"], // Exclude these paths from redirection
    } as RedirectOptions,
    clientOptions: {
      db: {
        schema: 'uninotes', // Specify the schema if needed
      }
    }
  },
  googleFonts: {
    families: {
      'Playwrite+IT+Moderna': [100, 200, 300, 400]
    }
  },
  components: true,
  devtools: { enabled: true },
  typescript: {
    strict: true,
    typeCheck: true
  }
})