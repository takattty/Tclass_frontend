<template>
  <div class="LessonContent">
    <div class="LessonCard">
      <v-card class="mx-auto" width="1400">
        <div class="cardTitle">
          <v-card-title> 教材一覧 </v-card-title>
        </div>
        <v-simple-table class="table">
          <template v-slot:default>
            <thead>
              <tr>
                <th class="text-left">教材名</th>
                <th class="text-left">利用可能期間</th>
                <th class="text-left">利用回数</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="eachText in texts" :key="eachText.text_id">
                <td
                  class="lessontext"
                  @click="
                    moveInspect(
                      eachText.text_type,
                      eachText.text_id,
                      eachText.text_times
                    )
                  "
                >
                  {{ eachText.text_name }} -{{ eachText.text_type }}
                </td>
                <td class="lessontext">
                  {{ eachText.text_start_date }} ~
                  {{ eachText.text_finish_date }}
                </td>
                <td class="lessontext">{{ eachText.text_times }}</td>
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
    texts: [],
  }),
  async created() {
    const response = await this.$axios.$get(`/lesson/${this.$route.params.id}`)
    const textArrays = response.text_data.text_content
    this.texts = textArrays
  },
  methods: {
    async moveInspect(textType, textId, textTimes) {
      if (textType === '資料') {
        this.$router.push({
          path: `/student/lesson/${this.$route.params.id}/text/${textId}`,
        })
      } else if (textType === 'レポート') {
        this.$router.push({
          path: `/student/lesson/${this.$route.params.id}/task/${textId}`,
        })
      }
      const textUpData = {
        text_times_update: {
          text_id: textId,
          text_times: textTimes + 1,
        },
      }
      // eslint-disable-next-line no-unused-vars
      const response = await this.$axios.$put(
        `/lesson/${this.$route.params.id}/text/${textId}`,
        textUpData
      )
      // eslint-disable-next-line no-console
      // console.log(response)
    },
  },
}
</script>

<style scoped>
.LessonContent {
  text-align: center;
  padding-top: 10px;
}
</style>
