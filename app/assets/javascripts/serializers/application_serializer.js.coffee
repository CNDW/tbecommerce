decamelize = Ember.String.decamelize
capitalize = Ember.String.capitalize
camelize = Ember.String.camelize
forEach = Ember.Enumerable.mixins.forEach
underscore = Ember.String.underscore

App.ApplicationSerializer = DS.RESTSerializer.extend()

App.ProductAdapter = DS.RESTAdapter.extend
  namespace: 'api'
App.ProductSerializer = DS.RESTSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    images: embedded: 'always'
    product_mocks: embedded: 'always'

App.OptionTypeSerializer = DS.RESTSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    optionValues: embedded: 'always'

App.ColorTypeSerializer = DS.RESTSerializer.extend()
App.PropertySerializer = DS.RESTSerializer.extend()

App.ColorValueAdapter = DS.RESTAdapter.extend
  namespace: 'api'
  pathForType: (type)->
    Em.String.pluralize(Em.String.decamelize(type))
App.ColorValueSerializer = DS.RESTSerializer.extend
  normalizePayload: (payload)->
    {"colorValues": payload}

App.CountrySerializer = DS.RESTSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    states: embedded: 'always'

App.ShippingCategorySerializer = DS.RESTSerializer.extend()
App.ShippingMethodSerializer = DS.RESTSerializer.extend()
App.ShippingRateSerializer = DS.RESTSerializer.extend()
App.ShipAddressSerializer = DS.RESTSerializer.extend()
App.BillAddressSerializer = DS.RESTSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    country: embedded: 'always'
    state: embedded: 'always'
App.ShipAddressSerializer = DS.RESTSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    country: embedded: 'always'
    state: embedded: 'always'

