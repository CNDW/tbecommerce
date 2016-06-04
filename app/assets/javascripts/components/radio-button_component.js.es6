App.RadioButtonComponent = Em.Component.extend({
  tagName: 'input',

  type: 'radio',

  attributeBindings: ['type', 'htmlChecked:checked', 'value', 'name'],

  htmlChecked: Em.computed('value', 'checked', function() {
    return this.get('value') === this.get('checked');
  }),

  change() {
    return this.set('checked', this.get('value'));
  }
});
