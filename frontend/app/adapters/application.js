import DS from 'ember-data';

export default DS.RESTAdapter.extend({
  namespace: 'api/v1',
  host: 'http://localhost:3000',
//  buildURL: function(record, suffix) {
//    var s = this._super(record, suffix);
//    return s + ".json";
//  }
});
