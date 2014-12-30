App.CustomController = Em.ObjectController.extend
  product: Em.computed.alias 'model.product'
  hasProduct: Em.computed.alias 'model.hasProduct'
  hasProductAndColors: Em.computed 'model.hasProduct', 'model.hasColors', ->
    @get('hasProduct') and @get('hasColors')
  price: Em.computed.alias 'model.price'
  products: Em.computed ->
    @store.all('product').filter (product)->
      product.get 'in_custom_shop'
  featuredItems: Em.computed 'products', ->
    @get('products').filterBy 'featured', true

  mocks: Em.computed.alias 'model.product_mocks'

  mock_index: 0

  active_mock: (->
    @get('mocks').objectAt(@get('mock_index'))
  ).property('mocks', 'mock_index')

  builderStep: 1
