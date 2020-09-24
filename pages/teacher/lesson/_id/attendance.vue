<template>
  <v-app class="AttendanceContent">
    <v-card class="mx-auto" width="1400">
      <div class="cardTitle">
        <v-simple-table class="table">
          <template v-slot:default>
            <thead>
              <tr>
                <th class="text-left">教材名</th>
                <th class="text-left">回数制限</th>
                <th class="text-left">出席</th>
                <th class="text-left">遅刻</th>
                <th class="text-left">欠席</th>
                <th class="text-left">合計</th>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="eachAttendance in attendances"
                :key="eachAttendance.text_id"
              >
                <td class="lessonattendance">
                  {{ eachAttendance.attendance_name }}
                </td>
                <td class="lessonattendance">{{ eachAttendance.limit }}</td>
                <td class="lessonattendance">{{ attendState }}</td>
                <td class="lessonattendance">{{ lateState }}</td>
                <td class="lessonattendance">{{ absenceState }}</td>
                <td class="lessonattendance">{{ totalState }}</td>
              </tr>
            </tbody>
          </template>
        </v-simple-table>
      </div>
    </v-card>
    <div class="expantionCard">
      <v-expansion-panels v-model="panel" :disabled="disabled">
        <v-expansion-panel>
          <v-expansion-panel-header class="panelTitle"
            >出席作成</v-expansion-panel-header
          >
          <v-expansion-panel-content class="panelContent">
            <v-card>
              <v-card-title class="headline">出席を作成する</v-card-title>
              <!-- ここがフォームの中身 -->
              <v-card-text class="cardForm">
                <v-form ref="form" v-model="valid" class="AaskUpdateForm">
                  <v-text-field
                    v-model="attendName"
                    label="教材名"
                  ></v-text-field>

                  <v-text-field
                    v-model="Times"
                    label="回数制限: 回"
                  ></v-text-field>

                  <v-text-field
                    v-model="attendStart"
                    label="出席開始時刻: YYYY-MM-DD HH:MM:SS"
                  ></v-text-field>

                  <v-text-field
                    v-model="attendFinish"
                    label="出席終了時刻: YYYY-MM-DD HH:MM:SS"
                  ></v-text-field>

                  <v-text-field
                    v-model="lateStart"
                    label="遅刻開始時刻: YYYY-MM-DD HH:MM:SS"
                  ></v-text-field>

                  <v-text-field
                    v-model="lateFinish"
                    label="遅刻終了時刻: YYYY-MM-DD HH:MM:SS"
                  ></v-text-field>

                  <v-text-field
                    v-model="absenceStart"
                    label="欠席時刻: YYYY-MM-DD HH:MM:SS"
                  ></v-text-field>
                </v-form>
              </v-card-text>

              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="primary" large @click="creatAttend">作成</v-btn>
              </v-card-actions>
            </v-card>
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels>
    </div>
  </v-app>
</template>

<script>
export default {
  layout: 'lesson',
  data: () => ({
    panel: [0, 1],
    disabled: false,
    readonly: false,
    valid: false,
    attendName: '',
    Times: null,
    attendStart: '',
    attendFinish: '',
    lateStart: '',
    lateFinish: '',
    absenceStart: '',
    attendances: [],
    attendState: 0,
    lateState: 0,
    absenceState: 0,
    totalState: 0,
  }),
  async created() {
    const response = await this.$axios.$get(
      `/lesson/${this.$route.params.id}/attendance`
    )
    const attendanceArray = response.attendance_index
    for (let i = 0; i < attendanceArray.length; i++) {
      const eachAttend = attendanceArray[i]
      if (eachAttend.state === '出席') {
        this.attendState = this.attendState + 1
      } else if (eachAttend.state === '遅刻') {
        this.lateState = this.lateState + 1
      } else if (eachAttend.state === '欠席') {
        this.absenceState = this.absenceState + 1
      }
    }
    this.totalState = this.attendState + this.lateState + this.absenceState
    this.attendances = attendanceArray
    // eslint-disable-next-line no-console
    console.log(attendanceArray)
  },
  methods: {
    async creatAttend() {
      const creatAttend = {
        attendance_create: {
          attendance_name: this.attendName,
          limit: this.Times,
          state: '',
          lesson_id: this.$route.params.id,
          attend_start_date: this.attendStart,
          attend_finish_date: this.attendFinish,
          late_start_date: this.lateStart,
          late_finish_date: this.lateFinish,
          absence_start_date: this.absenceStart,
        },
      }
      const response = await this.$axios.$post(
        `/lesson/${this.$route.params.id}/attendance`,
        creatAttend
      )
      if (response.status === 'SUCCESS') {
        const userStatus = this.$store.state.authenticate.loginauth.userAuth
          .status
        const lessonId = this.$route.params.id
        this.$router.push({
          path: `/${userStatus}/lesson/${lessonId}`,
        })
      }
      // eslint-disable-next-line no-console
      console.log(response)
    },
  },
}
</script>

<style scoped>
.AttendanceContent {
  text-align: center;
  width: 100%;
}

.panelTitle {
  border-bottom: solid #c0c0c0 thin;
}

.expantionCard {
  padding-top: 20px;
}

.panelContent {
  padding: 20px;
}

.lessonattendance {
  text-align: left;
}
</style>
