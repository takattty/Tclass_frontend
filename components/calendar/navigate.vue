<template>
  <div class="navigate">
    <div class="navigateComponent">
      <div class="navigateLeft">
        <v-btn @click="Home">Home</v-btn>
        <v-btn @click="ReportIndex">課題一覧</v-btn>
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
    Home() {
      const userStatus = this.$store.state.authenticate.loginauth.userAuth
        .status
      this.$router.push({ path: `/${userStatus}` })
    },
    ReportIndex() {
      const userStatus = this.$store.state.authenticate.loginauth.userAuth
        .status
      this.$router.push({ path: `/${userStatus}/reportindex` })
    },
    AccountContent() {
      const userId = this.$store.state.authenticate.loginauth.userAuth.userId
      const userStatus = this.$store.state.authenticate.loginauth.userAuth
        .status
      this.$router.push({ path: `/${userStatus}/account/${userId}` })
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
