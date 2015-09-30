import Ember from 'ember';
export default Ember.Route.extend({
  title: function(tokens) {
   var base = 'Dummy ~ok';
   var hasTokens = tokens && tokens.length;

   return hasTokens ? tokens.reverse().join(' - ') + ' - ' + base : base;
  }
});