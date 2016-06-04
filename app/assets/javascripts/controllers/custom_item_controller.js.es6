App.CustomItemController = Em.Controller.extend(Ember.Evented, {
  needs: ['custom'],
  featuredItems: Em.computed.alias('controllers.custom.featuredItems'),

  mocks: Em.computed.sort('model.product_mocks', (a, b)=> a.get('position') - b.get('position')),

  hasManyMocks: Em.computed.gt('mocks.length', 1),

  hasProduct: Em.computed.alias('model.hasProduct'),

  mock_index: 0,

  active_mock: (function() {
    return this.get('mocks').findBy('position', this.get('mock_index'));
  }).property('mock_index', 'mocks.firstObject'),

  setupMocks: (function() {
    return this.set('mock_index', 0);
  }).observes('mocks'),

  actions: {
    setActiveMock(mock){
      return this.set('mock_index', mock.get('position'));
    }
  }
});