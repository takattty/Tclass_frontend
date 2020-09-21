<template>
  <div class="LoginForms">
    <v-form ref="form" v-model="valid" lazy-validation class="LoginForm">
      <v-text-field
        v-model="login.auth.email"
        :rules="emailRules"
        label="E-mail"
        required
      ></v-text-field>

      <v-text-field
        v-model="login.auth.password"
        :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
        :type="show1 ? 'text' : 'password'"
        :rules="passwordRules"
        name="input-10-1"
        label="password"
        counter
        @click:append="show1 = !show1"
      ></v-text-field>

      <v-btn large @click="Login">ログイン</v-btn>
    </v-form>
  </div>
</template>

<script>
export default {
  layout: 'auth',
  data: () => ({
    valid: true,
    login: {
      auth: {
        email: '',
        password: '',
      },
    },
    // email: '',
    emailRules: [
      (v) => !!v || 'E-mail is required',
      (v) => /.+@.+\..+/.test(v) || 'E-mail must be valid',
    ],
    // password: '',
    show1: false,
    passwordRules: [(v) => !!v || 'password is required'],
  }),
  methods: {
    async Login() {
      // eslint-disable-next-line no-console
      console.log(this.login)
      const response = await this.$auth.loginWith('local', {
        data: this.login,
      })
      const jwtToken = response.data.jwt

      const userContent = await this.$axios.$get(`/auth/account/`, {
        params: { email: this.login.auth.email },
      })
      // eslint-disable-next-line no-console
      console.log(userContent.data[0], jwtToken)
      const userInfo = userContent.data[0]
      const userId = userInfo.user_id
      const status = userInfo.account_status
      // eslint-disable-next-line no-console
      console.log(userId, status)

      const userAuth = {
        jwtToken,
        userId,
        status,
      }

      this.$store.dispatch('authenticate/loginauth/setInfo', userAuth, {
        root: true,
      })
      this.$router.push('/teacher')
      // eslint-disable-next-line no-console
      console.log(response, this.$auth.loggedIn, this.$store.state.authenticate)
    },
  },
}
</script>

<style scoped>
.LoginForms {
  text-align: center;
  width: 1000px;
}

.LoginForm {
  padding: 10px;
}

@media screen and (max-width: 500px) {
  .LoginForms {
    text-align: center;
    width: 360px;
  }
}
</style>
