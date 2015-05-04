import DS from 'ember-data';

export default DS.Model.extend({
  direction: DS.attr('string'),
  time: DS.attr('string'),
  type: DS.attr('string'),
  freeSeats: DS.attr('number'),
  fromAddress: DS.attr('string'),
  toAddress: DS.attr('string'),
  fromCity: DS.attr('string'),
  toCity: DS.attr('string'),
  office: DS.belongsTo('office', {async: true}),
  user: DS.belongsTo('user', {async: true}),
  status: DS.attr('string'),
  createdAt: DS.attr('date'),
  updatedAt: DS.attr('date'),
  isActive: function(){
    return this.get('status') === 'waiting';
  }.property('status')
});
