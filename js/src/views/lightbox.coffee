root = window ? global
Otalvaro = root.Otalvaro

# Pagination View

class Otalvaro.Views.Lightbox extends Backbone.View
  template: root.template('lightBoxTemplate')
  className: 'lightBox hidden'

  events:
    'click .closeBtn, .overlay': 'hide'
    'click .prevBtn': 'prev'
    'click .nextBtn': 'next'

  initialize: ->
    console.log 'a new lightbox has been instanciated', this
    @hideClass = 'hidden'
    @currentIndex = 0
    $(document).on('showLightBox', @show)

    # If the element is present on the DOM there is no need to render the view, we just attach the el to it
    if $('#lightBox')[0]?
      console.log "setting el to #lightBox"
      @setElement('#lightBox')
    else
      @render()

  set: (options)->
    @collection = options.collection
    @settings =
      mode: options.mode ? 'images' # Could be iframes for embedded video iframes
      cycle: options.cycle ? yes

    if _.isEmpty(@collection.models)
      @populateCollection()

  show: (e)=>
    @currentIndex = e.modelIndex
    console.log 'showing current index:', @currentIndex
    @$el.removeClass(@hideClass)
    model = @collection.at(@currentIndex).toJSON()
    @loadContent( model, yes )

  hide: ->
    @$el.addClass(@hideClass)
    @resizeWindow(0, 0, yes)
    @$content.empty()

  hideLoader: ->
    @$progressLoader ?= @$el.find('.progress')
    @$progressLoader.addClass(@hideClass)

  showLoader: ->
    @$progressLoader ?= @$el.find('.progress')
    @$progressLoader.removeClass(@hideClass)

  prev: ()->
    # Only decrease the index when its greater than 0
    # or set to the last model in the collection when cycle is on
    if @currentIndex isnt 0
      @currentIndex--
    else
      if @settings.cycle
        @currentIndex = @collection.length - 1


    model = @collection.at(@currentIndex).toJSON()
    @loadContent(model)

  next: ()->
    # Only increase the index when its less than the collection size(-1)
    # or set back to the first model when cycle is on
    if @currentIndex  < @collection.length - 1
      @currentIndex++
    else
      if @settings.cycle
        @currentIndex = 0

    model = @collection.at(@currentIndex).toJSON()
    @loadContent(model)

  loadContent: (modelObj, addTransition = no)->
    if @settings.mode is 'images'
      @loadImage(modelObj, addTransition)
    else # @settings.mode is 'iframe'
      @loadIframe(modelObj, addTransition)

  loadImage: (modelObj, addTransition = no)->
    # Loads the img as an obj, and when is fully load places it on the figure container and then
    # resizes the lightbox window
    console.log 'load image'
    @showLoader()
    @$content ?= @$el.find('#lightboxContent')
    _self = @
    img = new Image()
    img.onload = ->
      _self.$content.html(img)
      _self.resizeWindow(img.width, img.height, addTransition)
      _self.hideLoader()
      console.log 'img loaded', _self

    img.onerror = ->
      console.log 'error, img not found'

    img.src = modelObj.fullImg

  loadIframe: (modelObj, addTransition = no)->
    @$content ?= @$el.find('#lightboxContent')
    @showLoader()
    iframeW = 600
    iframeH = 390
    $iframe = $('<iframe />')
      .attr('src', modelObj.embedUrl)
      .css
        width:  iframeW
        height: iframeH

    @$content.html($iframe)
    @resizeWindow(iframeW, iframeH)

    # Check if iframe is already loaded, else attach @hideLoader to the load event
    if $iframe.get(0).complete
      @hideLoader()
    else
      $iframe.load =>
        @hideLoader()



  resizeWindow: (width, height, addTransition = no)->
    @$lightBoxWindow ?= @$el.find('.window')

    unless @limits?
      percentLimint = 0.8
      @limits =
        width : @$el.outerWidth() * percentLimint
        height : @$el.outerHeight() * percentLimint

    console.log @limits

    if(width > @limits.width or height > @limits.height)
      wMultiplier = @limits.width / width
      hMultiplier = @limits.height / height
      multiplier = if wMultiplier < hMultiplier then wMultiplier else hMultiplier
      width *= multiplier
      height *= multiplier

    top = height / 2
    left = width / 2

    if addTransition
      @$lightBoxWindow.addClass('transitionAll')
    else
      @$lightBoxWindow.removeClass('transitionAll')

    console.log 'resizing to ' + width

    @$lightBoxWindow.css
      width: "#{width}px"
      height: "#{height}px"
      margin: "-#{top}px 0 0 -#{left}px"

  populateCollection: ->
    console.log 'populating collection for lightbox'
    _self = @
    lightboxContentKey = if @settings.mode is 'images' then 'fullImg' else 'embedUrl'
    $('.gallery a').each ->
      json = {}
      $link = $(this)
      json.title = $link.attr('title')
      json[lightboxContentKey] = $link.attr('href')
      json.thumbnail = $link.find('img').attr('src')

      _self.collection.add(json)

  close:->
    $(document).off('showLightBox', @show)
    super

  render: ->
    @$el.html @template()
    this