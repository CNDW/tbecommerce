App.Cart = DS.Model.extend
  token: DS.attr 'string', defaultValue: null
  number: DS.attr 'string', defaultValue: null
  order_id: DS.attr 'number'
  order: (->
    @store.getById('order', @get('order_id'))
  ).property('order_id')

  hasOrder: Em.computed.notEmpty 'order_id'
  isCreated: Em.computed.notEmpty 'token'

  didCreate: ->
    unless @get('isCreated')
      @createOrder()

  createOrder: ->
    return if @get 'isCreated'
    self = this
    $.post 'api/orders', {}, (payload, status, xhr)->
      self.setProperties
        order_id: payload.id
        token: payload.token
        number: payload.number
      self.store.pushPayload 'order',
        order:
          id: payload.id
          token: payload.token
          number: payload.number
      self.save()

  fetchOrder: ->
    self = this
    $.ajax "api/orders/#{self.get('number')}",
      dataType: "json"
      data:
        order_token: self.get('token')
      success: (payload)->
        self.store.pushPayload 'order', {order: payload}
        order = self.store.getById 'order', payload.id
