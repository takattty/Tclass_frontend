<template>
  <div class="reportIndex">
    <div class="reportCard">
      <v-card class="mx-auto" width="1400">
        <div class="cardTitle">
          <v-card-title> 課題一覧 </v-card-title>
        </div>
        <v-simple-table class="table">
          <template v-slot:default>
            <thead>
              <tr>
                <th class="text-left">課題名</th>
                <th class="text-left">提出期限</th>
                <th class="text-left">授業ID</th>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="eachReportObject in reports"
                :key="eachReportObject.id"
              >
                <td>
                  <router-link
                    :to="{
                      path: `/student/lesson/${eachReportObject.lesson_id}`,
                    }"
                  >
                    {{ eachReportObject.report_name }}
                  </router-link>
                </td>
                <td>{{ eachReportObject.report_finish_date }}</td>
                <td>{{ eachReportObject.lesson_id }}</td>
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
  layout: 'calendar',
  data: () => ({
    reports: [],
  }),
  async created() {
    const userId = this.$store.state.authenticate.loginauth.userAuth.userId
    const response = await this.$axios.$get(`/reportindex/${userId}`)
    const reportsObject = response.calendar.report
    const reportArrays = []
    for (const key1 in reportsObject) {
      const reportArray = reportsObject[key1]
      // eslint-disable-next-line no-console
      // console.log(reportArray)
      for (const key2 in reportArray) {
        const eachObject = reportArray[key2]
        // eslint-disable-next-line no-console
        // console.log(eachObject)
        reportArrays.push(eachObject)
      }
    }
    // eslint-disable-next-line no-console
    console.log(reportArrays)
    this.reports = reportArrays
  },
  methods: {
    moveClassPage(lessonId) {
      // eslint-disable-next-line no-console
      // console.log(lessonId)
    },
  },
}
</script>

<style scoped>
.cardTitle {
  border-bottom: solid #dddddd thin;
}

.reportCard {
  padding-bottom: 30px;
}
</style>
