($ '#cancel_link').click (event) ->
  event.preventDefault()

  ($ '.no-objects-found').show()

  ($ '#new_product_mock_link').show()
  ($ '#product_mocks').html('')