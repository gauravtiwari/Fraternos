<template>
  <vue-event-calendar :events="meetings">
    <template slot-scope='props'>
        <div v-for='(event, index) in props.showEvents' class='event-item'>
            <div class='wrapper'>
              <a :href='event.link'>
                <h5 class='title' style='line-height: 20px; width: 80%; margin-top: 10px;'>{{index+1}}. {{event.title}}</h5>
              </a>
              <p class='time' style='position: absolute; top: 0; right: 0; padding-right: 5px;'>{{dateTimeFormatter(Date.parse(new Date(event.date)))}}</p>
            </div>
        </div>
      </template>
  </vue-event-calendar>
</template>

<script>
export default {
  props: {
    meetings: {
      type: Array,
      default: [],
    },
  },
  methods: {
    dateTimeFormatter: function(date) {
      if (!date || date == '') {
        return ''
      }

      date = new Date(date)
      if (!date || date.toUTCString() == 'Invalid Date') {
        return ''
      }

      return [date.getDate(), (date.getMonth() + 1), (date.getFullYear() + '').substr(4 - 2)].join('/')
    }
  }
}
</script>

<style>
</style>