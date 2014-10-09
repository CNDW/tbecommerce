decamelize = Ember.String.decamelize
capitalize = Ember.String.capitalize
camelize = Ember.String.camelize
forEach = Ember.EnumerableUtils.forEach
underscore = Ember.String.underscore

App.ProductAdapter = DS.RESTAdapter.extend
  namespace: 'api'
App.ProductSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    images: embedded: 'always'


App.OptionTypeSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    optionValues: embedded: 'always'

App.ColorTypeSerializer = DS.ActiveModelSerializer.extend()
App.PropertySerializer = DS.ActiveModelSerializer.extend()

App.ColorValueAdapter = DS.RESTAdapter.extend
  namespace: 'api'
  pathForType: (type)->
    Em.String.pluralize(Em.String.decamelize(type))
App.ColorValueSerializer = DS.ActiveModelSerializer.extend
  normalizePayload: (payload)->
    {"colorValues": payload}

App.CustomItemAdapter = DS.LSAdapter.extend()
App.CustomItemSerializer = DS.LSSerializer.extend()
App.SelectedColorAdapter = DS.LSAdapter.extend()
App.SelectedColorSerializer = DS.LSSerializer.extend()
App.CustomOptionAdapter = DS.LSAdapter.extend()
App.CustomOptionSerializer = DS.LSSerializer.extend()