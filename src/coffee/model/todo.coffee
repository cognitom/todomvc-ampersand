State = require 'ampersand-state'

module.exports = State.extend
  props:
    title:
      type   : 'string'
      default: ''
    completed:
      type   : 'boolean'
      default: false

  session:
    editing:
      type   : 'boolean'
      default: false

  destroy: -> @collection?.remove @
