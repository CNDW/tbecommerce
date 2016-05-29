var Promise = Ember.RSVP.Promise;

function request(options={}) {
  return new Promise((resolve, reject) => {
    var oldSuccess = options.success,
        oldError = options.error;
    options.success = function(payload) {
      if (oldSuccess) oldSuccess.apply(this, arguments);
      resolve(payload);
    };
    options.error = function(xhr) {
      if (oldError) oldError.apply(this, arguments);
      reject(xhr);
    };
    $.ajax.call(this, hashOptions(options));
  });
}

function hashOptions(options){
  var hash = $.extend(true, {
    url: "/",
    type: options.method || "GET",
    dataType: 'json',
    context: this,
    data: options.body,
    headers: {
      'Content-Type': 'application/json'
    }
  }, options);
  hash.data = JSON.stringify(hash.data);
  return hash;
}

App.RequestableMixin = Ember.Mixin.create({ request });
