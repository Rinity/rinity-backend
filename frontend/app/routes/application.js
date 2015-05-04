import Ember from 'ember';

export default Ember.Route.extend({
    actions: {
      loginUser: function(username,password){
        console.log(username);
        console.log(password);
      }
    }
});
