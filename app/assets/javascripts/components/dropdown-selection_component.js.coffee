App.DropdownSelectionComponent = Em.Component.extend
  classNames: 'dropdown-menu-container'

  render: (buffer)->
    buffer.push("<div class='dropdown-selection'></div>")

  didInsertElement: ->
    this.$().find('.dropdown-selection').select2
      data:
        results: @list
        text: 'name'
      formatSelection: (item)->
        item.name
      formatResult: (item)->
        item.name
