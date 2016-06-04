App.Variant = DS.Model.extend({
  isVariant: true,
  name: DS.attr('string'),
  sku: DS.attr('string'),
  price: DS.attr('string'),
  weight: DS.attr('string'),
  height: DS.attr('string'),
  width: DS.attr('string'),
  depth: DS.attr('string'),
  isMaster: DS.attr('boolean'),
  slug: DS.attr('string'),
  description: DS.attr('string'),
  trackInventory: DS.attr('boolean'),
  instockDescription: DS.attr('string'),
  displayPrice: DS.attr('string'),
  totalOnHand: DS.attr('number'),
  optionsText: DS.attr('string'),
  totalInCart: DS.attr('number', {defaultValue: 0}),

  totalNotInCart: Em.computed('totalInCart', 'totalOnHand', function() {
    return this.get('totalOnHand') - this.get('totalInCart');
  }),
  isUnavailable: Em.computed.lt('totalNotInCart', 1),

  images: DS.hasMany('image'),
  optionValues: DS.hasMany('optionValue'),
  product: DS.belongsTo('product'),
  variantColors: DS.attr('array'),

  catalogueImage: Em.computed('images', function() {
    if (this.get('images.length') === 0) { return ''; }
    return this.get('images.firstObject.mediumUrl');
  }),

  type: Em.computed.alias('product.productType'),
  category: Em.computed.alias('product.productCategory'),
  productName: Em.computed.alias('product.name'),

  variantId: Em.computed.alias('id'),

  totalPrice: Em.computed(function(){
    let base = Number(this.get('price'));
    this.get('optionValues').forEach(val=> base = base + Number(val.get('price')));
    return base;
  }),

  displayTotalPrice: Em.computed(function(){
    return `$${this.get('totalPrice')}`;
  }),

  customItemHash: Em.computed('product.id', 'variantColors@each.colorValueId', 'optionValues.@each.optionValueId', function() {
    return [
      this.getCustomSegment(),
      this.getColorSegment(),
      this.getOptionSegment()
    ].join('e');
  }),

  getCustomSegment() {
    return `pvi${this.get('variantId')}`;
  },

  getColorSegment() {
    let segment = this.get('variantColors').sortBy('colorTypeId').map(selection=> `i${selection.colorTypeId}s${selection.colorValueId}`);
    return `ct${segment.join('')}`;
  },

  getOptionSegment() {
    let segment = this.get('optionValues').sortBy('id').map(option=> `i${option.get('id')}`);
    return `ov${segment.join('')}`;
  }
});
