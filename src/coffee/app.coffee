MainView = require './view/main'
Me       = require './model/me'
Router   = require './router'

window.app =
  init: ->
    @me = new Me()
    @view = new MainView
      el: document.body
      model: @me
    @router = new Router()
    @router.history.start()

window.app.init()
