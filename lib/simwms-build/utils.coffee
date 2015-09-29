RSVP = require 'rsvp'
{exec, spawn} = require "child_process"

startServer = (opts) ->
  new RSVP.Promise (resolve, reject) ->
    child = spawn("ember", ["s", "-prod", "--live-reload=false"], opts)
    child.stdout.on "data", (data) ->
      console.log data
      buildSuccess = /build success/i
      if buildSuccess.exec(data)?
        resolve child

    child.stderr.on "data", (data) ->
      console.log data
      reject child

    child.on "close", (code) ->
      console.log "process exited with #{code}"
      reject child

runCmd = (cmd, opts) ->
  new RSVP.Promise (resolve, reject) ->
    exec cmd, opts, (err, stdout, stderr) ->
      return reject err if err?
      console.log stdout if stdout?
      console.log stderr if stderr?
      resolve(stdout)

module.exports = {startServer, runCmd}