{runCmd, startServer} = require "../simwms-build/utils"
path = require('path')

ScriptOpt =
  name: "script"
  type: String
  default: "selenium.coffee"
  description: "location to the build script"

EnvOpt = 
  name: 'environment'
  type: String
  default: 'production'
  description: 'The ember environment to create a build for'

BranchOpt =
  name: "branch"
  type: String
  default: "gh-pages"
  description: 'The branch where you will publish to'

MessageOpt =
  name: "message"
  type: String
  default: "auto commit from nojs build"
  description: "The commit message"

runSelenium = ({cwd, script}) ->
  # console.log cwd
  # console.log script
  seleniumScript = require(path.join(cwd, script))
  # console.log seleniumScript
  chromedriver = require('chromedriver')
  # console.log "chromedriver"
  webdriver = require('selenium-webdriver')
  # console.log "webdriver"
  chrome = require('selenium-webdriver/chrome')
  # console.log "chrome"
  firefox = require('selenium-webdriver/firefox')
  # console.log "firefox"

  process.env.PATH = process.env.PATH + path.delimiter + path.dirname(chromedriver.path)
  # console.log "got here"
  seleniumScript
    webdriver: webdriver
    chrome: chrome
    firefox: firefox

module.exports =
  name: "simwms-build:nojs"
  description: "Builds and publishes the application using the selenium machine"
  works: "insideProject"
  availableOptions: [EnvOpt, BranchOpt, MessageOpt, ScriptOpt]

  run: (options, rawArgs) ->
    ui = @ui
    root = @project.root
    execOptions = 
      cwd: root
    seleOptions =
      cwd: root
      script: options.script

    startServer(execOptions)
    .then (server) ->
      runSelenium(seleOptions)
      .finally -> server.kill()
    .then ->
      runCmd("git checkout #{options.branch}", execOptions)
    .then ->
      runCmd("cp -R dist/* .", execOptions)
    .then ->
      runCmd("cp -R selenium-dist/* .", execOptions)
    .then ->
      runCmd("git add -A && git commit -m '#{options.message}'", execOptions)
    .then ->
      runCmd("git checkout `git reflog HEAD | sed -n " +
        "'/checkout/ !d; s/.* \\(\\S*\\)$/\\1/;p' | sed '2 !d'`", execOptions)
    .then ->
      ui.write "should be good to push"
