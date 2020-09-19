<template>
  <div class="AuthLayout">
    <v-card class="mx-auto" max-width="1000">
      <nuxt />
    </v-card>
  </div>
</template>

<style scoped>
.AuthLayout {
  display: flex;
  justify-content: center;
  align-items: center;
  padding-top: 100px;
}

@media screen and (max-width: 500px) {
  .AuthLayout {
    padding-top: 50px;
  }
}
</style>
