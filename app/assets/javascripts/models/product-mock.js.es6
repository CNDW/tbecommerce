App.ProductMock = DS.Model.extend({
  name: DS.attr('string'),
  position: DS.attr('number'),
  svgUrl: DS.attr('string'),
  product: DS.belongsTo('product'),

  svgData: DS.attr('string'),

  getSvg() {
    let svgData = this.get('svgData');
    let self = this;
    return new Em.RSVP.Promise(function(resolve, reject) {
      if (svgData !== undefined) {
        return resolve(svgData);
      } else {
        return $.ajax({
          dataType: 'text',
          url: self.get('svgUrl'),
          success(data) {
            self.set('svg_data', data);
            return resolve(data);
          },
          error() {
            return reject(arguments);
          }
        });
      }
    });
  }
});
