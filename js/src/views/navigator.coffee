root = window ? global
Otalvaro = root.Otalvaro

###
Navigation View
Handles the main NavBar logic, catches the mousedown events, then fires a navigate
function, that will trigger a route and the router will take care of the actual navigation.
Also marks the clicked item as the selected one.
###

class Otalvaro.Views.navigation extends Backbone.View
  el: '#mainNav'

  events:
    'mousedown a': 'navHandler'
    'click a': 'preventDefault'
    'click': 'toggleNavBar'

  initialize: ->
    @$navItems = @$el.find('a')
    @currentRoute = ''
    @mobileNavStatus = 'closed'

  # The actual logic fires on mousedown to save some miliseconds, but we still prevent the default click behavior
  preventDefault: (e)->
    e.preventDefault()

  navHandler: (e)=>
    e.stopPropagation()
    e.preventDefault()
    $currentTarget = $(e.currentTarget)
    linkTarget = $currentTarget.attr('href')
    @navigate(linkTarget, $currentTarget)

  navigate: (linkTarget, $currentTarget) =>
    @markAsSelected($currentTarget)
    Backbone.history.navigate(linkTarget, trigger: yes)

  markAsSelected: ($el)=>
    selectedClass = 'current_page_item'
    @$navItems.removeClass(selectedClass)
    $el.addClass(selectedClass)

  findCurrentRoute: (route)->
    index = 0
    for el in @$navItems
      elLink = $(el).attr('href')
      if elLink.indexOf(route) isnt -1
        break
      else
        index++

    @markAsSelected $(@$navItems[index])

  toggleNavBar: =>
    if @mobileNavStatus is 'closed'
      @openMobileMenu()
    else if @mobileNavStatus is 'open'
      @closeMobileMenu()

  openMobileMenu: ->
    @$el.addClass('openMenu')
    @mobileNavStatus = 'open'

  closeMobileMenu: ->
    @$el.removeClass('openMenu')
    @mobileNavStatus = 'closed'

