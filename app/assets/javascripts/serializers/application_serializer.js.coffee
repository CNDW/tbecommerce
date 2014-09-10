decamelize = Ember.String.decamelize
capitalize = Ember.String.capitalize
camelize = Ember.String.camelize
forEach = Ember.EnumerableUtils.forEach
underscore = Ember.String.underscore

App.ApplicationSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    productProperties: embedded: 'always'
    images: embedded: 'always'
    optionTypes: embedded: 'always'
  extractMeta: (store, type, payload)->
    metadata = {}
    Em.$.each payload, (key, value)->
      if (key != type.typeKey && key != type.typeKey.pluralize())
        metadata[key] = value
        delete payload[key]
    store.metaForType(type, metadata)
