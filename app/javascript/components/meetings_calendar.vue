<template>
  <vue-event-calendar :events="meetings">
    <template slot-scope='props'>
        <div v-for='(event, index) in props.showEvents' class='event-item'>
            <div class='wrapper'>
              <a :href='event.link'>
                <h5 class='title'>{{index+1}}. {{event.title}}</h5>
              </a>
              <p class='time'>{{dateTimeFormatter(Date.parse(new Date(event.date)))}}</p>
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
    dateTimeFormatter(date) {
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

<style scoped>
  .event-item {
    padding: 5px 20px;
    margin-top: 15px;
    box-shadow: 0 3px 11px 2px rgba(0,0,0,.1);
    background-color: #fff;
    border-radius: 5px;
    color: #323232;
    position: relative;
    &:first-child{
      margin-top: 0;
    }

    .title {
      height: 40px;
      line-height: 20px !important;
      margin-top: 30px;
      font-size: 16px;
      border-bottom: none !important;
    }

    .time {
      position: absolute;
      right: 0;
      top: 0;
      color: #9b9b9b;
      font-size: 14px;
    }
  }
</style>