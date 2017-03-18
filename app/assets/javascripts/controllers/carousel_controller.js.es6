App.CarouselController = Em.Controller.extend({
  init() {
    this._super(...arguments);
    this.cycleCarousel();
  },

  currentContentDidChange: Em.observer('model', function() {
    return this.set('slideIndex', 0);
  }),

  slideIndex: 0,

  thumbnails: Em.computed('model', 'slideIndex', function() {
    return this.model.map((item, index) => {
      return {
        'index': index,
        'miniUrl': item.get('thumbUrl'),
        'activeIndex': this.get('slideIndex')
      };
    });
  }),

  activeSlide: Em.computed('model', 'slideIndex', function() {
    return this.model.objectAt(this.slideIndex);
  }),

  nextSlide() {
    if (this.slideIndex < this.get('length') - 1) {
      return this.incrementProperty('slideIndex');
    } else {
      return this.set('slideIndex', 0);
    }
  },

  previousSlide() {
    if (this.slideIndex > 0) {
      return this.decrementProperty('slideIndex');
    } else {
      return this.set('slideIndex', this.get('length') - 1);
    }
  },

  cycleCarousel() {
    return this.slide_show = setInterval($.proxy(this.nextSlide, this), 5000);
  },

  stopCycle() {
    return clearInterval(this.slide_show);
  },

  willDestroy() {
    return clearInterval(this.slide_show);
  },

  actions: {
    setSlide(newIndex) {
      this.stopCycle();
      this.set('slideIndex', newIndex);
      return this.cycleCarousel();
    }
  }
});
