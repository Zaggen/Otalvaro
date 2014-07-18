root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Views.CollectionView extends Backbone.View
  initialize: (options)->
    @listenTo(@collection, 'reset', @render)
    @itemViewClass = options.itemViewClass

  renderCollectionNodes: ->
    nodes = []
    @collection.each (itemModel)=>
      itemView = new @itemViewClass( model:itemModel )
      itemView.delegateEvents()
      nodes.push itemView.render().el

    nodes

  render: (callback)=>
    @$el.empty()
    nodes = @renderCollectionNodes()

    @$el.append nodes
    if _.isFunction(callback) then callback()
    this

class Otalvaro.Views.CompositeView extends Otalvaro.Views.CollectionView

  initialize: (options)->
    super
    @querySelector = options.querySelector ? 'ul'

  render: ->
    console.log 'collection', @collection
    @$el.html @template()
    if _.isEmpty(@collection.models)
      console.log 'collection is empty, fetching it now'
      @collection.fetchPage(1)
    else
      console.log 'collection fetched, now rendering'
      collectionView = @$el.find(@querySelector)
      nodes = @renderCollectionNodes()
      collectionView.html(nodes)

    @delegateEvents();
    this