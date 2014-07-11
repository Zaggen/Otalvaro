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
    homeModel = new Otalvaro.Models.Home
    @homeView = new Otalvaro.Views.Home( model: homeModel )

    # Bio
    bioModel = new Otalvaro.Models.Bio
    @bioView = new Otalvaro.Views.Bio( model: bioModel )

    # Blog
    blogCollection = new Otalvaro.Collections.Blog
    blogCollectionView = new Otalvaro.Views.BlogCollection
      itemViewClass: Otalvaro.Views.BlogEntry
      collection: blogCollection

    @blogView = new Otalvaro.Views.Blog( itemView: blogCollectionView)


    # Gallery
    galleryModel = new Otalvaro.Models.Gallery
    @galleryView = new Otalvaro.Views.Gallery( model: galleryModel )

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
    @sliderCover.expand()
    @mainLayout.update(@homeView)
    null

  bio: ->
    @sliderCover.collapse()
    @mainLayout.update(@bioView)

  blog: ->
    @sliderCover.collapse()
    @mainLayout.update(@blogView)

  gallery: ->
    @sliderCover.collapse()
    @mainLayout.update(@galleryView)

  page: ->
    @sliderCover.collapse()


$ ->
  root.app = new Otalvaro.Routers.Router();
  root.app.updateNav()