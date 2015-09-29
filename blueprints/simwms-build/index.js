var RSVP = require('rsvp');

module.exports = {
  normalizeEntityName: function() {},

  afterInstall: function() {
    return RSVP.all([
      this.addPackageToProject('ember-cli-selenium', '~0.1.1'),
      this.addPackageToProject('ember-perf', '~0.0.12'),
      this.addPackageToProject("ember-cli-document-title", "~0.2.0")
    ]);
  }
}