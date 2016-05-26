App.Cart = DS.Model.extend
  token: DS.attr 'string', defaultValue: null
  number: DS.attr 'string', defaultValue: null
  order_id: DS.attr 'string'
  order: (->
    @store.findRecord 'order', @get('order_id')
  ).property('order_id')

  hasOrder: Em.computed.notEmpty 'order_id'
  isCreated: Em.computed.notEmpty 'token'

  resetCart: ->
    self = this
    @set 'token', null
    @createOrder()

  didCreate: ->
    unless @get('isCreated')
      @createOrder()

  didLoad: ->
    @get('order') if @get('order_id')

  createOrder: (force)->
    return if (@get('isCreated') and !force)
    self = this
    return new Em.RSVP.Promise (resolve, reject)->
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
        order = self.store.findRecord 'order', self.get('order_id')
        self.set 'order', order
        self.save()
        resolve(self)
      error: ->
        reject(arguments)

  fetchOrder: ->
    self = this
    return new Em.RSVP.Promise (resolve, reject)->
      self.updateOrder().then ()->
        resolve(self.get('order'))

  updateOrder: ->
    self = this
    return new Em.RSVP.Promise (resolve, reject)->
      $.ajax "api/orders/#{self.get('number')}",
        dataType: "json"
        data:
          order_token: self.get('token')
        success: (payload)->
          self.store.pushPayload 'order', {order: payload}
          self.set 'order', self.store.findRecord('order', payload.id)
          resolve(payload)
        error: ->
          self.createOrder(true).then ->
            resolve()
