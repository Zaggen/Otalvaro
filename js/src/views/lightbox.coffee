root = window ? global
Otalvaro = root.Otalvaro

# Pagination View

class Otalvaro.Views.Lightbox extends Backbone.View

  template: root.template('lightBoxTemplate')

  events:
    'click .overlay .closeBtn': 'hide'

  initialize: ->
    @hideClass = 'hidden'
    @currentIndex = 0
    $(document).on('showLightBox', @show);

  show: (e)->
    @currentIndex = e.modelIndex
    console.log 'showing current index:', @currentIndex
    @$el.removeClass(@hideClass)
    @loadImage( @collection.at(@currentIndex) )

  hide: ->
    @$el.addClass(@hideClass)
    @$figure.empty()

  hideLoader: ->
    @$progressLoader = @$progressLoader ? @$el.find('.progress')
    @$progressLoader.addClass(@hideClass)

  showLoader: ->
    @$progressLoader = @$progressLoader ? @$el.find('.progress')
    @$progressLoader.removeClass(@hideClass)

  prev: ()->
    @loadImage( @collection.at(--@currentIndex) )

  next: ()->
    @loadImage( @collection.at(++@currentIndex) )

  loadImage: (model)->

    @$figure = @figure? @$el.find('figure')
    @showLoader()

    img = new Image()
    img.onload = ()=>
      @$figure.html(img)

      console.log 'imagen cargada'

    img.onerror = ()=>
      console.log 'imagen no encontrada'

    img.src = model.fullImg

  render: (model)->
    @$el.html @template()