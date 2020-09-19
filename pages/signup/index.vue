<template>
  <div class="SignupOrLogin">
    <div class="CreateAccount">
      <h1>アカウントの新規作成</h1>
      <v-btn large to="/signup/new" nuxt>サインアップ</v-btn>
    </div>
    <div class="Login">
      <h1>アカウントをお持ちの方</h1>
      <v-btn large to="/login" nuxt>ログイン</v-btn>
    </div>
  </div>
</template>

<script>
export default {
  layout: 'auth',
}
</script>

<style scoped>
.SignupOrLogin {
  text-align: center;
  width: 1000px;
}

.CreateAccount {
  padding: 45px;
}

.Login {
  padding: 45px;
}

h1 {
  padding-bottom: 20px;
}

@media screen and (max-width: 500px) {
  .CreateAccount {
    padding: 10px;
  }

  .Login {
    padding: 10px;
  }
}
</style>
