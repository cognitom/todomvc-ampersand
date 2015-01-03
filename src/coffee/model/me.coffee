State = require 'ampersand-state'
Todos = require './todos'

module.exports = State.extend
  initialize: ->
    @listenTo @todos, 'change:completed add remove', @handleTodosUpdate
    @listenTo @, 'change:mode', @handleModeChange
    @handleTodosUpdate()

  collections:
    todos: Todos

  session:
    activeCount:
      type   : 'number'
      default: 0
    completedCount:
      type   : 'number'
      default: 0
    totalCount:
      type   : 'number'
      default: 0
    allCompleted:
      type   : 'boolean'
      default: false
    mode:
      type   : 'string'
      values : [
        'all'
        'completed'
        'active'
      ]
      default: 'all'

  derived:
    itemsLeftHtml:
      deps: ['activeCount']
      fn: ->
        plural = if @activeCount == 1 then '' else 's'
        '<strong>' + @activeCount + '</strong> item' + plural + ' left'

  handleTodosUpdate: ->
    total = @todos.length
    completed = @todos.getCompletedCount()
    @set
      completedCount: completed
      activeCount   : total - completed
      totalCount    : total
      allCompleted  : total == completed
  handleModeChange: -> @todos.setMode @mode
