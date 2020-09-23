<template>
  <div class="CalendarLayout">
    <div class="CalendarNavigate">
      <calendarNavigate />
    </div>
    <div class="CalendarContent">
      <v-card class="mx-auto" width="1400">
        <nuxt />
      </v-card>
    </div>
  </div>
</template>

<script>
import calendarNavigate from '~/components/calendar/navigate'
export default {
  components: {
    calendarNavigate,
  },
}
</script>

<style scoped>
.CalendarContent {
  display: flex;
  justify-content: center;
  align-items: center;
  padding-top: 20px;
}
</style>
