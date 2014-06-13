Trashbags.ProductProperty = DS.Model.extend
	product: DS.belongsTo('product', {async: true})
	value: DS.attr('string')
	property_name: DS.attr('string')