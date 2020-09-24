<template>
  <div class="navigate">
    <div class="navigateComponent">
      <v-btn id="navBtn" large @click="ReportIndex">全課題一覧</v-btn>
      <v-btn id="navBtn" large>{{ lessonName }}</v-btn>
      <v-btn id="navBtn" large @click="Text">教材</v-btn>
      <v-btn id="navBtn" large @click="Task">【{{ lessonName }}】課題</v-btn>
      <v-btn id="navBtn" large @click="Attend">出欠</v-btn>
      <v-btn id="navBtn" large @click="AccountContent">ユーザー情報</v-btn>
      <v-btn id="navBtn" large @click="Logout">ログアウト</v-btn>
    </div>
  </div>
</template>

<script>
export default {
  data: () => ({
    lessonName: '',
  }),
  async created() {
    const response = await this.$axios.$get(`/lesson/${this.$route.params.id}`)
    const textArrays = response.text_data.text_content
    const textLessonName = {}
    for (let i = 0; i < textArrays.length; i++) {
      const textObject = textArrays[i]
      textLessonName.name = textObject
    }
    const lessonsName = textLessonName.name.card_title
    // eslint-disable-next-line no-console
    // console.log(textLessonName.name.card_title)
    this.lessonName = lessonsName
  },
  methods: {
    ReportIndex() {
      const userStatus = this.$store.state.authenticate.loginauth.userAuth
        .status
      this.$router.push({ path: `/${userStatus}/reportindex` })
    },
    Text() {
      const userStatus = this.$store.state.authenticate.loginauth.userAuth
        .status
      const lessonId = this.$route.params.id
      this.$router.push({ path: `/${userStatus}/lesson/${lessonId}` })
    },
    Task() {
      const userStatus = this.$store.state.authenticate.loginauth.userAuth
        .status
      const lessonId = this.$route.params.id
      this.$router.push(`/${userStatus}/lesson/${lessonId}/myreport`)
    },
    Attend() {
      const userStatus = this.$store.state.authenticate.loginauth.userAuth
        .status
      const lessonId = this.$route.params.id
      this.$router.push(`/${userStatus}/lesson/${lessonId}/attendance`)
    },
    AccountContent() {
      const userStatus = this.$store.state.authenticate.loginauth.userAuth
        .status
      const userId = this.$store.state.authenticate.loginauth.userAuth.userId
      this.$router.push({ path: `/${userStatus}/account/${userId}` })
    },
    async Logout() {
      // eslint-disable-next-line no-unused-vars
      const response = await this.$store.dispatch(
        'authenticate/loginauth/deleteInfo',
        { root: true }
      )
      // eslint-disable-next-line no-console
      // console.log('Logout', response, this.$store.state.authenticate.loginauth)
      this.$router.push('/login')
    },
  },
}
</script>

<style scoped>
.navigate {
  height: 100px;
  border-bottom: thin outset;
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: space-around;
}

#navBtn {
  margin-top: 30px;
  padding: 0px 60px;
}
</style>
