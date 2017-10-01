$(document).ready(function() {
  $('.number-field').on('focus', function() {
    $(this).keyup(function() {
      const element = $(this)
      const value = parseInt(element.val())

      if (value > 0) {
        element.removeClass('negative')
        element.addClass('positive')
      } else if (value < 0) {
        element.removeClass('positive')
        element.addClass('negative')
      } else {
        element.removeClass('positive')
        element.removeClass('negative')
      }
    })
  })
})
