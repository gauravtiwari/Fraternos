$(document).ready(function() {
  $('[data-multi-datepicker]').datepicker({ multidate: true })
  $('[data-multi-datepicker]').on('changeDate', function(event) {
    $('#dates').val(event.dates.join(', '))
  })

  $('[data-datepicker]').datepicker()
  $('[data-datepicker]').on('changeDate', function(event) {
    $('#date').val(event.date)
  })
})
