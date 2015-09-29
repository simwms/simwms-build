{startServer, runCmd} = require "../simwms-build/utils"

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

module.exports =
  name: "simwms-build:nojs"
  description: "Builds and publishes the application using the selenium machine"
  works: "insideProject"
  availableOptions: [EnvOpt, BranchOpt]

  run: (options, rawArgs) ->
    ui = @ui
    root = @project.root
    execOptions = 
      cwd: root

    startServer(execOptions)
    .then (child) ->
      runCmd("ember selenium --build=false", execOptions)
      .then -> child.disconnect()
    .then ->
      runCmd("git checkout #{options.branch}", execOptions)
    .then ->
      runCmd("cp -Rf dist/* .", execOptions)
    .then ->
      runCmd("git add . --all && git commit -m '#{options.message}'", execOptions)
    .then ->
      runCommand("git checkout `git reflog HEAD | sed -n " +
        "'/checkout/ !d; s/.* \\(\\S*\\)$/\\1/;p' | sed '2 !d'`", execOptions)
    .then ->
      ui.write "should be good to push"

