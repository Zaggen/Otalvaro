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

  initialize: (options)->
    @hideClass = 'hidden'
    @currentIndex = 0
    @settings =  cycle: options.cycle ? yes

    $(document).on('showLightBox', @show);
    if $('#lightBox')[0]?
      @setElement('#lightBox')
    else
     @render()

  show: (e)=>
    @currentIndex = e.modelIndex
    console.log 'showing current index:', @currentIndex
    @$el.removeClass(@hideClass)
    model = @collection.at(@currentIndex).toJSON()
    @loadImage( model, yes )

  hide: ->
    @$el.addClass(@hideClass)
    @resizeWindow(0, 0, yes)
    @$figure.empty()

  hideLoader: ->
    @$progressLoader = @$progressLoader ? @$el.find('.progress')
    @$progressLoader.addClass(@hideClass)

  showLoader: ->
    @$progressLoader = @$progressLoader ? @$el.find('.progress')
    @$progressLoader.removeClass(@hideClass)

  prev: ()->
    if @currentIndex isnt 0
      @currentIndex--
    else
      if @settings.cycle
        @currentIndex = @collection.length - 1


    model = @collection.at(@currentIndex).toJSON()
    @loadImage(model)

  next: ()->
    if @currentIndex  < @collection.length - 1
      @currentIndex++
    else
      if @settings.cycle
        @currentIndex = 0

    model = @collection.at(@currentIndex).toJSON()
    @loadImage(model)

  loadImage: (model, addTransition = no)->

    @$figure ?= @$el.find('figure')
    @showLoader()

    img = new Image()
    img.onload = ()=>
      @$figure.html(img)
      @resizeWindow(img.width, img.height, addTransition)
      console.log 'imagen cargada'

    img.onerror = ()=>
      console.log 'imagen no encontrada'

    img.src = model.fullImg

  resizeWindow: (width, height, addTransition = no)->
    @$lightBoxWindow ?= @$el.find('.window')

    unless @limits?
      percentLimint = 0.8
      @limits =
        width : $('#lightBox').outerWidth() * percentLimint
        height : $('#lightBox').outerHeight() * percentLimint

    console.log @limits

    if(width > @limits.width or height > @limits.height)
      wMultiplier = @limits.width / width
      hMultiplier = @limits.height / height
      debugger
      multiplier = if wMultiplier < hMultiplier then wMultiplier else hMultiplier
      width *= multiplier
      height *= multiplier

    top = height / 2
    left = width / 2

    if addTransition
      @$lightBoxWindow.addClass('transitionAll')
    else
      @$lightBoxWindow.removeClass('transitionAll')

    @$lightBoxWindow.css
      width: "#{width}px"
      height: "#{height}px"
      margin: "-#{top}px 0 0 -#{left}px"


  render: ()->
    @$el.html @template()
    this