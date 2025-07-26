// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  modules: [
    '@nuxtjs/tailwindcss',
    '@nuxtjs/google-fonts'
  ],
  googleFonts: {
    families: {
      Caveat: [300, 400, 500, 600, 700],
      'Permanent+Marker': true,
      'Architects+Daughter': true,
      'Shadows+Into+Light': true
    }
  },
  devtools: { enabled: true }
})