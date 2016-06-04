App.DropdownSelectionComponent = Em.Component.extend({
  classNames: 'dropdown-menu-container',

  layout: Em.HTMLBars.compile("<div class='dropdown-selection'></div>"),

  didInsertElement() {
    this.$('.dropdown-selection').select2({
      data: {
        results: this.list,
        text: 'name'
      },
      triggerChange: true,
      formatSelection(item) {
        return item.name;
      },
      formatResult(item) {
        return item.name;
      }
    });

    this.$('.dropdown-selection').select2('val', this.model.get(this.target_attr));
    return this.$('.dropdown-selection').on('change', (e) => {
      this.model.set(this.target_attr, e.val);
    });
  },

  willDestroyElement() {
    this.$('.dropdown-selection').off('change');
    return this.$('.dropdown-selection').select2('destroy');
  }
});
