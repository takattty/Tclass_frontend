<template>
  <v-app class="AttendanceContent">
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
                  v-model="attendTimes"
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
    attendTimes: null,
    attendStart: '',
    attendFinish: '',
    lateStart: '',
    lateFinish: '',
    absenceStart: '',
  }),
  methods: {
    async creatAttend() {
      const creatAttend = {
        attendance_create: {
          attendance_name: this.attendName,
          limit: this.attendTimes,
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

.panelContent {
  padding-top: 20px;
}
</style>
