App.ProductMock = DS.Model.extend
  name: DS.attr 'string'
  position: DS.attr 'number'
  svg_url: DS.attr 'string'
  product: DS.belongsTo 'product'

  svg_data: DS.attr 'string'

  raw_svg: (->
    svg_data = @get('svg_data')
    return svg_data if svg_data != undefined
    self = this
    new Promise (resolve, reject)->
      $.ajax
        dataType: 'text'
        url: self.get('svg_url')
        success: (data)->
          self.set 'svg_data', data
          resolve(data)
        error: ->
          reject()
  ).property()
