<template>
  <div class="myreportContent">
    <v-app class="myreportCard">
      <v-card class="mx-auto" width="1400">
        <div class="cardTitle"></div>
        <v-simple-table class="table">
          <template v-slot:default>
            <thead>
              <tr>
                <th class="text-left">課題名</th>
                <th class="text-left">提出ファイル</th>
                <th class="text-left">添削ファイル</th>
                <th class="text-left">コメント</th>
                <th class="text-left">提出日</th>
                <th class="text-left">得点</th>
                <th class="text-left">記録</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="eachTask in tasks" :key="eachTask.task_id">
                <td class="lessontask">{{ taskName }}</td>
                <td class="lessontask">{{ eachTask.submitted_file }}</td>
                <td class="lessontask">{{ eachTask.correction_file }}</td>
                <td class="lessontask">{{ eachTask.comment }}</td>
                <td class="lessontask">{{ eachTask.submitted_date }}</td>
                <td class="lessontask">{{ eachTask.score }}</td>
                <td class="lessontask">
                  <v-dialog v-model="dialog" max-width="1200">
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn color="primary" dark v-bind="attrs" v-on="on"
                        >○</v-btn
                      >
                    </template>
                    <v-card>
                      <v-card-title class="headline"
                        >添削更新フォーム 【ユーザーID】{{
                          eachTask.user_id
                        }}
                        【講義名】 {{ taskName }}</v-card-title
                      >
                      <v-card-text class="cardForm">
                        <v-form
                          ref="form"
                          v-model="valid"
                          class="TaskUpdateForm"
                        >
                          <v-file-input
                            v-model="correction_file"
                            label="添削ファイル"
                          ></v-file-input>

                          <v-textarea
                            v-model="comment"
                            name="input-7-4"
                            label="コメント欄"
                          ></v-textarea>

                          <v-text-field
                            v-model="score"
                            label="点数 ○/○"
                          ></v-text-field>
                        </v-form>
                      </v-card-text>
                      <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn
                          color="green darken-1"
                          text
                          @click="dialog = false"
                          >取り消し</v-btn
                        >
                        <v-btn color="green darken-1" text @click="submit"
                          >送信</v-btn
                        >
                      </v-card-actions>
                    </v-card>
                  </v-dialog>
                </td>
              </tr>
            </tbody>
          </template>
        </v-simple-table>
      </v-card>
    </v-app>
  </div>
</template>

<script>
export default {
  layout: 'lesson',
  data: () => ({
    valid: false,
    tasks: [],
    reportId: null,
    taskName: '',
    dialog: false,
    correction_file: '',
    comment: '',
    score: '',
  }),
  async created() {
    const response = await this.$axios.$get(
      `/lesson/${this.$route.params.id}/report`
    )
    const taskArray = response.report_data.text_content
    this.tasks = taskArray
    // eslint-disable-next-line no-console
    for (let i = 0; i < taskArray.length; i++) {
      const taskObject = taskArray[i]
      this.reportId = taskObject.report_id
      // eslint-disable-next-line no-console
      // console.log(taskObject)
    }
    // eslint-disable-next-line no-console
    console.log(this.tasks)
    const lessonData = await this.$axios.$get(
      `/lesson/${this.tasks.lesson_id}/task/${this.reportId}`
    )
    const reportArray = lessonData.task_data.task_content
    for (let i = 0; i < reportArray.length; i++) {
      const reportObject = reportArray[i]
      this.taskName = reportObject.report_name
    }
    // eslint-disable-next-line no-console
    // console.log(reportArray)
  },
  methods: {
    submit() {
      this.dialog = false
      // eslint-disable-next-line no-console
      console.log('submit')
    },
  },
}
</script>

<style scoped>
.myreportContent {
  text-align: left;
}

.headline {
  border-bottom: solid thin;
  margin-bottom: 20px;
}
</style>
