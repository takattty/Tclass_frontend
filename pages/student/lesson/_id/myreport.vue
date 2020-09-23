<template>
  <div class="myreportContent">
    <div class="myreportCard">
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
              </tr>
            </tbody>
          </template>
        </v-simple-table>
      </v-card>
    </div>
  </div>
</template>

<script>
export default {
  layout: 'lesson',
  data: () => ({
    tasks: [],
    reportId: null,
    taskName: '',
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
}
</script>

<style scoped>
.myreportContent {
  text-align: center;
}
</style>
