import { defineConfig } from 'vite'
import { svelte } from '@sveltejs/vite-plugin-svelte'

const production = false;

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [svelte({
    compilerOptions: {
      dev: !production,
      customElement: true,
    }
})],
  server: {
    port: 8087
  },
  preview: {
    port: 8086
  },
  build: {
    emptyOutDir: true,
    outDir: 'target',
    minify: production ? 'terser' : false,
    rollupOptions: {
        output: {
            assetFileNames: 'assets/[ext]/[name][extname]',
            chunkFileNames: 'assets/[chunks]/[name].[hash].js',
            entryFileNames: 'assets/js/bundle.js'
        }
    }
}
})
