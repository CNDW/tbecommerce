decamelize = Ember.String.decamelize
capitalize = Ember.String.capitalize
camelize = Ember.String.camelize
forEach = Ember.EnumerableUtils.forEach
underscore = Ember.String.underscore

App.ProductSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    productProperties: embedded: 'always'
    images: embedded: 'always'

App.ProductAdapter = DS.RESTAdapter.extend
  namespace: 'api'

App.ColorValueAdapter = DS.RESTAdapter.extend
  namespace: 'api'
  pathForType: (type)->
    Em.String.pluralize(Em.String.decamelize(type))

App.OptionTypeSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    optionValues: embedded: 'always'

App.ColorTypeSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,


App.ColorValueSerializer = DS.ActiveModelSerializer.extend
  normalizePayload: (payload)->
    {"colorValues": payload}

App.CustomItemAdapter = DS.LSAdapter.extend()
App.CustomItemSerializer = DS.LSSerializer.extend()
App.SelectedColorAdapter = DS.LSAdapter.extend()
App.SelectedColorSerializer = DS.LSSerializer.extend()