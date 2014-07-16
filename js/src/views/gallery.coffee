root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Views.Gallery extends Otalvaro.Views.CollectionView
  template: root.template('galleryTemplate')
  tagName: 'div'
  className: 'grid'

  initialize: ->
    super
    if $('#galleryContent')[0]?
      @setElement('#galleryContent')

  events:
    'click img' : 'openLightBox'

  openLightBox: (e)->
    e.preventDefault()
    alert 'Lightbox en proceso de desarrollo'

  render: (callback)->
    console.log @el
    console.log 'Collection',@collection.models
    if _.isEmpty(@collection.models)
      console.log 'collection is empty, fetching it now'
      @collection.fetchPage(1)
    else
      console.log 'collection fetched, now rendering'
      @$el.html @template(galleryItems: @collection.toJSON())

    @delegateEvents();
    this