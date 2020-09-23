<template>
  <v-app class="StudentContent">
    <v-row class="fill-height">
      <v-col>
        <v-sheet height="64">
          <v-toolbar flat color="white">
            <v-btn
              outlined
              class="mr-4"
              color="grey darken-2"
              @click="setToday"
            >
              Today
            </v-btn>
            <v-btn fab text small color="grey darken-2" @click="prev">
              <v-icon small>mdi-chevron-left</v-icon>
            </v-btn>
            <v-btn fab text small color="grey darken-2" @click="next">
              <v-icon small>mdi-chevron-right</v-icon>
            </v-btn>
            <v-toolbar-title v-if="$refs.calendar">
              {{ $refs.calendar.title }}
            </v-toolbar-title>
            <v-spacer></v-spacer>
            <v-menu bottom right>
              <template v-slot:activator="{ on, attrs }">
                <v-btn outlined color="grey darken-2" v-bind="attrs" v-on="on">
                  >
                  <span>{{ typeToLabel[type] }}</span>
                  <v-icon right>mdi-menu-down</v-icon>
                </v-btn>
              </template>
              <v-list>
                <v-list-item @click="type = 'day'">
                  <v-list-item-title>Day</v-list-item-title>
                </v-list-item>
                <v-list-item @click="type = 'week'">
                  <v-list-item-title>Week</v-list-item-title>
                </v-list-item>
                <v-list-item @click="type = 'month'">
                  <v-list-item-title>Month</v-list-item-title>
                </v-list-item>
              </v-list>
            </v-menu>
          </v-toolbar>
        </v-sheet>

        <v-sheet height="650">
          <v-calendar
            ref="calendar"
            v-model="focus"
            color="primary"
            :events="events"
            :event-color="getEventColor"
            :type="type"
            @click:event="showEvent"
            @click:more="viewDay"
            @click:date="viewDay"
            @change="updateRange"
          ></v-calendar>
          <v-menu
            v-model="selectedOpen"
            :close-on-content-click="false"
            :activator="selectedElement"
            offset-x
          >
            <v-card color="grey lighten-4" min-width="350px" flat>
              <v-toolbar :color="selectedEvent.color" dark app>
                <v-btn icon>
                  <v-icon>mdi-pencil</v-icon>
                </v-btn>
                <v-toolbar-title> {{ selectedEvent.name }}</v-toolbar-title>
                <v-spacer></v-spacer>
                <v-btn icon>
                  <v-icon>mdi-heart</v-icon>
                </v-btn>
                <v-btn icon>
                  <v-icon>mdi-dots-vertical</v-icon>
                </v-btn>
              </v-toolbar>
              <v-card-text>
                <span>{{ selectedEvent.details }}</span>
              </v-card-text>
              <v-card-actions>
                <v-btn text color="secondary" @click="selectedOpen = false">
                  Cancel
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-menu>
        </v-sheet>
      </v-col>
    </v-row>
  </v-app>
</template>

