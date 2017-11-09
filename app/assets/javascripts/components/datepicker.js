document.addEventListener('DOMContentLoaded', function() {
  const localeCookie = document.cookie.match(new RegExp('locale=([^;]+)'))
  const locale = (localeCookie != undefined && localeCookie.length > 0) ? localeCookie[1] : 'en'

  flatpickr('[data-datepicker]', {
    locale: locale,
    inline: true,
    onChange: function(selectedDates) {
      this.element.children.date.value = selectedDates[0]
    }
  })

  flatpickr('[data-multi-datepicker]', {
    locale: locale,
    inline: true,
    mode: 'multiple',
    onChange: function(selectedDates) {
      this.element.children.dates.value = selectedDates.join(', ')
    }
  })
})
