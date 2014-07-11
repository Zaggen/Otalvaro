root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Views.Home extends Otalvaro.Views.BaseContent
  template: root.template('homeTemplate')

  fetchModel: (callback)->
    @model.fetch
      success: =>
        @render(callback)
        root.twttr.widgets.load()
        return this
      error: (collection, response)->
        console.log 'Error while fetching the model', response
    this