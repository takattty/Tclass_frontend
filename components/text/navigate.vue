<template>
  <div calss="navigate">
    <div class="navigateComponent">
      <v-btn large @click="back">資料を閉じる</v-btn>
    </div>
  </div>
</template>

<script>
export default {
  methods: {
    back() {
      this.$router.back()
    },
  },
}
</script>

<style scoped>
.navigateComponent {
  height: 100px;
  display: flex;
  justify-content: center;
  align-items: center;
  padding-top: 20px;
}
</style>
