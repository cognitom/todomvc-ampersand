Router = require 'ampersand-router'

module.exports = Router.extend
  routes:
    '*filter': 'setFilter'
  setFilter: (arg) ->
    app.me.mode = arg or 'all'
