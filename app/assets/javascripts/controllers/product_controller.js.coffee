Trashbags.ProductController = Em.Controller.extend
  needs: 'products'
  imagesByType: Em.computed.alias 'controllers.products.imagesByType'
  images: (->
    @get('imagesByType')[@get('model.type')]
    ).property('content')