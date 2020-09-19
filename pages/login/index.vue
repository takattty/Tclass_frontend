<template>
  <div class="SelectLogin">
    <h1>ログインして下さい</h1>
    <div class="StudentOrTeacher">
      <v-btn class="SelectBotton" min-width="200" large to="/login/student" nuxt
        >生徒</v-btn
      >
      <v-btn class="SelectBotton" min-width="200" large to="/login/teacher" nuxt
        >先生</v-btn
      >
    </div>
  </div>
</template>

<script>
export default {
  layout: 'auth',
}
</script>

<style scoped>
.SelectLogin {
  text-align: center;
  width: 1000px;
}

h1 {
  padding: 20px;
}

.SelectBotton {
  margin: 10px;
}

.StudentOrTeacher {
  padding: 55px;
}
</style>
