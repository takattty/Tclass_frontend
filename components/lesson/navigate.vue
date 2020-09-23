<template>
  <div class="navigate">
    <div class="navigateComponent">
      <v-btn id="navBtn" large :to="`/student/lesson/${this.$route.params.id}`"
        >Home</v-btn
      >
      <v-btn id="navBtn" large>{{ lessonName }}</v-btn>
      <v-btn id="navBtn" large>教材</v-btn>
      <v-btn id="navBtn" large>レポート</v-btn>
      <v-btn id="navBtn" large>出欠</v-btn>
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
    console.log(textLessonName.name.card_title)
    this.lessonName = lessonsName
  },
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
