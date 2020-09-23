<template>
  <div class="AccountContent">
    <div class="Account">
      <h1>ユーザー名</h1>
      <p>{{ dataContent.user_name }}</p>
    </div>
    <div class="Account">
      <h1>ユーザーメールアドレス</h1>
      <p>{{ dataContent.email }}</p>
    </div>
    <div class="Account">
      <h1>パスワード</h1>
      <p>秘密です。見れないです。すみません。</p>
    </div>
  </div>
</template>

<script>
export default {
  layout: 'auth',
  async asyncData({ $axios, store }) {
    const { data } = await $axios.get(
      `/auth/account/${store.state.authenticate.loginauth.userAuth.userId}`
    )
    return { dataContent: data.data }
  },
}
</script>

<style scoped>
.AccountContent {
  text-align: center;
  width: 1000px;
}

.Account {
  padding: 20px;
}

h1 {
  text-decoration: underline;
  text-decoration-color: aqua;
  padding-bottom: 5px;
}

@media screen and (max-width: 500px) {
  .AccountContent {
    width: 250px;
  }
}
</style>
