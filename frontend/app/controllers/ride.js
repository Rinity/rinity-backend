import Ember from 'ember';

export default Ember.Controller.extend({
  selectedDirection: null,
  directions: ['to home','to office'],
  time: ['7:00','7:15','7:30','7:45','8:00','8:15','8:30','8:45','9:00'],
  offices: ['office'],
  selectedOffice: null,
  actions:{
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
