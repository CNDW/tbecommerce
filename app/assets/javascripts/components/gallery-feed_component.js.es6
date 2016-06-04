App.GalleryFeedComponent = Em.Component.extend({
	willInsertElement() {
		return Em.run.next(this, this.fetchGallery);
	},
	fetchGallery() {
		return $('#gallery-feed').pongstgrm({
			accessId: '52250693',
			accessToken: '52250693.2ef6a14.9549749259f048d69726a5d419f4ad6d',
			show: 'recent'
		});
	}
});
