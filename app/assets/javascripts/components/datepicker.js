document.addEventListener('DOMContentLoaded', function() {
  flatpickr('[data-datepicker]', {
    inline: true,
    onChange(selectedDates) {
      this.element.children.date.value = selectedDates[0]
    }
  })

  flatpickr('[data-multi-datepicker]', {
    inline: true,
    mode: 'multiple',
    onChange(selectedDates) {
      this.element.children.dates.value = selectedDates.join(', ')
    }
  })
})
