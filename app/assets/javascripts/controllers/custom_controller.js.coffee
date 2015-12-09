App.CustomController = Em.Controller.extend
  product: Em.computed.alias 'model.product'
  hasProduct: Em.computed.alias 'model.hasProduct'

  hasColors: Em.computed.alias 'model.hasColors'

  hasProductAndColors: Em.computed.and 'hasProduct', 'hasColors'

  price: Em.computed.alias 'model.price'
  products: Em.computed ->
    @store.all('product').filter (product)->
      product.get 'in_custom_shop'
  featuredItems: Em.computed 'products', ->
    @get('products').filterBy 'featured', true

  mocks: Em.computed.alias 'model.product_mocks'

  mock_index: 0

  active_mock: Em.computed 'mocks', 'mock_index', ->
    @get('mocks').objectAt(@get('mock_index'))
