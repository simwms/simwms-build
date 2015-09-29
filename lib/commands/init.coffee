{runCmd} = require "../simwms-build/utils"

BranchOpt =
  name: "branch"
  type: String
  default: "gh-pages"
  description: 'The branch where you will publish to'

module.exports =
  name: "simwms-build:init"
  description: "Setups and cleans out the gh-pages branch (be sure your current branch workspace is clean!)"
  works: "insideProject"
  availableOptions: [BranchOpt]

  run: (options, rawArgs) ->
    ui = @ui
    root = @project.root
    execOptions = 
      cwd: root

    runCmd("git checkout #{options.branch}", execOptions)
    .catch ->
      runCmd("git checkout --orphan #{options.branch}", execOptions)
    .then ->
      runCmd("rm -rf `ls -a | grep -vE '\.gitignore|\.git|node_modules|bower_components|(^[.]{1,2}/?$)'`", execOptions)
    .then ->
      runCmd("git add -A", execOptions)
    .then ->
      runCmd("git commit -m 'simwms-build initial github branch setup'", execOptions)
    .then -> ui.write "Your branch has been setup"