<template>
  <div class="LessonLayout">
    <div class="LessonNavigate">
      <lessonNavigate />
    </div>
    <div class="LessonsContent">
      <v-card class="mx-auto" width="1400">
        <nuxt />
      </v-card>
    </div>
  </div>
</template>

<script>
import lessonNavigate from '~/components/lesson/navigate'
export default {
  components: {
    lessonNavigate,
  },
}
</script>

<style scoped>
.LessonsContent {
  display: flex;
  justify-content: center;
  align-items: center;
  padding-top: 20px;
}
</style>
