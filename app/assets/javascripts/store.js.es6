App.ObjectTransform = DS.Transform.extend({
  deserialize(value) {
    if (!$.isPlainObject(value)) { return ({}); }
    return value;
  },

  serialize(value) {
    if (!$.isPlainObject(value)) { return ({}); }
    return value;
  }
});

App.ArrayTransform = DS.Transform.extend({
  deserialize(value) {
    if (Em.isArray(value)) { return Em.A(value); }
    return Em.A();
  },

  serialize(value) {
    if (Em.isArray(value)) { return Em.A(value); }
    return Em.A();
  }
});

App.ApplicationStore = DS.Store.extend();

let EventBus = Em.Object.extend(Em.Evented);
App.EventBus = EventBus.create();
