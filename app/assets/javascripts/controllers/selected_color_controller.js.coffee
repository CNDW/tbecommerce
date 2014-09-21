App.SelectedColorController = Em.ObjectController.extend
  actions:
    selectColor: (color)->
      @model.set 'colorValue_id', color.get 'id'
      @model.save()