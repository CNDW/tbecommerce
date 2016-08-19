App.GalleryFeedComponent = Em.Component.extend({
	willInsertElement() {
		return Em.run.next(this, this.fetchGallery);
	},
	fetchGallery() {
		return $('#gallery-feed').pongstgrm({
			accessId: '52250693',
			accessToken: '52250693.2ef6a14.92632d7d35ed4e8bafe64a3637a94102',
			show: 'recent'
		});
	}
});

/*
	to generate a new access token, hit this url in a browser with the client id after oath into instagram
	https://www.instagram.com/accounts/login/?force_classic_login=&next=/oauth/authorize/%3Fclient_id%3D2ef6a140ad2742a984c1faba23b0a5b6%26redirect_uri%3Dhttp%3A//localhost:3000%26response_type%3Dtoken
*/
