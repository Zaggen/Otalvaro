class Otalvaro.Collections.Paginated extends Backbone.Collection

  fetchPage: (page = 1, callback)->
    console.log 'fetching page collection', page

    @fetch
      reset: yes
      data:
        page: page
      success: =>
        if callback then callback()
      error: (collection, response)->
        console.log 'Error while fetching the collection'
        console.log response
    this