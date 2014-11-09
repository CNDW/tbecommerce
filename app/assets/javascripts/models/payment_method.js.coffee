App.PaymentMethod = DS.Model.extend
  name: DS.attr 'string'
  method_type: DS.attr 'string'
  environment: DS.attr 'string'

App.Payment = DS.Model.extend
  source_type: DS.attr 'string'
  source_id: DS.attr 'string'
  amount: DS.attr 'string'
  display_amount: DS.attr 'string'
  payment_method: DS.belongsTo 'payment_method', async: true
  response_code: DS.attr 'string'
  state: DS.attr 'string'
  avs_response: DS.attr 'string'
  created_at: DS.attr 'string'
  updated_at: DS.attr 'string'
  order: DS.belongsTo 'order'