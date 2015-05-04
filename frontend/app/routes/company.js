import Ember from 'ember';

export default Ember.Route.extend({
  model: function (params){
    console.log(params);
    return this.store.find('companies', params.company_id);
  }
});
