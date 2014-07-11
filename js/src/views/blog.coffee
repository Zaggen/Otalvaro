root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Views.Blog extends Otalvaro.Views.BaseContent
  template: root.template('blogTemplate')

  initialize: (options)->
    @itemView = options.itemView;

  setView: (@mainLayOutCallback)->
    @itemView.setView(@alert)
    this

  alert: (renderedView)=>

    header = $('<h2 class="navCrumb bioCrumb">Blog<i class="fa fa-book"></i></h2>')
    navi = $(' <ul id="newsNavi" class="pageNavi">
            <li class="navBtns selectedNav">1</li>
            <li class="navBtns">2</li>
            <li class="navBtns">3</li>
            <li class="navBtns">4</li>
        </ul>')

    nodeFragment = $(document.createDocumentFragment())
    nodeFragment
      .append(header)
      .append(renderedView)
      .append(navi)

    console.log nodeFragment

    @mainLayOutCallback(nodeFragment)

    ###html = '<h2 class="navCrumb bioCrumb">Blog
                <i class="fa fa-book"></i>
            </h2>'###

  render: ->
    @$el.html( @template @model.toJSON() )
    this


class Otalvaro.Views.BlogCollection extends Otalvaro.Views.CollectionView
  tagName: 'ul'
  id: 'blogFeed'
  className: 'feed'


class Otalvaro.Views.BlogEntry extends Backbone.View
  tagName: 'li'
  className: 'grid entryFeed'

  initialize: ->
    @template = template('blogEntryTemplate')

  events:
    'click': 'showFullEntry'

  showFullEntry: (e)=>
    e.preventDefault()
    e.stopPropagation()
    fullNews = new Otalvaro.Views.fullNews model: @model
    $newsWrapper = $(@$el.closest '.newsContentWrapper')
    $newsWrapper.html(fullNews.render(renderedView).el)
    null

  render: ->
    @$el.html( @template @model.toJSON() )
    this