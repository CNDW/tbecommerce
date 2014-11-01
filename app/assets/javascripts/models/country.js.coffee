App.Country = DS.Model.extend
  states: DS.hasMany 'state'

  name: DS.attr 'string'
  iso3: DS.attr 'string'
  iso: DS.attr 'string'
  iso_name: DS.attr 'string'
  numcode: DS.attr 'number'
  states_required: DS.attr 'boolean'

App.State = DS.Model.extend
  country: DS.belongsTo 'country'

  name: DS.attr 'string'
  abbr: DS.attr 'string'
