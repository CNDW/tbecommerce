App.CustomItemController = Em.Controller.extend Ember.Evented,
  needs: ['custom']
  featuredItems: Em.computed.alias 'controllers.custom.featuredItems'

  mocks: Em.computed.sort 'model.product_mocks', (a, b)->
    a.get('position') - b.get('position')

  hasManyMocks: Em.computed.gt 'mocks.length', 1

  hasProduct: Em.computed.alias 'model.hasProduct'

  mock_index: 0

  active_mock: (->
    @get('mocks').findBy('position', @get('mock_index'))
  ).property('mock_index', 'mocks.firstObject')

  setupMocks: (->
    @set 'mock_index', 0
  ).observes('mocks')

  actions:
    setActiveMock: (mock)->
      @set('mock_index', mock.get('position'))