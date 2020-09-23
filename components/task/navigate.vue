<template>
  <div calss="navigate">
    <div class="navigateComponent">
      <div class="backBotton">
        <v-btn @click="back">資料を閉じる</v-btn>
      </div>
      <div class="fileInput">
        <input name="submitFile" type="file" @change="selectedFile" />
      </div>
      <div class="submitBotton">
        <v-btn @click="Submit">提出</v-btn>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data: () => ({
    pdf_file: '',
  }),
  methods: {
    back() {
      this.$router.back()
    },
    selectedFile(e) {
      // eslint-disable-next-line no-console
      console.log(e)
    },
    Submit() {
      // eslint-disable-next-line no-console
      console.log('Submitted!')
    },
  },
}
</script>

<style scoped>
.navigate {
  height: 150px;
  border: solid thin;
}

.navigateComponent {
  display: flex;
  justify-content: space-around;
  padding-top: 30px;
}

.fileInput {
  padding-top: 10px;
}
</style>
