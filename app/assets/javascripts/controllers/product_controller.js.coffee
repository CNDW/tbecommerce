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
    images = @content.get('productProperties').getEach('medium_url')
    images.slice(0, 4)
    ).property('content')