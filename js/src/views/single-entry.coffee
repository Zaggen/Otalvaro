root = window ? global
Otalvaro = root.Otalvaro

# Full Entry View
class Otalvaro.Views.SingleEntry extends Otalvaro.Views.BaseContent
  template: root.template('singleEntryTemplate')
  className: 'grid'
  id: 'singleEntry'

  initialize: ->
    super
    if $('#singleEntry')[0]?
      @setElement('#singleEntry')