Collection    = require 'ampersand-collection'
SubCollection = require 'ampersand-subcollection'
debounce      = require 'debounce'
Todo          = require './todo'

STORAGE_KEY   = 'todos-ampersand'

module.exports = Collection.extend
  model: Todo

  initialize: ->
    @readFromLocalStorage()
    @subset = new SubCollection @
    @writeToLocalStorage = debounce @writeToLocalStorage, 100
    window.addEventListener 'storage', (e) =>
      @readFromLocalStorage() if e.key == STORAGE_KEY
    @on 'all', @writeToLocalStorage, @

  getCompletedCount: ->
    @reduce (total, todo) ->
      if todo.completed then ++total else total
    , 0

  clearCompleted: ->
    toRemove = @filter (todo) -> todo.completed
    @remove toRemove

  setMode: (mode) ->
    if mode == 'all'
      @subset.clearFilters()
    else
      @subset.configure
        where:
          completed: mode == 'completed'
      , true

  writeToLocalStorage: -> localStorage[STORAGE_KEY] = JSON.stringify @

  readFromLocalStorage: ->
    existingData = localStorage[STORAGE_KEY]
    @set JSON.parse existingData if existingData
