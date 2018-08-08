App.CustomItemComponent = Em.Component.extend({
  mocks: Em.computed.sort('model.productMocks', (a, b) => {
    return a.get('position') - b.get('position');
  }),

  hasManyMocks: Em.computed.gt('mocks.length', 1),

  hasProduct: Em.computed.alias('model.hasProduct'),

  mockIndex: 0,

  activeMock: (function() {
    return this.get('mocks').findBy('position', this.get('mockIndex'));
  }).property('mockIndex', 'mocks.firstObject'),

  setupMocks: Em.observer('mocks', function() {
    return this.set('mockIndex', 0);
  }),

  actions: {
    setActiveMock(mock) {
      return this.set('mockIndex', mock.get('position'));
    }
  }
});
