App.ProductRoute = Em.Route.extend({
	model(params) {
		return this.store.peekAll('product', params.product_id);
	}
});
