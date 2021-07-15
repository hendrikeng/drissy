<template>
  <confetti />
</template>

<script lang="ts">
// Async load the Vue 3 APIs we need from the Vue ESM
import {defineAsyncComponent, defineComponent } from 'vue';

export default defineComponent({
  components: {
    'confetti': defineAsyncComponent(() => import(/* webpackChunkName: "confetti" */ '@/vue/Confetti.vue')),
  },
  data: () => ({
  }),
    // eslint-disable-next-line @typescript-eslint/no-empty-function
  mounted() {},
  methods: {
  },
});
</script>
