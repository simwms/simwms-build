Machine = require("simwms-build").Machine;

# Here's your chance to tell simwms-build what pages you wish to built
Paths = [
  "/"
]

module.exports = ({webdriver, chrome, firefox}) ->
  chromeOptions = new chrome.Options()
  chromeOptions.addArguments ['--incognito']

  driver = new webdriver.Builder()
  .forBrowser('chrome')
  .setChromeOptions(chromeOptions)
  .build()

  console.log "about to use machine"
  machine = Machine.using(driver, webdriver)
  console.log "using machine"
  promise = machine.buildApp(Paths)
  console.log "starting build"
  promise.then -> driver.quit()