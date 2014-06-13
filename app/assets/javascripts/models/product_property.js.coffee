Trashbags.ProductProperty = DS.Model.extend
	product: DS.belongsTo('product', {async: true})
	value: DS.attr('string')
	propertyName: DS.attr('string')