import Ember from 'ember';

export default Ember.Route.extend({
  setupController: function(controller) {
    controller.set('fields', {});
    controller.set('fields.office', "472106647");
    controller.set('offices', this.store.find('office'));
  }
});
