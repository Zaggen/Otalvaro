window.sliders = {}
$ = window.jQuery

class Slider
  constructor:(@sliderId, config = {})->

    @settings =
      #slideShow:         config.slideShow ? yes # Not implemented yet
      #stopOnHover:       config.stopOnHover ? yes # Not implemented yet
      cycle:             config.cycle ? yes
      navigator:         config.navigator ? yes
      navigatorEvents:   config.navigatorEvents ? no
      autoHideBtns:      config.autoHideBtns ? yes # Not implemented yet
      duration:          config.duration ? 1 # In seconds
      emmitEvents:       config.emmitEvents ? no
      draggable:         config.draggable ? yes
      centerImages:      config.centerImages ? yes

    #jQuery Objects
    @$sliderViewport   = $('#' + sliderId)
    @$slider           = $ @$sliderViewport.children('.slider')
    @$sliderItems      = $ @$slider.children('li')
    @$sliderPrevBtn    = $ @$sliderViewport.children('.prevBtn')
    @$sliderNextBtn    = $ @$sliderViewport.children('.nextBtn')

    # In order to prevent any other link event handler to activate first we find the childrens and use those to
    # stop and Immediate Propagation of the event
    if @settings.preventLinksOnDrag
      @$sliderLinks = @$sliderItems.children().children()

    #Slider sizing variables and settings

    @setSlider()

    ## Listeners

    @$sliderPrevBtn.click (e)=>
      e.stopPropagation()
      @slideTo('prev')

    @$sliderNextBtn.click (e)=>
      e.stopPropagation()
      @slideTo('next')

    # Navigator Bullets

    @$sliderNavBtns.mousedown (e)=>
      e.stopPropagation()
      index = $(e.currentTarget).index()
      @slideTo(index)

    # Drag
    if @settings.draggable
      @$sliderViewport.on 'mousedown', (e)=>
        e.stopPropagation()
        e.preventDefault()
        @draggedEl = e.currentTarget
        @dragStart(e.pageX)
        null

      @$sliderViewport.on 'touchstart', (e)=>
        e = e.originalEvent
        x = e.touches[0].pageX
        @draggedEl = e.currentTarget
        @dragStart(x, 'touchmove')
        null

      # Removes mousemove ev when the mouse is up anywhere in
      # the doc using the ev target stored in the mousedow ev
      # if @dragStartX means the current object called by the handler
      # did not started the mousedown event so we skip it

      $(document).on 'mouseup',(e)=>
        e.stopPropagation()
        e.preventDefault()
        @dragEnd(e.pageX)

      @$sliderViewport.on 'touchend',(e)=>
        x = e.originalEvent.touches[0].pageX
        @dragEnd(x)

    $( window ).resize =>
      @setSlider()


  addNavigator: ->
    navigatorHtml = '<ul class="navigator">';
    navigatorHtml = navigatorHtml + '<li class="navBullet selectedBullet"></li>'; # First item, already selected
    navigatorHtml = navigatorHtml + '<li class="navBullet"></li>' for i in [1...@elementsQ]
    navigatorHtml = navigatorHtml + '</ul>'
    @$sliderViewport.append(navigatorHtml)
    @$sliderNavBtns = $ @$sliderViewport.children('.navigator').children()

  # Centers images in the slider item (li) verticaly and horizontally.
  # Caveats: Assumes the images are fully loaded, and if not it might not center the image properly, must be
  # refactored to take this into account
  centerImagesInSlide: ->
    @$sliderItems.each ->
      img = $( $(this).find('img') )
      leftOffset = -img.outerWidth() / 2 + 'px'
      topOffset = -img.outerHeight() / 2 + 'px'
      img.css
        'margin-top': topOffset
        'margin-left': leftOffset

  setSlider: ->
    @viewPortWidth = @$sliderViewport.width()
    @elementsQ = @$sliderItems.length
    @sliderWidth = @elementsQ * 100
    sliderItemWidth = 100 / @elementsQ
    @rightLimit = (@viewPortWidth * @elementsQ) - @viewPortWidth #
    @$sliderItems.css 'width', "#{sliderItemWidth}%"

    @$slider.css
      'width': "#{@sliderWidth}%"
      'transition-duration': "#{@settings.duration}s"

    if @settings.centerImages then @centerImagesInSlide()
    if !@$sliderNavBtns? then @addNavigator()

    @index = 0
    @slideToPos = 0
    @draggedEl = null
    @hasLimitClass = false





  dragStart: (startX, inputEvent = 'mousemove')->
    $el = $ @draggedEl
    @dragStartX = startX
    slideToPos = @$slider.position().left
    dragPos = (slideToPos / @viewPortWidth) * 100

    @$slider.css
      'left': "#{dragPos}%"
      'transition-duration': '0s' # We are doing direct manipulation, no need for transitions here

    $el.on inputEvent, (ev)=>
      ev = ev.originalEvent
      x = if inputEvent is 'mousemove' then ev.pageX else ev.touches[0].pageX
      @dragg(startX, x, slideToPos)


  dragg: (startX, currentX, slideToPos) =>
    offsetX = startX - currentX # Difference between the new mouse x pos and the previus one
    slideToPos -= offsetX

    # Refactor below asap

    if slideToPos >= 0
      slideToPos = 0
      @isOutBounds = yes
      @dragStartX = currentX

      unless @hasLimitClass
        @$sliderViewport.addClass('onLeftLimit')
        @hasLimitClass = yes

    else if slideToPos <= -@rightLimit
      slideToPos = -@rightLimit
      @isOutBounds = yes
      @dragStartX = currentX

      unless @hasLimitClass
        @$sliderViewport.addClass('onRightLimit')
        @hasLimitClass = yes

    dragPos = (slideToPos / @viewPortWidth) * 100

    #@$slider.css('left', slideToPos + 'px') Deprecated px drag
    @$slider.css('left', dragPos + '%')
    @isOutBounds = no
    ###
    We should use a better way to move the elements around, using forced gpu calcs
    @$slider.css({
      '-webkit-transform': "translate3d(#{slideToPos}%, 0px, 0px) perspective(2000px)"
    })
    ###
    null

  dragEnd: (currentX)->
    if @draggedEl or @clicked #not working, always null :S
      console.log 'drag end event fired for ' + @sliderId
      console.log @draggedEl
      if @hasLimitClass
        @$sliderViewport.removeClass('onLeftLimit onRightLimit')
        @hasLimitClass = no

      offsetX = @dragStartX - currentX
      offsetPercentage = Math.abs (offsetX / @viewPortWidth)
      minToAction = 0.1 # The user must have dragged the slider at least 10% to move it
      if offsetPercentage < minToAction then offsetPercentage = 0

      if offsetX > 0 and not @isOutBounds

        ## Dragued-> right
        console.log "Dragued-> right"
        tempIndex = @index + Math.ceil(offsetPercentage)
      else if offsetX < 0 and not @isOutBounds

        ## Dragued-> left
        console.log "Dragued-> left"
        tempIndex = @index - Math.ceil(offsetPercentage)
      else

        ## Didn't move, or at least not much
        console.log "Didn't move, or at least not much"
        tempIndex = @index

      console.log "tempIndex:" + tempIndex
      @slideTo(tempIndex)

      # if it goes beyond a certain percentage we use slideTo to move
      # to the next slide or we use it to center up the current one
      $(@draggedEl).off('mousemove')

      #if not @settings.preventLinksOnDrag
      @draggedEl = null

      console.log @draggedEl
      false

  ###
  # Moves the slider to the prev, next, or an specific position based on the command argument
  # @param {string}|{integer} command
  # @return {void}
  ###

  slideTo: (command)->
    @clicked = null
    console.log 'slideTo Called with argument:' + command
    switch command
      when 'next'
        @index++
      when 'prev'
        @index--
      when 'first'
        @index = 0
      when 'last'
        @index = @elementsQ - 1
      else
        if isFinite(command)
          @index = command
        else
          err = 'Please provide a valid command for the slider [prev,next or a valid index]'
          console.error err
          return false


    lastIndx = (@elementsQ - 1)
    if @index > lastIndx
      if @settings.cycle
        @index = 0
      else
        @index = lastIndx
        return false
    else if @index < 0
      if @settings.cycle
        @index = lastIndx
      else
        @index = 0
        return false

    console.log 'index:' + @index
    slideToPos = -1 * (@index * 100)
    if(@settings.navigator)
      @$sliderNavBtns.removeClass 'selectedBullet'
      $(@$sliderNavBtns[@index]).addClass 'selectedBullet'

    @$slider.css
      'left': "#{slideToPos}%"
      'transition-duration': "#{@settings.duration}s"

    if(@settings.emmitEvents)
      $.event.trigger('onSlide', [@index, @sliderId]);

$ ->
  sliders.main = new Slider 'mainSlider'