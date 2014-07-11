root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Views.BaseContent extends Backbone.View

  setView: (callback)->
    @fetchModel(callback)
    this

  fetchModel: (callback)->
    @model.fetch
      success: =>
        @render(callback)
      error: (collection, response)->
        console.log 'Error while fetching the model', response
    this

  render: (callback)->
    @$el.html @template(@model.toJSON())
    callback(@el)
    this