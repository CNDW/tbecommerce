App.SelectionOptionComponent = Em.Component.extend({
  classNames: 'selection-option',
  classNameBindings: 'isSelected:active',
  isSelected: Em.computed('customItem.productId', function() {
    if (this.get('customItem.hasProduct')) {
      return (this.get('customItem.productId').toString() === this.get('item.id').toString());
    } else {
      return false;
    }
  }),
  click() {
    return this.sendAction('action', this.get('item'));
  }
});
