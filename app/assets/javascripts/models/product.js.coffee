Trashbags.Product = DS.Model.extend
  name: DS.attr('string')
  description: DS.attr('string')
  price: DS.attr('number')
  type: (->
  	properties = @get('productProperties')
  	
  	).property()
  category: DS.attr('string')
  slug: DS.attr('string')
 	displayPrice: DS.attr('string')
 	productProperties: DS.hasMany('product_property', {async: true})