<script>
export default {
  layout: 'calendar',
  data: () => ({
    focus: '',
    type: 'month',
    typeToLabel: {
      month: 'Month',
      week: 'Week',
      day: 'Day',
    },
    selectedEvent: {},
    selectedElement: null,
    selectedOpen: false,
    events: [],
    colors: [
      'blue',
      'indigo',
      'deep-purple',
      'cyan',
      'green',
      'orange',
      'grey darken-1',
    ],
    names: [
      'Meeting',
      'Holiday',
      'PTO',
      'Travel',
      'Event',
      'Birthday',
      'Conference',
      'Party',
    ],
  }),
  mounted() {
    this.$refs.calendar.checkChange()
  },
  methods: {
    viewDay({ date }) {
      this.focus = date
      this.type = 'day'
    },
    getEventColor(event) {
      return event.color
    },
    setToday() {
      this.focus = ''
    },
    prev() {
      this.$refs.calendar.prev()
    },
    next() {
      this.$refs.calendar.next()
    },
    showEvent({ nativeEvent, event }) {
      const open = () => {
        this.selectedEvent = event
        this.selectedElement = nativeEvent.target
        setTimeout(() => (this.selectedOpen = true), 10)
      }
      if (this.selectedOpen) {
        this.selectedOpen = false
        setTimeout(open, 10)
      } else {
        open()
      }
      nativeEvent.stopPropagation()
    },
    // async setCalendar() {
    //   const userId = this.$store.state.authenticate.loginauth.userAuth.userId
    //   const { data } = await this.$axios.get(`/calendar/${userId}`)
    //   const calendarContent = []
    //   const scheduleLists = []
    //   const reportLists = []
    //   const newScheduleLists = []
    //   const newReportLists = []
    //   const lessonContent = data.calendar_content.lesson
    //   const scheduleContent = data.calendar_content.schedule
    //   const reportContent = data.calendar_content.report
    //   // eslint-disable-next-line no-console
    //   // console.log(scheduleContent)
    //   // "0": {}の形になっている。
    //   for (const k in scheduleContent) {
    //     scheduleLists.push(scheduleContent[k])
    //   }
    //   const scheduleList = scheduleLists.map((obj) => obj[0])
    //   // eslint-disable-next-line no-console
    //   // console.log(scheduleList)
    //   for (let i = 0; i < scheduleList.length; i++) {
    //     // eslint-disable-next-line no-console
    //     // console.log(scheduleList[i])
    //     const schedultObject = JSON.stringify(scheduleList[i])
    //     newScheduleLists.push(schedultObject)
    //   }
    //   // eslint-disable-next-line no-console
    //   // console.log(newScheduleLists)

    //   for (const k in reportContent) {
    //     reportLists.push(reportContent[k])
    //   }
    //   const reportList = reportLists.map((obj) => obj[0])
    //   for (let i = 0; i < reportList.length; i++) {
    //     const reportObject = JSON.stringify(reportList[i])
    //     newReportLists.push(reportObject)
    //   }
    //   // eslint-disable-next-line no-console
    //   // console.log(newReportLists)
    //   const calendarLists = newScheduleLists.concat(newReportLists)
    //   // eslint-disable-next-line no-console
    //   // console.log(calendarLists)
    //   // eslint-disable-next-line no-console
    //   // console.log(lessonContent)
    //   // eslint-disable-next-line no-console
    //   for (let i = 0; i < newScheduleLists.length; i++) {
    //     const allDay = this.rnd(0, 3) === 0
    //     const calendarString = calendarLists[i]
    //     const calendarObject = JSON.parse(calendarString)
    //     // eslint-disable-next-line no-console
    //     // console.log(calendarObject.schedule_start_date)
    //     // eslint-disable-next-line no-console
    //     // console.log(calendarLists)
    //     const scheduleStartDateString = JSON.stringify(
    //       calendarObject.schedule_start_date
    //     )
    //     const scheduleFinishDateString = JSON.stringify(
    //       calendarObject.schedule_finish_date
    //     )
    //     if (calendarObject.schedult_id !== false) {
    //       const lessonId = calendarObject.lesson_id
    //       const lessonName = lessonContent[lessonId]
    //       const scheduleStartString = scheduleStartDateString
    //       // .replace(/T/g, ' ')
    //       // .slice(0, -6)
    //       // .replace(/$/, '"')
    //       const schedultFinishString = scheduleFinishDateString
    //       // .replace(/T/g, ' ')
    //       // .slice(0, -6)
    //       // .replace(/$/, '"')
    //       // const scheduleStartDate = Date.parse(scheduleStartString)
    //       // const scheduleFinishDate = Date.parse(schedultFinishString)
    //       // eslint-disable-next-line no-console
    //       console.log(scheduleStartString, schedultFinishString)
    //       // const startDate = 'Wed Sep 02 2020 17:00:00 GMT+0900 (日本標準時)'
    //       // const finishDate = 'Wed Sep 02 2020 19:00:00 GMT+0900 (日本標準時)'
    //       calendarContent.push({
    //         name: lessonName,
    //         start: new Date(scheduleStartString),
    //         end: new Date(schedultFinishString),
    //         color: this.colors[1],
    //         details: lessonName,
    //       })
    //     } else {
    //       const reportStartDateString = JSON.stringify(
    //         calendarObject.report_start_date
    //       )
    //       const reportFinishDateString = JSON.stringify(
    //         calendarObject.report_finish_date
    //       )
    //       const reportStartString = reportStartDateString
    //       // .replace(/T/g, ' ')
    //       // .slice(0, -6)
    //       // .replace(/$/, '+09:00"')
    //       const reportFinishString = reportFinishDateString
    //       // .replace(/T/g, ' ')
    //       // .slice(0, -6)
    //       // .replace(/$/, '"')
    //       // const reportStartDate = Date.parse(reportStartString)
    //       // const reportFinishDate = Date.parse(reportFinishString)
    //       // eslint-disable-next-line no-console
    //       console.log(reportStartString, reportFinishString)
    //       // const startDate = 'Wed Sep 03 2020 17:00:00 GMT+0900 (日本標準時)'
    //       // const finishDate = 'Wed Sep 03 2020 18:00:00 GMT+0900 (日本標準時)'
    //       calendarContent.push({
    //         name: calendarObject.report_name,
    //         start: new Date(reportStartString),
    //         end: new Date(reportFinishString),
    //         color: this.colors[5],
    //         timed: !allDay,
    //         details: calendarObject.report_name,
    //       })
    //     }
    //   }
    updateRange({ start, end }) {
      const events = []
      const min = new Date(`${start.date}T00:00:00`)
      const max = new Date(`${end.date}T23:59:59`)
      const days = (max.getTime() - min.getTime()) / 86400000
      const eventCount = this.rnd(days, days + 20)
      for (let i = 0; i < eventCount; i++) {
        const allDay = this.rnd(0, 3) === 0
        const firstTimestamp = this.rnd(min.getTime(), max.getTime())
        const first = new Date(firstTimestamp - (firstTimestamp % 900000))
        const secondTimestamp = this.rnd(2, allDay ? 288 : 8) * 900000
        const second = new Date(first.getTime() + secondTimestamp)
        events.push({
          name: this.names[this.rnd(0, this.names.length - 1)],
          start: first,
          end: second,
          color: this.colors[this.rnd(0, this.colors.length - 1)],
          timed: !allDay,
          details: 'hello',
        })
      }
      this.events = events
    },
    rnd(a, b) {
      return Math.floor((b - a + 1) * Math.random()) + a
    },
  },
}
</script>

<style scoped>
.StudentContent {
  /* width: 100%; */
  display: flex;
  justify-content: center;
  text-align: center;
}
</style>
