root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Views.BaseContent extends Backbone.View

  initialize: ->
    @model.bind('sync', @render, this)

  render: (callback)->
    if _.isEmpty(@model.toJSON())
      console.log 'model is empty, fetching it now'
      @model.fetch()
    else
      console.log 'model fetched, now rendering'
      @$el.html( @template(@model.toJSON()) )

    if _.isFunction(callback) then callback()
    this
