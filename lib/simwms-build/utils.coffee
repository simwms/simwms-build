RSVP = require 'rsvp'
{exec, spawn} = require "child_process"

buildSuccess = /build success/i

startServer = (opts) ->
  new RSVP.Promise (resolve, reject) ->
    server = spawn("ember", ["s", "-prod", "--live-reload=false"], opts)
    server.stdout.on "data", (data) ->
      data = (new Buffer data).toString("utf-8")
      if buildSuccess.exec(data)?
        resolve server

    server.stderr.on "data", (data) ->
      data = (new Buffer data).toString("utf-8")
      console.log data
      server.kill()

    server.on "close", (code) ->
      console.log "server shutdown with #{code}"


runCmd = (cmd, opts) ->
  new RSVP.Promise (resolve, reject) ->
    exec cmd, opts, (err, stdout, stderr) ->
      return reject err if err?
      console.log stdout if stdout?
      console.log stderr if stderr?
      resolve(stdout)

module.exports = {startServer, runCmd}