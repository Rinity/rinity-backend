import Ember from 'ember';

export default Ember.Controller.extend({
  directions: ['to home','to office'],
  time: ['7:00','7:15','7:30','7:45','8:00','8:15','8:30','8:45','9:00'],
  offices: {},
  actions: {
    createRide: function() {
      var self = this;
      console.log(this.get('fields'));
      var ride= this.store.createRecord('ride', this.get('fields'));
      console.log(ride);
      ride.save().then(function() {
        self.transitionToRoute('ride', ride);
      });
    }
  }
});
