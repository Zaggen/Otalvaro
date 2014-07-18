root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Views.MainLayOut extends Backbone.View
  el: '#mainContent'

  initialize: ->
    @firstLoad = yes # There is no need to update on first load, so we check using this variable
    @fadeInClass = 'fastFadeIn'
    @fadeOutClass = 'fastFadeOut'

  fadeOut: ->
    @$el.removeClass(@fadeInClass)
        .addClass(@fadeOutClass)

  fadeIn: ->
    @$el.removeClass(@fadeOutClass)
        .addClass(@fadeInClass)

  closeOldViews: ->
    if @oldViews?
      console.log 'clearing old views innerHtml'
      for view in @oldViews
        console.log view
        view.close()

  ###
  # Takes an array containing one or more view instance as argument, adds a fadeOut fx to hide the current content
  # then it renders each view instance from the array and extracts its node element (el) and pushes it into an array
  # that is later (after the fadeIn completes) added as the html content of the layoutView
  ###
  show: (views)->
    if not @firstLoad
      @fadeOut()
      delay = 500 # Based on the .fastFadeIn and .fastFadeOut duration, changes must be made in the classes and here to alter the delay
      viewNodes = []
      for view in views
        node =  view.render().el
        viewNodes.push(node)
      _.delay(
        _.bind ->
          @closeOldViews()
          @$el.html(viewNodes)
          @fadeIn()
        , this
      delay)
      @oldViews = views

      this
    else
      @firstLoad = no