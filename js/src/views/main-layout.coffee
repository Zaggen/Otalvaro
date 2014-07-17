root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Views.MainLayOut extends Backbone.View
  el: '#mainContent'

  initialize: ->
    @firstLoad = yes # There is no need to update on first load, so we check using this variable

  fadeOut: ->
    @$el.removeClass('fastFadeIn')
        .addClass('fastFadeOut')

  fadeIn: ->
    @$el.removeClass('fastFadeOut')
        .addClass('fastFadeIn')

  show: (views)->
    if not @firstLoad
      @$el.empty()
      viewNodes = []
      for view in views
        node =  view.render().el
        viewNodes.push(node)

      console.log viewNodes
      @fadeOut()
      @$el.append(viewNodes)
      _.defer(_.bind(@fadeIn, this))
      this
    else
      @firstLoad = no