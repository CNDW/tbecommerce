Trashbags.Image = DS.Model.extend
	position: DS.attr 'number'
	attachmentContentType: DS.attr 'string'
	attachmentFileName: DS.attr 'string'
	attachmentWidth: DS.attr 'number'
	atttachmentHeight: DS.attr 'number'
	alt: DS.attr 'string'
	miniUrl: DS.attr 'string'
	smallUrl: DS.attr 'string'
	productUrl: DS.attr 'string'
	largeUrl: DS.attr 'string'

	products: DS.belongsTo 'product', async: true