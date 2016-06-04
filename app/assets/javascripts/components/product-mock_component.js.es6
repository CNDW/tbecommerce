App.ProductMockComponent = Em.Component.extend({
  layout: Em.HTMLBars.compile("<div class='product-mock'></div>"),

  didInsertElement() {
    return Em.run.scheduleOnce('afterRender', this, this.insertSVG);
  },

  renderColors() {
    if (this._state === "destroying") { return; }
    let colors = this.get('customItem.selectedColors');
    return colors.forEach(function(color) {
      if (color.get('lineColor')) {
        return this.$(`.${color.get('selector')}`).css('stroke', `url(#${color.get('name')}-pattern)`);
      } else {
        return this.$(`.${color.get('selector')}`).css('fill', `url(#${color.get('name')}-pattern)`);
      }
    }
    , this);
  },

  colorChange: (function() {
    return Em.run.scheduleOnce('afterRender', this, this.renderColors);
  }).observes('customItem.selectedColors.@each.colorValueId'),

  setPatterns() {
    let patterns = this.get('customItem.patterns').join();
    return this.$('defs').html(patterns);
  },

  insertSVG() {
    if (this._state === "destroying") { return; }
    let self = this;
    let mock = this.get('mock');
    return mock.getSvg().then(function(svg) {
      self.$('.product-mock').html(svg);
      return self.colorChange();
    });
  },

  productChange: (function() {
    return Em.run.scheduleOnce('actions', this, this.renderMock);
  }).observes('mock'),

  renderMock() {
    if (this._state !== "destroying") { return this.rerender(); }
  }
});
