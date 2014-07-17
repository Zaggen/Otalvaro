root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Views.CollectionView extends Backbone.View
  initialize: (options)->
    @collection.bind('sync', @updateView, this)
    @itemViewClass = options.itemViewClass

  updateView: =>
    @render()
    this

  render: (callback)=>
    @$el.empty()
    nodes = []

    @collection.each (itemModel)=>
      itemView = new @itemViewClass( model:itemModel )
      itemView.delegateEvents()
      nodes.push itemView.render().el

    @$el.append nodes
    if _.isFunction(callback) then callback()
    this