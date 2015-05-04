import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  address: DS.attr('string'),
  city: DS.attr('string'),
  company: DS.belongsTo('company'),
  employees: DS.hasMany('users',{inverse:'default_office',async: true})
});
