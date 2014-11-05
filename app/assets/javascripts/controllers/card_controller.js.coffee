App.CardController = Em.ObjectController.extend
  months: [
      name: 'January'
      val: '01'
    ,
      name: 'February'
      val: '02'
    ,
      name: 'March'
      val: '03'
    ,
      name: 'April'
      val: '04'
    ,
      name: 'May'
      val: '05'
    ,
      name: 'June'
      val: '06'
    ,
      name: 'July'
      val: '07'
    ,
      name: 'August'
      val: '08'
    ,
      name: 'September'
      val: '09'
    ,
      name: 'October'
      val: '10'
    ,
      name: 'November'
      val: '11'
    ,
      name: 'December'
      val: '12'
  ]
  years: (->
    year = (new Date()).getFullYear()
    years = (year + num for num in [0..14])
  ).property()

  actions:
    submitCardInfo: (card)->
      card.createToken()