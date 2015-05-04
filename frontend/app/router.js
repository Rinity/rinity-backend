import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

export default Router.map(function() {
  this.resource('users', function (){
    this.route('new');
    this.resource('user', { path: '/:user_id'}, function (){
      this.route('edit');
    });
  });

  this.resource('rides', function() {
    this.route('new');
    this.resource('ride', { path: '/:ride_id' });
  });

  this.resource('companies', function(){
    this.resource('company', { path: '/:company_id' }, function(){
      this.route('offices');
      this.route('employees');
    });
  });
  this.resource('offices', function() {
    this.resource('office', { path: '/:office_id' }, function(){
      this.route('employees');
    });
  });
});
