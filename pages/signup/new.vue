<template>
  <div class="SignupForms" data-app>
    <!-- <v-app id="Login"> -->
    <v-form ref="form" v-model="valid" lazy-validation class="SignupForm">
      <v-text-field
        v-model="name"
        :rules="nameRules"
        label="Name"
        required
      ></v-text-field>

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

      <v-row align="center">
        <v-col cols="12">
          <v-select
            v-model="status"
            :items="items"
            :menu-props="{ top: true, offsetY: true }"
            label="your status"
          ></v-select>
        </v-col>
      </v-row>

      <v-btn large @click="Signup">新規登録</v-btn>
    </v-form>
  </div>
</template>

<script>
export default {
  layout: 'auth',
  data: () => ({
    valid: true,
    name: '',
    nameRules: [(v) => !!v || 'Name is required'],
    email: '',
    emailRules: [
      (v) => !!v || 'E-mail is required',
      (v) => /.+@.+\..+/.test(v) || 'E-mail must be valid',
    ],
    password: '',
    show1: false,
    passwordRules: [(v) => !!v || 'password is required'],
    status: '',
    items: ['student', 'teacher'],
  }),
  methods: {
    Signup() {
      const accountData = {
        account_create: {
          user_name: this.name,
          email: this.email,
          account_status: this.status,
          lesson_lists: '[]',
          password: this.password,
          password_confirmation: this.password,
        },
      }
      this.$axios
        .$post('http://localhost:3000/api/v1/auth/account', accountData)
        .then((response) => {
          // eslint-disable-next-line no-console
          console.log(response)
        })
    },
  },
}
</script>

<style scoped>
.SignupForms {
  text-align: center;
  width: 1000px;
}

.SignupForm {
  padding: 10px;
}

@media screen and (max-width: 500px) {
  .SignupForms {
    text-align: center;
    width: 360px;
  }
}
</style>
