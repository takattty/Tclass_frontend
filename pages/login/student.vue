<template>
  <div class="LoginForms">
    <v-form ref="form" v-model="valid" lazy-validation class="LoginForm">
      <v-text-field
        v-model="email"
        :rules="emailRules"
        label="E-mail"
        required
      ></v-text-field>

      <v-text-field
        v-model="password"
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
    email: '',
    emailRules: [
      (v) => !!v || 'E-mail is required',
      (v) => /.+@.+\..+/.test(v) || 'E-mail must be valid',
    ],
    password: '',
    show1: false,
    passwordRules: [(v) => !!v || 'password is required'],
  }),
  methods: {
    Login() {
      const LoginData = {
        auth: {
          email: this.email,
          password: this.password,
        },
      }
      this.$axios
        .post('http://localhost:3000/api/v1/auth/login', LoginData)
        .then((response) => {
          // eslint-disable-next-line no-console
          console.log(response)
        })
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
