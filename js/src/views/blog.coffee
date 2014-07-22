root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Views.Blog extends Otalvaro.Views.CompositeView
  template: root.template('blogTemplate')
  tagName: 'div'
  className: 'grid'

  initialize:(options)->
    super
    if $('#blogContent')[0]?
      @setElement('#blogContent')


class Otalvaro.Views.BlogEntry extends Backbone.View
  tagName: 'li'
  className: 'grid entryFeed'
  template: template('blogEntryTemplate')

  events:
    'click': 'showFullEntry'

  showFullEntry: (e)=>
    ###e.preventDefault()
    e.stopPropagation()
    fullNews = new Otalvaro.Views.fullNews model: @model
    $newsWrapper = $(@$el.closest '.newsContentWrapper')
    $newsWrapper.html(fullNews.render(renderedView).el)###
    null

  render: ->
    @$el.html( @template @model.toJSON() )
    this