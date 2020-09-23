<template>
  <div class="TextLayout">
    <div class="TextNavigate">
      <textNavigate />
    </div>
    <div class="TextContent">
      <nuxt />
    </div>
  </div>
</template>

<script>
import textNavigate from '~/components/text/navigate'
export default {
  components: {
    textNavigate,
  },
}
</script>

<style scoped>
.TextContent {
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
