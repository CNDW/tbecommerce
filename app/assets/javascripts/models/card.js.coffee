App.Card = DS.Model.extend
  number: DS.attr 'string'
  exp_month: DS.attr 'string'
  exp_year: DS.attr 'string'
  cvc: DS.attr 'string'