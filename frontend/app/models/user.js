import DS from 'ember-data';

export default DS.Model.extend({
  email: DS.attr('string'),
  name: DS.attr('string'),
  address: DS.attr('string'),
  city: DS.attr('string'),
  type: DS.attr('string'),

//  password: DS.attr('string'),
//  passwordConfirmation: DS.attr('string'),
//
//  created_at: DS.attr('date'),
//  updated_at: DS.attr('date'),
//
  company: DS.belongsTo('company'),
  default_office: DS.belongsTo('office'),
  rides: DS.hasMany('ride',{async: true})
});
