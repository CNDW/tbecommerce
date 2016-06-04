/* global App, Em */
App.CardController = Em.Controller.extend({
  months: [
    { name: 'January', val: 1 },
    { name: 'February', val: 2 },
    { name: 'March', val: 3 },
    { name: 'April', val: 4 },
    { name: 'May', val: 5 },
    { name: 'June', val: 6 },
    { name: 'July', val: 7 },
    { name: 'August', val: 8 },
    { name: 'September', val: 9 },
    { name: 'October', val: 10 },
    { name: 'November', val: 11 },
    { name: 'December', val: 12 }
  ],
  years: Em.computed(function() {
    var num, year;

    year = (new Date()).getFullYear();

    return (function() {
      var i, results;
      results = [];
      for (num = i = 0; i <= 14; num = ++i) {
        results.push(year + num);
      }
      return results;
    })();
  }),

  actions: {
    submitCardInfo(card) {
      return card.createToken();
    }
  }
});
