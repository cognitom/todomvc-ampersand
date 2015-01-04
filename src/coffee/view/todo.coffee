View = require 'ampersand-view'

ENTER_KEY = 13
ESC_KEY   = 27

module.exports = View.extend
  template: require '../../hbs/component/todo.hbs'
  #template: require '../../jade/component/todo.jade'

  events:
    'change .toggle': 'checkTask'
    'click .destroy': 'removeTask'
    'dblclick label': 'editTask'
    'keyup .edit'   : 'editTaskKeyup'
    'blur .edit'    : 'saveTask'

  bindings:
    'model.title': [
      type    : 'text'
      selector: 'label'
    ,
      type    : 'value'
      selector: '.edit'
    ]
    'model.editing': [
      type: 'toggle'
      yes : '.edit'
      no  : '.view'
    ,
      type: 'booleanClass'
    ]
    'model.completed': [
      type    : 'booleanAttribute'
      name    : 'checked'
      selector: '.toggle'
    ,
      type: 'booleanClass'
    ]

  render: ->
    @renderWithTemplate()
    @input = @query '.edit' # cache reference
    @

  checkTask: (e) -> @model.completed = e.target.checked

  removeTask: -> @model.destroy()

  editTask: ->
    @model.editing = true
    @input.focus()

  editTaskKeyup: (e) ->
    if e.which == ENTER_KEY
      @input.blur()
    else if e.which == ESC_KEY
      @input.value = @model.title
      @input.blur()

  saveTask: ->
    if val = @input.value.trim()
      @model.set
        title: val
        editing: false
    else
      @model.destroy()
