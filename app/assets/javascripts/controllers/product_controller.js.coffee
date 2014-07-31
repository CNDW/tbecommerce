Trashbags.ProductController = Em.Controller.extend
  needs: 'products'
  imagesByType: Em.computed.alias 'controllers.products.imagesByType'
  typeImages: (->
    @imagesByType[@get('model.type')]
    ).property('model')
  images: (->
    @content.get('images')
    ).property('model')
  propertyImages: (->
    images = @get('content.productProperties').getEach('medium_url')
    images.slice(0, 4)
    ).property('this')