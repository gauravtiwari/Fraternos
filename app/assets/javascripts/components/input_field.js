document.addEventListener('DOMContentLoaded', function() {
  const transactionFields = Array.from(document.querySelectorAll('[data-transaction-field]'))

  transactionFields.forEach((transactionField) => {
    transactionField.addEventListener('keyup', function() {
      const value = parseInt(this.value)

      if (value > 0) {
        this.classList.remove('negative')
        this.classList.add('positive')
      } else if (value < 0) {
        this.classList.remove('positive')
        this.classList.add('negative')
      } else {
        this.classList.remove('positive', 'negative')
      }
    })
  })
})
