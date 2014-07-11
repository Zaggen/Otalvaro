root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Views.CollectionView extends Backbone.View
  initialize: (options)->
    @collection.bind('change', @updateView)
    @itemViewClass = options.itemViewClass
    #@fetchCollection(1)

  setView: (callback)->
    @fetchCollection(1, false, callback)
    this

  setloadingState: (state)->
    fadeClass = 'halfFade'
    if state is 'start'
      @$el.addClass(fadeClass)
    else if state is 'end'
      $('body').css 'cursor','default'
      @$el.removeClass(fadeClass)
    else
      console.warn state + 'Is not a valid state for seTloadingState'

  updateView: =>
    @render().el

  fetchCollection: (page = 1, fetchCurrent = false, callback)->
    console.log 'fetching page collection', page
    @setloadingState('start')

    @collection.fetch
      data:
        page: page
      success: =>
        @render(callback)
      error: (collection, response)->
        console.log 'Error while fetching the collection'
        console.log response
      complete: =>
        @setloadingState('end')

    ###if(@page isnt page or fetchCurrent)
      @page = page
      @collection.fetch
        data:
          page: page
        success: =>
          @render(callback)
        error: (collection, response)->
          console.log 'Error while fetching the collection'
          console.log response
        complete: =>
          @setloadingState('end')

    else
      console.log 'fetchcurrent is false or you are loading the same route'
      @setloadingState('end')###

  render: (callback)=>
    console.log this
    @$el.empty()
    nodes = []

    _this = this

    @collection.each (entry)=>
      itemView = new _this.itemViewClass( model:entry )
      itemView.delegateEvents()
      nodes.push itemView.render().el

    @$el.append nodes
    callback(@el)
    this