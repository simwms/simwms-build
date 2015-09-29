/* jshint node: true */
'use strict';
require("coffee-script").register();

module.exports = {
  name: 'simwms-build',
  includedCommands: function() {
    return {
      'simwms-build:nojs': require('./lib/commands/nojs'),
      'simwms-build:init': require('./lib/commands/init')
    };
  }
};
