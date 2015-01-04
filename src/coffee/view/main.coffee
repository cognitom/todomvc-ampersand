View     = require 'ampersand-view'
TodoView = require './todo'

ENTER_KEY = 13

module.exports = View.extend
  template: require '../../hbs/component/body.hbs'

  events:
    'keypress #new-todo'    : 'keypress'
    'click #toggle-all'     : 'toggleAll'
    'click #clear-completed': 'clearCompleted'

  bindings:
    'model.totalCount':
      type    : 'toggle'
      selector: '#main, #footer'
    'model.completedCount': [
      type    : 'toggle'
      selector: '#clear-completed'
    ,
      type    : 'text'
      selector: 'completed-count'
    ]
    'model.itemsLeftHtml':
      type    : 'innerHTML'
      selector: 'todo-count'
    'model.mode':
      type: 'switchClass'
      name: 'selected'
      cases:
        'all'      : '.filters-none'
        'active'   : '.filters-active'
        'completed': '.filters-completed'
    'model.allCompleted':
      type    : 'booleanAttribute'
      name    : 'checked'
      selector: '#toggle-all'

  render: ->
    @renderWithTemplate()
    @renderCollection app.me.todos.subset, TodoView, @query '#todo-list'
    @mainInput = @query '#new-todo'
    @

  keypress: (e) ->
    val = @mainInput.value.trim()
    if e.which == ENTER_KEY and val
      app.me.todos.add title: val
      @mainInput.value = ''

  toggleAll: ->
    targetState = !app.me.allCompleted
    app.me.todos.each (todo) ->
      todo.completed = targetState

  clearCompleted: -> app.me.todos.clearCompleted()

