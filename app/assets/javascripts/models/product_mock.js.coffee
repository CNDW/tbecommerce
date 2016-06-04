App.ProductMock = DS.Model.extend
  name: DS.attr 'string'
  position: DS.attr 'number'
  svgUrl: DS.attr 'string'
  product: DS.belongsTo 'product'

  svgData: DS.attr 'string'

  getSvg: ->
    svgData = @get('svgData')
    self = this
    new Em.RSVP.Promise (resolve, reject)->
      if svgData != undefined
        resolve(svgData)
      else
        $.ajax
          dataType: 'text'
          url: self.get('svgUrl')
          success: (data)->
            self.set 'svg_data', data
            resolve(data)
          error: ->
            reject(arguments)
