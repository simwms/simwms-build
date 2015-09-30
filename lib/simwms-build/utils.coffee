RSVP = require 'rsvp'
{exec} = require "child_process"

buildSuccess = /build success/i

startServer = (opts) ->
  new RSVP.Promise (resolve, reject) ->
    child = exec "ember s -prod --live-reload=false", opts, (error, stdout, stderr) ->
      console.log error
      console.log stderr
      console.log stdout
      switch
        when error?
          reject(error)
          child.kill('SIGINT')
        when stderr?
          reject(error)
          child.kill('SIGINT')
        when buildSuccess.exec(stdout)?
          console.log stdout
          resolve child
        else
          console.log "waiting..."

runCmd = (cmd, opts) ->
  new RSVP.Promise (resolve, reject) ->
    exec cmd, opts, (err, stdout, stderr) ->
      return reject err if err?
      console.log stdout if stdout?
      console.log stderr if stderr?
      resolve(stdout)

module.exports = {startServer, runCmd}