# Takes two parameters: container and application
initialize = ->
  Ember.$('#ember-app').empty()
  # application.register 'route', 'foo', 'service:foo'

CleanBodyInitializer =
  name: 'clean-body'
  initialize: initialize

`export {initialize}`
`export default CleanBodyInitializer`
