path = require("path")
RSVP = require "rsvp"
asyncMap = require("./async-map")
Writer = require "./writer"

class Machine
  wait = (time) ->
    new RSVP.Promise (r) -> setTimeout r, time

  @using = (driver, webdriver) ->
    new Machine(driver, webdriver)
  
  buildApp: (@routes) ->
    @build()

  constructor: (@driver, @webdriver) ->
    @baseURI = "http://localhost:4200"
    @by = @webdriver.By
    @until = @webdriver.until
    @writer = new Writer("selenium-dist")

  write: (string) -> @writer.write(string)

  build: ->
    asyncMap @routes, @generatePage.bind(@)

  generatePage: (route) ->
    @driver
    .get @calculateURI route
    .then =>
      @driver.wait @until.titleMatches(/~ok$/), 1000
    .then =>
      wait 1500
    .then =>
      @driver.getPageSource()
    .then (source) =>
      @write(source).intoFile(@calculateFilename route)

  calculateURI: (route) ->
    path.normalize path.join(@baseURI, route)

  calculateFilename: (route) ->
    endsInSlash = /\/$/
    switch
      when endsInSlash.exec(route)? then path.join(route, "index")
      else route

module.exports = Machine