root = window ? global
Otalvaro = root.Otalvaro

# Hides or shows the slider by decreasing or increasing the element height

class Otalvaro.Views.SliderCover extends Backbone.View
  el: '#sliderCover'

  initialize: ->
    @collapsed = yes
    @collapsedHeight = 30
    @$slider = @$el.children()
    @getSliderHeight()
    $(window).on('resize', @updateSliderCover)

  collapse: ->
    if not @collapsed
      @$el.css('height',"#{@collapsedHeight}px")
      @collapsed = yes

  expand: (expandUpdate = no)->
    if @collapsed or expandUpdate
      @$el.css('height', @height)
      @collapsed = no

  getSliderHeight: ->
    sliderHeight =  @$slider.height()
    @height = if sliderHeight is 0 then  "#{@collapsedHeight}px" else "#{sliderHeight}px"

  resetHeight: ->
    @getSliderHeight()

  updateSliderCover: =>
    @resetHeight()
    if not @collapsed
      @expand(yes)