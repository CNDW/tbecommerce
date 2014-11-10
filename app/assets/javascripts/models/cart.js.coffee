App.Cart = DS.Model.extend
  token: DS.attr 'string', defaultValue: null
  number: DS.attr 'string', defaultValue: null
  order_id: DS.attr 'string'
  order: (->
    @store.getById 'order', @get('order_id')
  ).property('order_id')

  hasOrder: Em.computed.notEmpty 'order_id'
  isCreated: Em.computed.notEmpty 'token'

  isUpdating: no

  resetCart: ->
    self = this
    @set 'token', null
    @createOrder()


  didCreate: ->
    unless @get('isCreated')
      @createOrder()

  createOrder: ->
    return if @get 'isCreated'
    self = this
    return new Promise (resolve, reject)->
      $.ajax 'api/orders',
      type: 'POST'
      dataType: 'json'
      success: (payload, status, xhr)->
        self.setProperties
          order_id: payload.id
          token: payload.token
          number: payload.number
        self.store.pushPayload 'order',
          order: payload
        order = self.store.getById 'order', self.get('order_id')
        self.set 'order', order
        self.save()
        resolve(self)
      error: ->
        reject(arguments)

  fetchOrder: ->
    self = this
    return new Promise (resolve, reject)->
      self.updateOrder().always ()->
        resolve(self.get('order'))

  updateOrder: ->
    self = this
    @set('isUpdating', no)
    $.ajax "api/orders/#{self.get('number')}",
      dataType: "json"
      data:
        order_token: self.get('token')
      success: (payload)->
        self.store.pushPayload 'order', {order: payload}
        self.set 'order', self.store.getById('order', payload.id)
        self.set('isUpdating', no)
        return payload
      error: ->
        self.set('isUpdating', no)
        return arguments
