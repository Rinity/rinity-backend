import Ember from 'ember';

export default Ember.Route.extend({
//  setupController: function(controller, rides) {
//    controller.set('model', rides.get('rides'));
//  },
  model: function() {
    return this.store.find('ride');
  },
  actions: {
    deleteRide: function(ride) {
      console.log(ride);
      ride.deleteRecord();
      console.log('ride is deleteted:', ride.get('isDeleted'));
      ride.save();
    },
    createRide: function() {
      var controller = this.get('controller');
      var direction = controller.get('selectedDirection');
      var time = controller.get('selectedTime');
      var office = controller.get('selectedOffice');
      console.log(direction);
      console.log(time);
      console.log(office);
      var ride = this.store.createRecord('ride',{direction: direction, time: time, office: office});
      console.log(ride.get('direction'));
      console.log(ride.get('time'));
      console.log(ride.get('office'));
      ride.save();
    }
  }
});
