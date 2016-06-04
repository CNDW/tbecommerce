App.PaymentMethod = DS.Model.extend
  name: DS.attr 'string'
  methodType: DS.attr 'string'
  environment: DS.attr 'string'

App.Payment = DS.Model.extend
  sourceType: DS.attr 'string'
  sourceId: DS.attr 'string'
  amount: DS.attr 'string'
  displayAmount: DS.attr 'string'
  paymentMethod: DS.belongsTo 'paymentMethod', async: true
  responseCode: DS.attr 'string'
  state: DS.attr 'string'
  avsResponse: DS.attr 'string'
  createdAt: DS.attr 'string'
  updatedAt: DS.attr 'string'
  order: DS.belongsTo 'order'
