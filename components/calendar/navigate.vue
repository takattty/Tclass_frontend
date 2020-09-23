<template>
  <div class="navigate">
    <div class="navigateComponent">
      <div class="navigateLeft">
        <v-btn to="/student" nuxt>Home</v-btn>
        <v-btn to="/student/reportIndex" nuxt>課題一覧</v-btn>
      </div>
      <div class="navigateRight">
        <v-btn @click="AccountContent">ユーザ情報</v-btn>
        <v-btn @click="Logout">ログアウト</v-btn>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  methods: {
    AccountContent() {
      const userId = this.$store.state.authenticate.loginauth.userAuth.userId
      this.$router.push({ path: `/student/account/${userId}` })
    },
    async Logout() {
      const response = await this.$store.dispatch(
        'authenticate/loginauth/deleteInfo',
        { root: true }
      )
      // eslint-disable-next-line no-console
      console.log('Logout', response, this.$store.state.authenticate.loginauth)
      this.$router.push('/login')
    },
  },
}
</script>

<style scoped>
.navigate {
  height: 100px;
  border-bottom: thin outset;
}

.navigateLeft {
  float: left;
  padding: 30px 20px;
}

.navigateRight {
  float: right;
  padding: 30px 20px;
}
</style>
