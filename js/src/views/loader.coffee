root = window ? root
Otalvaro = root.Otalvaro

class Otalvaro.Views.MainLoader extends Backbone.View
  className: 'progress'

  initialize: ->
    if $('#mainLoader')[0]?
      @setElement('#mainLoader')

    @hideClass = 'hidden'
    $(document).on('showLoader', @show)
    $(document).on('hideLoader', @hide)
    @render()

  show: =>
    console.log 'showing loader'
    @$el.removeClass(@hideClass)

  hide: =>
    console.log 'hiding loader'
    @$el.addClass(@hideClass)