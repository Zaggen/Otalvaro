root = window ? global
Otalvaro = root.Otalvaro

# Pagination View

class Otalvaro.Views.Pagination extends  Backbone.View
  className: 'pageNavi',
  tagName: 'ul',
  events:
    'click li': 'changePage'

  initialize: (options)->

    if $(options.elementId)[0]?
      @setElement(options.elementId)

    @collection = options.collection
    @url = options.url
    @pageQ = 3 #parseInt @$el.attr('data-page-quantity')
    @pageQ ?= @pageQ
    @currentPageNum = 1
    @render()

  updatePage: () ->
    @collection.fetchPage(@currentPageNum)
    @updateRoute()

  updateRoute: ->
    route = @url + '/' + @currentPageNum;
    Backbone.history.navigate(route)
    null

  changePage: (e)=>
    $('.navBtns').removeClass('selectedNav')
    @currentPageNum = $(e.currentTarget).text()
    @updatePage()
    $(e.currentTarget).addClass('selectedNav')
    null

  render: ->
    console.log 'rendering navi'
    # Renders the pagination list e.g : 1 - 2 - 3 ... 8 , probably should be refactored into smaller functions
    nodes = []
    btnsLimit = 4
    selectedPage = @currentPageNum
    halfLimit = btnsLimit / 2
    leftHalf = Math.ceil(halfLimit)
    rightHalf = btnsLimit - leftHalf

    for x in [leftHalf..0]
      if selectedPage - x <= 0
        leftHalf--
        rightHalf++

    for x in [rightHalf..0]
      if selectedPage + x >= @pageQ
        leftHalf++
        rightHalf--


    minRange = selectedPage - leftHalf
    maxRange = selectedPage + rightHalf
    skipped = no

    for num in [1..@pageQ]

      if num is 1 or minRange <= num <= maxRange or num is @pageQ
        liItem = new Otalvaro.Views.naviItem
          pageNum : num
          className: if num is selectedPage then 'navBtns pageBtn selectedNav' else 'navBtns pageBtn'
          parentInstance: this
        skipped = no
      else
        if not skipped
          liItem = new Otalvaro.Views.naviItem
            pageNum: '...'
            className: 'navBtns dots'

          skipped = yes

      nodes.push liItem.render().el

    @$el.html nodes
    @delegateEvents();
    this

class Otalvaro.Views.naviItem extends Backbone.View
  tagName: 'li'
  className: 'navBtns'

  initialize: (options)->
    @pageNum = options.pageNum

  render: ->
    @$el.text @pageNum
    this


class Otalvaro.Views.ReturnToListBtn extends Backbone.View
  initialize: (options)->
    @listView = options.listView
    @el = options.el
    @nav = options.nav

  events:
    'click': 'backToList'

  backToList: =>
    @listView.fetchCollection(@listView.page, yes)
    @$el.addClass('hidden')
    @nav.$el.removeClass('hidden')
