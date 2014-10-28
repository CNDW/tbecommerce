App.Cart = DS.Model.extend
  token: DS.attr 'string', defaultValue: null
  number: DS.attr 'string', defaultValue: null
  order: DS.belongsTo 'order', async: true

  hasOrder: Em.computed.notEmpty 'order_id'
  isCreated: Em.computed.notEmpty 'token'

  isUpdating: no

  didCreate: ->
    unless @get('isCreated')
      @createOrder()

  didLoad: ->
    @fetchOrder()

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
    return @get('order') if @get('order')
    @updateOrder()

  updateOrder: ->
    self = this
    @set('isUpdating', no)
    $.ajax "api/orders/#{self.get('number')}",
      dataType: "json"
      data:
        order_token: self.get('token')
      success: (payload)->
        self.store.pushPayload 'order', {order: payload}
        self.set('isUpdating', no)
        return payload
      error: ->
        self.set('isUpdating', no)
        return arguments