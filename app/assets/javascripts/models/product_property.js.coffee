Trashbags.ProductProperty = DS.Model.extend
	product: DS.belongsTo('product', {async: true})
	value: DS.attr('string')
	property_name: DS.attr('string')
	name: Em.computed.alias @get('property_name')