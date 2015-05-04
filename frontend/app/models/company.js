import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  address: DS.attr('string'),
  domain: DS.attr('string'),
  offices: DS.hasMany('offices', {async: true}),
//  employees: DS.hasMany('users',{inverse:'company'})
});
