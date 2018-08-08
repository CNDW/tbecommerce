App.ToggleMenuComponent = Em.Component.extend(Em.Evented, {
  isShowing: false,
  classNameBindings: 'isShowing:active',

  didInsertElement() {
    return App.EventBus.on('collapseMenus', this, this.collapseMenu);
  },

  willDestroyElement() {
    return App.EventBus.off('collapseMenus', this, this.collapseMenu);
  },

  collapseMenu() {
    return this.set('isShowing', false);
  },
  click() {
    if (!this.get('isShowing')) { App.EventBus.trigger('collapseMenus'); }
    return this.toggleProperty('isShowing');
  }
});