<template>
  <div class="attendanceContent">
    <div class="AttendanceCard">
      <v-card class="mx-auto" width="1400">
        <div class="cardTitle"></div>
        <v-simple-table class="table">
          <template v-slot:default>
            <thead>
              <tr>
                <th class="text-left">教材名</th>
                <th class="text-left">回数制限</th>
                <th class="text-left">開始・終了時刻</th>
                <th class="text-left">出欠状態</th>
                <th class="text-left">出席ボタン</th>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="eachAttendance in attendances"
                :key="eachAttendance.text_id"
              >
                <td class="lessonattendances">
                  {{ eachAttendance.attendance_name }}
                </td>
                <td class="lessonattendance">{{ eachAttendance.limit }}</td>
                <td class="lessonattendances">
                  出席:{{ eachAttendance.attend_start_date }}~{{
                    eachAttendance.attend_finish_date
                  }}
                  遅刻:{{ eachAttendance.late_start_date }}~{{
                    eachAttendance.late_finish_date
                  }}
                  欠席:{{ eachAttendance.absence_start_date }}
                </td>
                <td class="lessonattendance">{{ eachAttendance.state }}</td>
                <td class="lessonattendance">
                  <v-btn
                    @click="
                      // eslint-disable-next-line prettier/prettier
                      attend(eachAttendance.attendance_id, eachAttendance.state)"
                    >出席</v-btn
                  >
                </td>
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
    attendances: [],
  }),
  async created() {
    const response = await this.$axios.$get(
      `/lesson/${this.$route.params.id}/attendance`
    )
    const attendanceArray = response.attendance_index
    this.attendances = attendanceArray
  },
  methods: {
    async attend(attendId, state) {
      if (state === '') {
        const attendUpdate = {
          attendance_update: {
            state: '出席',
          },
        }
        const response = await this.$axios.$put(
          `/lesson/${this.$route.params.id}/attendance/${attendId}`,
          attendUpdate
        )
        this.$router.push(`/student/lesson/${this.$route.params.id}/attendance`)
        // eslint-disable-next-line no-console
        console.log(response)
      } else {
        // eslint-disable-next-line no-console
        console.log('もうダメですよ')
      }
    },
  },
}
</script>

<style scoped>
.attendanceContent {
  text-align: center;
}

.lessonattendances {
  white-space: pre-wrap;
  word-wrap: break-word;
  text-align: left;
}
</style>
