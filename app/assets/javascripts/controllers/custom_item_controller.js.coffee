App.CustomItemController = Em.ObjectController.extend Ember.Evented,
  needs: ['custom']
  featuredItems: Em.computed.alias 'controllers.custom.featuredItems'

  fills: (->
    colors = @get 'model.selectedColors'
    colors.map (color)->
      if not color.get('isUnselected')
        ".#{color.get('selector')}{fill:url(##{color.get('name')}-pattern)}"
      else
        ""
  ).property()

  patterns: Em.computed.alias 'model.patterns'

  selectedColors: Em.computed.alias 'model.selectedColors'

  mocks: Em.computed.alias 'model.product_mocks'

  hasManyMocks: Em.computed.gt 'mocks.length', 1

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