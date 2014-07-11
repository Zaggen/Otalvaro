root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Views.MainLayOut extends Backbone.View
  el: '#mainContent'

  initialize: ->
    @firstLoad = yes # There is no need to update on first load, so we check using this variable

  update: (view)->
    if not @firstLoad
      @$el
        .removeClass('fastFadeIn')
        .addClass('fastFadeOut')
        .empty()
      view = view.setView(
        (renderedView)=>
          @render(renderedView)
      )
    else
      @firstLoad = no

  render: (view)->
    @$el
      .removeClass('fastFadeOut')
      .addClass('fastFadeIn')
      .append view
    this