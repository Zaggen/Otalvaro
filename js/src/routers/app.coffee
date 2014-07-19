root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Routers.Router extends Backbone.Router
  routes:
    '(/)' : 'home'
    'biografia(/)': 'bio'
    'blog(/)': 'blog'
    'fotos(/)': 'gallery'

  initialize: ->
    @mainNav = new Otalvaro.Views.navigation
    @sliderCover = new Otalvaro.Views.SliderCover

    @mainLayout = new Otalvaro.Views.MainLayOut

    # Home
    @homeModel = new Otalvaro.Models.Home

    # Bio
    @bioModel = new Otalvaro.Models.Bio

    # Blog
    @blogCollection = new Otalvaro.Collections.Blog
    @blogNavi = new Otalvaro.Views.Pagination
      elementId: '#blogNavi'
      collection: @blogCollection

    # Gallery
    @galleryCollection = new Otalvaro.Collections.Gallery
    @galleryNavi = new Otalvaro.Views.Pagination
      elementId: '#galNavi'
      collection: @galleryCollection

    baseFolder = window.location.pathname.replace('/','').split('/')[0]
    Backbone.history.start
      pushState: true
      root: baseFolder

  getCurrentRoute: ->
    currentRoute = root.removeTrailingSlash(Backbone.history.fragment)
    return currentRoute

  updateNav: (route = @getCurrentRoute())->
    @mainNav.findCurrentRoute(route)

  # Method to scroll up/down to a given position in px or to the
  # offset of an element which id matches the current route

  home:->
    homeView = new Otalvaro.Views.Home( model: @homeModel )
    @sliderCover.expand()
    @mainLayout.show([homeView])
    null

  bio: ->
    bioView = new Otalvaro.Views.Bio( model: @bioModel )
    @sliderCover.collapse()
    @mainLayout.show([bioView])

  blog: ->
    blogView = new Otalvaro.Views.Blog
      itemViewClass: Otalvaro.Views.BlogEntry
      collection: @blogCollection
      querySelector: '#blogFeed'

    @sliderCover.collapse()
    @mainLayout.show([blogView, @blogNavi])

  gallery: ->
    galleryView = new Otalvaro.Views.Gallery
      collection: @galleryCollection

    @sliderCover.collapse()
    @mainLayout.show([galleryView, @galleryNavi])

  page: ->
    @sliderCover.collapse()


$ ->
  root.app = new Otalvaro.Routers.Router();
  root.app.updateNav()