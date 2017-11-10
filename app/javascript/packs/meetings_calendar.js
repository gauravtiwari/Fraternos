import Vue from 'vue/dist/vue.esm';
import vueEventCalendar from 'vue-event-calendar';

import MeetingsCalendar from '../components/meetings_calendar.vue'

const localeCookie = document.cookie.match(new RegExp('locale=([^;]+)'))
const locale = localeCookie.length > 0 ? localeCookie[1] : 'en'

Vue.use(vueEventCalendar, { locale, color: '#007bff' });

document.addEventListener('DOMContentLoaded', () => {
  const element = document.getElementById('meetings-calendar');

  if (element != null) {
    const meetings = JSON.parse(element.dataset.meetings)

    const eventCalendar = new Vue({
      el: element,
      data: function() {
        return { meetings: meetings }
      },
      template: '<meetings-calendar :meetings="meetings" />',
      components: { MeetingsCalendar },
    });
  }
});
