App.ApplicationController = Em.Controller.extend
  catalogueActive: no
  toggleCatalogue: ->
    @toggleProperty 'catalogueActive'
  deactivateCatalogue: ->
    @set 'catalogueActive', no
