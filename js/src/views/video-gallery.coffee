root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Views.VideoGallery extends Otalvaro.Views.CollectionView
  template: root.template('videoGalleryTemplate')
  tagName: 'div'
  className: 'grid'

  initialize: ->
    super
    if $('#videoGalleryContent')[0]?
      @setElement('#videoGalleryContent')

  events:
    'click img' : 'openLightBox'

  openLightBox: (e)->
    e.preventDefault()
    index = parseInt $(e.currentTarget).data('index')
    console.log 'index', index
    $.event.trigger({
      type: 'showLightBox'
      modelIndex: index
    })

  render: (callback)->
    console.log @el
    if _.isEmpty(@collection.models)
      console.log 'collection is empty, fetching it now'
      @collection.fetchPage(1)
    else
      console.log 'collection fetched, now rendering'
      @$el.html @template(galleryItems: @collection.toJSON())

    @delegateEvents()
    this