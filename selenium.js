var Machine = require("simwms-build").Machine;

// Here's your chance to tell simwms-build what pages you wish to built
var Paths = [
  "/"
]

module.exports = function(options) {
  var webdriver = options.webdriver;
  var chrome = options.chrome;

  var chromeOptions = new chrome.Options();
  chromeOptions.addArguments(['--incognito']);

  var driver = new webdriver.Builder()
    .forBrowser('chrome')
    .setChromeOptions(
      new chrome.Options()
        .addArguments('--incognito')
    )
    .build();

  return Machine
  .using(driver, webdriver)
  .buildApp(Paths)
  .then(function() { return driver.quit(); });
};