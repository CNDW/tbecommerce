App.CustomItem = DS.Model.extend({
  isCustomItem: true,
  name: Em.computed('productId', function() {
    return !this.get('productId') ? 'Custom Item' : this.get('product.name');
  }),

  inShop: DS.attr('boolean', {defaultValue: false}),
  inCart: Em.computed.equal('state', 'cart'),
  orderNotes: DS.attr('string', {defaultValue: null}),

  variantId: Em.computed.alias('product.masterVariantId'),

  state: Em.computed('lineItem', function() {
    if (this.get('lineItem') === null) { return 'precart'; }
    return this.get('lineItem.state');
  }),

  shopState: DS.attr('string', {defaultValue: 'new'}),
  shopStates: [
    'new',
    'colors',
    'options',
    'extras',
    'complete'
  ],
  shopSteps: {
    'new': 0,
    'colors': 1,
    'options': 2,
    'extras': 3,
    'complete': 4
  },

  hasProduct: Em.computed.notEmpty('productId'),
  hasColors: Em.computed('selectedColors.@each.isSelected', function() {
    let selectedColors = this.get('selectedColors');
    let colorLength = selectedColors.get('length');
    if (colorLength > 0) {
      selectedColors.forEach(function(color) {
        if (color.get('isSelected')) { return colorLength -= 1; }
      });
    }
    return colorLength === 0;
  }),

  noSelectedColors: Em.computed.empty('selectedColors'),
  colorOptions: Em.computed.alias('product.colorTypes'),

  selectedColors: DS.hasMany('selected-color'),
  customOptions: DS.hasMany('custom-option'),
  lineItem: DS.belongsTo('line-item'),

  price: DS.attr('number'),

  isComplete: Em.computed('completedStep', function() {
    return this.get('completedStep') > 1;
  }),

  completedStep: Em.computed('productId', 'selectedColors.@each.isSelected', function() {
    let step = 0;
    if (this.get('hasProduct')) { step += 1; }
    if (this.get('hasColors')) { step += 1; }
    return step;
  }),

  basePrice: Em.observer('productId', 'customOptions.@each.selected', function() {
    return Em.run.scheduleOnce('actions', this, this.recalculatePrice);
  }),

  productId: DS.attr('number', {defaultValue: null}),

  product: Em.computed('productId', function() {
    if (this.get('productId')) {
      return this.store.peekRecord('product', this.get('productId'));
    }
  }),

  productMocks: Em.computed('productId', function() {
    return this.get('product.productMocks');
  }),

  properties: Em.computed('productId', function() {
    return this.get('product.properties');
  }),

  description: Em.computed('productId', function() {
    return this.get('product.description');
  }),

  specs: Em.computed('productId', function() {
    return this.get('product.specs');
  }),

  //-Serialization for the custom number ID
  customItemHash: Em.computed('productId', 'selectedColors.@each.colorValueId', 'customOptions.@each.optionValueId', function() {
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
    let segment = this.get('selectedColors')
      .sortBy('colorTypeId')
      .map((selection) => {
        return `i${selection.get('colorTypeId')}s${selection.get('colorValueId')}`;
      });
    return `ct${segment.join('')}`;
  },

  getOptionSegment() {
    let segment = this.get('customOptions')
      .filterBy('selected', true)
      .sortBy('optionValueId')
      .map((option) => {
        return `i${option.get('optionValueId')}`;
      });
    return `ov${segment.join('')}`;
  },

  removeLineItem() {
    this.set('lineItem', null);
    return this.save();
  },

  //- Helper methods
  recalculatePrice() {
    let base = this.get('product.price');
    let selected = this.get('customOptions').filterBy('selected', true);
    selected.forEach((option) => {
      base += option.get('price');
    });
    this.set('price', base);
    return this.save();
  },

  validateDataIntegrity() {
    // let isValid = this.get('selectedColors').reduce((result, color) => {
    //   return color.get('colorTypeId') !== null ? result : false;
    // }, true);

    // if (!isValid) {
    //   this.reloadRelationships();
    // }
  },

  loadOptions() {
    let product = this.get('product');
    this.populateColorRelationship(product);
    return this.populateOptionRelationship(product);
  },

  reloadRelationships() {
    [this.get('selectedColors'), this.get('customOptions')].forEach((relationship) => {
      relationship.clear();
    });
    this.save();
    return this.loadOptions();
  },

  populateColorRelationship(product) {
    let self = this;
    let selectedColors = this.get('selectedColors');
    let colorTypes = product.get('colorTypes');
    colorTypes.forEach(function(colorType) {
      let record = self.store.createRecord('selectedColor', {
        colorTypeId: colorType.get('id'),
        customItem: self
      });
      return selectedColors.addObject(record);
    });
    return this.save();
  },

  populateOptionRelationship(product) {
    let self = this;
    let customOptions = this.get('customOptions');
    product.get('optionTypes').forEach((optionType) => {
      optionType.get('optionValues').forEach((optionValue) => {
        let record = self.store.createRecord('customOption', {
          optionValueId: optionValue.get('id'),
          selected: false,
          customItem: self,
          price: optionValue.get('price'),
          position: optionType.get('position') + optionValue.get('position')
        });
        return customOptions.addObject(record);
      });
    });
    return this.save();
  }
});
