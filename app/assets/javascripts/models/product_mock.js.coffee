App.ProductMock = DS.Model.extend
  name: DS.attr 'string'
  position: DS.attr 'number'
  svg_url: DS.attr 'string'
  product: DS.belongsTo 'product'

  svg_data: DS.attr 'string'

  getSvg: ->
    svg_data = @get('svg_data')
    self = this
    new Em.RSVP.Promise (resolve, reject)->
      if svg_data != undefined
        resolve(svg_data)
      else
        $.ajax
          dataType: 'text'
          url: self.get('svg_url')
          success: (data)->
            self.set 'svg_data', data
            resolve(data)
          error: ->
            reject(arguments)
