MainView = require './view/main'
Me       = require './model/me'
Router   = require './router'
domready = require 'domready'

window.app =
  init: ->
    @me = new Me()
    @router = new Router()
    domready =>
      @view = new MainView
        el: document.body
        model: @me
      @view.render()
      @router.history.start()

window.app.init()
