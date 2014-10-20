App.ApplicationController = Em.Controller.extend
  catalogueActive: no

  actions:
    toggleCatalogue: ->
      @toggleProperty 'catalogueActive'
      return false
    deactivateCatalogue: ->
      @set 'catalogueActive', no
      return false
