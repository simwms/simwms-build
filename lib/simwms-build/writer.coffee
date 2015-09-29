path = require("path")
fs = require("fs-extra")

class Writer
  constructor: (@base) ->

  write: (@fileContents) -> @

  intoFile: (name) ->
    filename = @makeFileName(name) 
    fs.outputFileSync(filename, @fileContents)

  makeFileName: (name) ->
    path.normalize path.join(@base, "#{name}.html")

module.exports = Writer