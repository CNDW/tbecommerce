App.ObjectTransform = DS.Transform.extend
  deserialize: (value)->
    return {} if !$.isPlainObject(value)
    return value

  serialize: (value)->
    return {} if !$.isPlainObject(value)
    return value

App.ArrayTransform = DS.Transform.extend
  deserialize: (value)->
    return Em.A(value) if Em.isArray(value)
    return Em.A()

  serialize: (value)->
    return Em.A(value) if Em.isArray(value)
    return Em.A()

App.ApplicationStore = DS.Store.extend
  createItemByHash: (hash)->
    debugger
