root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Views.MainLayOut extends Backbone.View
  el: 'body'

  initialize: ->
    @firstLoad = yes # There is no need to update on first load, so we check using this variable
    @fadeInClass = 'fastFadeIn'
    @fadeOutClass = 'fastFadeOut'
    @$regions =
      main: $('#mainContent')
      extra: $('#afterFooter')
    @oldViews = []

  fadeOut: (region)->
    @$regions[region].removeClass(@fadeInClass)
        .addClass(@fadeOutClass)

  fadeIn: (region)->
    @$regions[region].removeClass(@fadeOutClass)
        .addClass(@fadeInClass)

  closeOldViews: (region)->
    unless _.isEmpty(@oldViews[region])
      console.log 'closing region ' + region
      for view in @oldViews[region]
        console.log 'view to be closed', view
        console.log 'closed view on region:', region
        view.close()

  ###
  # Takes an array containing one or more view instance as argument, adds a fadeOut fx to hide the current content
  # then it renders each view instance from the array and extracts its node element (el) and pushes it into an array
  # that is later (after the fadeIn completes) added as the html content of the layoutView
  ###
  show: (regions)->
    if not @firstLoad
      for own regionName, views of regions
          console.log 'regionName', regionName
          @showRegion(views, regionName)
    else
     for own regionName, views of regions
       @oldViews[regionName] = views
     @firstLoad = no

  showRegion: (views, region = 'main')->
    console.log 'Showing views'

    # Based on the .fastFadeIn and .fastFadeOut duration, changes
    # must be made in the css classes and here to alter the delay
    delay = 500
    @fadeOut(region)
    viewNodes = []
    for view in views
      node =  view.render().el
      viewNodes.push(node)

    # We wait until the fadeOut is complete to clean the regions and append our new views
    _.delay(
      _.bind ->
        @closeOldViews(region)
        console.log 'Done closing views, now we call html() with the new nodes->', viewNodes
        @$regions[region].html(viewNodes)
        @fadeIn(region)
        @oldViews[region] = views
      , this
      delay)

    this
