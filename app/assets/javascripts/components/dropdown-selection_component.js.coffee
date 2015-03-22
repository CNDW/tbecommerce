App.DropdownSelectionComponent = Em.Component.extend
  classNames: 'dropdown-menu-container'

  layout: Em.HTMLBars.compile "<div class='dropdown-selection'></div>"

  didInsertElement: ->
    self = this
    @$('.dropdown-selection').select2
      data:
        results: @list
        text: 'name'
      triggerChange: yes
      formatSelection: (item)->
        item.name
      formatResult: (item)->
        item.name

    @$('.dropdown-selection').select2('val', @model.get(@target_attr))
    @$('.dropdown-selection').on 'change', (e)->
      self.model.set self.target_attr, e.val

  willDestroyElement: ->
    @$('.dropdown-selection').off 'change'
    @$('.dropdown-selection').select2 'destroy'
