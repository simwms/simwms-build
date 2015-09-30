var RSVP = require('rsvp');

module.exports = {
  normalizeEntityName: function() {},

  afterInstall: function() {
    return RSVP.all([
      this.addPackageToProject('ember-perf', '~0.0.12'),
      this.addPackageToProject("ember-cli-document-title", "~0.2.0"),
      this.addPackageToProject("chromedriver", "^2.19.0"),
      this.addPackageToProject("selenium-webdriver", "^2.46.1")
    ]);
  }
}