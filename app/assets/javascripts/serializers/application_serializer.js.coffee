decamelize = Ember.String.decamelize
capitalize = Ember.String.capitalize
camelize = Ember.String.camelize
forEach = Ember.EnumerableUtils.forEach
underscore = Ember.String.underscore

App.ApplicationSerializer = DS.ActiveModelSerializer.extend()

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

App.CountrySerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    states: embedded: 'always'

App.ShippingCategorySerializer = DS.ActiveModelSerializer.extend()
App.ShippingMethodSerializer = DS.ActiveModelSerializer.extend()
App.ShippingRateSerializer = DS.ActiveModelSerializer.extend()
App.ShipAddressSerializer = DS.ActiveModelSerializer.extend()
App.BillAddressSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    country: embedded: 'always'
    state: embedded: 'always'
App.ShipAddressSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    country: embedded: 'always'
    state: embedded: 'always'

