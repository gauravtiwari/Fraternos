import Vue from 'vue/dist/vue.esm';
import vueEventCalendar from 'vue-event-calendar';

import MeetingsCalendar from '../components/meetings_calendar.vue'

Vue.use(vueEventCalendar, { locale: 'en', color: '#007bff' });

document.addEventListener('DOMContentLoaded', () => {
  const element = document.getElementById('meetings-calendar');

  if (element != null) {
    const meetings = JSON.parse(element.dataset.meetings)

    const eventCalendar = new Vue({
      el: element,
      data() {
        return { meetings }
      },
      template: '<meetings-calendar :meetings="meetings" />',
      components: { MeetingsCalendar },
    });
  }
});
