<template>
  <div class="LessonContent">
    <h1>Hey</h1>
  </div>
</template>

<script>
export default {
  layout: 'lesson',
  async created() {
    const response = await this.$axios.$get(`/lesson/${this.$route.params.id}`)
    // eslint-disable-next-line no-console
    console.log(response)
  },
}
</script>

<style scoped>
.LessonContent {
  text-align: center;
}
</style>
