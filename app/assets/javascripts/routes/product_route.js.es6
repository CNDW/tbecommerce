App.ProductRoute = Em.Route.extend({
	model(params) {
		return this.store.peekRecord('product', params.product_id);
	}
});
