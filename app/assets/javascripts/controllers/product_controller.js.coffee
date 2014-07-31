Trashbags.ProductController = Em.Controller.extend
  needs: 'products'
  imagesByType: Em.computed.alias 'controllers.products.imagesByType'
  typeImages: (->
    @imagesByType[@get('model.type')]
    ).property('content')
  images: (->
    @content.get('images')
    ).property('content')
  propertyImages: (->
    images = @get('content.productProperties').getEach('medium_url')
    images.slice(0, 4)
    ).property('content')
  catalogueOptions: Em.computed.filterBy 'content.optionTypes', 'catalogue'
