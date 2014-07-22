root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Views.Home extends Otalvaro.Views.BaseContent
  template: root.template('homeTemplate')

  initialize: ->
    super
    @inMemory = no
    @memoryRender = no

  close: =>
    unless @inMemory
      @$iframe = $( $('.twitter-timeline').contents().find('body').html() )
      @inMemory = yes

  render: (callback)->
    unless @memoryRender
      if(@inMemory)
        @$el.find('.twitterFeed').html(@$iframe)
        @memoryRender = yes
      else
        console.log 'not in memory, doing normal rendering'
        if _.isEmpty(@model.toJSON())
          console.log 'model is empty, fetching it now'
          @model.fetch()
        else
          console.log 'model fetched, now rendering'
          @$el.html( @template(@model.toJSON()) )
          _.delay( ->
              console.log 'firing twttr.widgets.load()'
              root.twttr.widgets.load()
          , 630)
          if callback? then callback(@el)

    this
