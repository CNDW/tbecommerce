App.CarouselThumbnailComponent = Em.Component.extend({
  classNameBindings: ['isActive:active'],

  layout: Em.HTMLBars.compile("<img src={{miniUrl}}/>{{yield}}"),

  isActive: Em.computed('activeIndex', function() {
    return this.get('activeIndex') === this.get('index');
  }),

  click() {
    return this.sendAction('action', this.get('index'));
  }
});
