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
    <v-app class="LessonCard">
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
                    v-model="cardTitle"
                    label="教材名"
                  ></v-text-field>

                  <v-text-field
                    v-model="textName"
                    label="回数制限: 回"
                  ></v-text-field>

                  <v-file-input
                    v-model="textFile"
                    label="教材ファイル"
                  ></v-file-input>

                  <v-row align="center">
                    <v-col cols="12">
                      <v-select
                        v-model="status"
                        :items="items"
                        :menu-props="{ top: true, offsetY: true }"
                        label="資料 or レポート"
                      ></v-select>
                    </v-col>
                  </v-row>

                  <v-text-field
                    v-model="textStartDate"
                    label="利用可能開始時刻: YYYY-MM-DD HH:MM:SS"
                  ></v-text-field>

                  <v-text-field
                    v-model="textFinishDate"
                    label="利用可能終了時刻: YYYY-MM-DD HH:MM:SS"
                  ></v-text-field>
                </v-form>
              </v-card-text>

              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="primary" large @click="creatText">作成</v-btn>
              </v-card-actions>
            </v-card>
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels>
    </v-app>
  </div>
</template>

<script>
export default {
  layout: 'lesson',
  data: () => ({
    texts: [],
    valid: false,
    cardTitle: '',
    textName: '',
    textFile: '',
    status: '',
    items: ['資料', 'レポート'],
    textStartDate: '',
    textFinishDate: '',
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
          path: `/teacher/lesson/${this.$route.params.id}/text/${textId}`,
        })
      } else if (textType === 'レポート') {
        this.$router.push({
          path: `/teacher/lesson/${this.$route.params.id}/task/${textId}`,
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
    creatText() {
      // eslint-disable-next-line no-console
      console.log('text created')
    },
  },
}
</script>

<style scoped>
.LessonContent {
  text-align: center;
}

.LessonCard {
  padding: 20px 0;
}
</style>
