<template>
  <div class="TaskLayout">
    <div class="TaskNavigate">
      <taskNavigate />
    </div>
    <div class="TaskContent">
      <nuxt />
    </div>
  </div>
</template>

<script>
import taskNavigate from '~/components/task/navigate'
export default {
  components: {
    taskNavigate,
  },
}
</script>

<style scoped>
.TaskContent {
  display: flex;
  justify-content: center;
  align-items: center;
  border-top: solid thin;
  margin-top: 20px;
}
</style>
