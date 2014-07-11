root = window ? global
Otalvaro = root.Otalvaro

# Pagination View

class Otalvaro.Views.pagination extends  Backbone.View
  className: '.pageNavi',
  tagName: 'ul'

  initialize: (options)->
    @feed = options.collectionView
    @pageQ = parseInt @$el.attr('data-page-quantity')
    @setCurrentPageNum(1)

  setCurrentPageNum:(currentPageNum) ->
    @currentPageNum = parseInt(currentPageNum)
    @render(renderedView)

  updatePage: (currentPageNum) ->
    @setCurrentPageNum(currentPageNum)
    @feed.fetchCollection(currentPageNum)

  render: ->
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
        liItem = new Otalvaro.Views.pageBtn
          pageNum : num
          className: if num is selectedPage then 'navBtns selectedNav' else 'navBtns'
          parentInstance: this
        skipped = no
      else
        if not skipped
          liItem = new Otalvaro.Views.naviItem
            pageNum: '...'
            className: 'navBtns dots'

          skipped = yes


      nodes.push liItem.render(renderedView).el
    @$el.html nodes
    this

class Otalvaro.Views.naviItem extends Backbone.View
  tagName: 'li'
  className: 'navBtns'

  initialize: (options)->
    @pageNum = options.pageNum

  render: ->
    @$el.text @pageNum
    this



class Otalvaro.Views.pageBtn extends Otalvaro.Views.naviItem
  events:
    'click': 'changePage'

  initialize: (options)->
    super
    @navi = options.parentInstance

  changePage: (e)=>
    @$navBtns = $('.navBtns')
    @crntPage = $(e.currentTarget).text()
    $('body').css 'cursor','wait'

    @navi.updatePage(@crntPage)
    @updateRoute()
    null

  updateRoute: ->
    route = 'noticias/pagina/' + @crntPage;
    Backbone.history.navigate(route)
    null



# Return to News List Btn


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
