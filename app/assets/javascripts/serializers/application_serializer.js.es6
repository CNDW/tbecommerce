// let { decamelize } = Em.String;
// let { capitalize } = Em.String;
let { camelize } = Em.String;
// let { forEach } = Em.Enumerable.mixins;
let { underscore } = Em.String;
let inflector = new Em.Inflector(Em.Inflector.defaultRules);

let BaseSerializer = DS.RESTSerializer.extend({
  keyForAttribute(key, method) {
    if (method === 'deserialize') {
      return underscore(key);
    } else {
      return camelize(key);
    }
  },

  keyForRelationship(key, relationship, method) {
    let embedded = this.get('attrs');
    if (embedded && embedded[key]) {
      return key;
    } else if (relationship === 'hasMany') {
      return `${underscore(inflector.singularize(key))}_ids`;
    } else {
      return `${underscore(key)}_id`;
    }
  }
});

App.ApplicationSerializer = BaseSerializer.extend();

App.ProductAdapter = DS.RESTAdapter.extend({
  namespace: 'api'
});

App.ProductSerializer = BaseSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    images: { embedded: 'always' },
    productMocks: { embedded: 'always' }
  }
});
App.VariantAdapter = DS.RESTAdapter.extend({
  namespace: 'api'
});
App.VariantSerializer = BaseSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    images: { embedded: 'always' }
  }
});

App.OptionTypeSerializer = BaseSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    optionValues: { embedded: 'always' }
  }
});

App.ColorTypeSerializer = BaseSerializer.extend();
App.PropertySerializer = BaseSerializer.extend();

App.ColorValueAdapter = DS.RESTAdapter.extend({
  namespace: 'api',
  pathForType(type) {
    return Em.String.pluralize(Em.String.decamelize(type));
  }
});
App.ColorValueSerializer = BaseSerializer.extend({
  normalizePayload(payload) {
    return { colorValues: payload};
  }
});

App.CountrySerializer = BaseSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    states: { embedded: 'always' }
  }
});

App.ShippingCategorySerializer = BaseSerializer.extend();
App.ShippingMethodSerializer = BaseSerializer.extend();
App.ShippingRateSerializer = BaseSerializer.extend();
App.ShipAddressSerializer = BaseSerializer.extend();
App.BillAddressSerializer = BaseSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    country: { embedded: 'always' },
    state: { embedded: 'always' }
  }
});
App.ShipAddressSerializer = BaseSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    country: { embedded: 'always' },
    state: { embedded: 'always' }
  }
});
App.OrderSerializer = BaseSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    lineItems: { embedded: 'always' },
    shipAddress: { embedded: 'always' },
    billAddress: { embedded: 'always' },
    paymentMethods: { embedded: 'always' },
  }
});
App.LineItemSerializer = BaseSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    variant: {embedded: 'always'}
  }
});
