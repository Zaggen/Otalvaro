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
    'mousedown a:not(.current_page_item)': 'navHandler'
    'click a': 'preventDefault'
    'click': 'toggleNavBar'

  initialize: ->
    @$navItems = @$el.find('a')
    @currentRoute = ''
    @mobileClosed = yes

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

    console.log index
    @markAsSelected $(@$navItems[index])

  toggleNavBar: =>
    if @mobileClosed
      @openMobileMenu()
    else
      @closeMobileMenu()

  openMobileMenu: ->
    @$el.addClass('openMenu')
    @mobileClosed = no

  closeMobileMenu: ->
    @$el.removeClass('openMenu')
    @mobileClosed = yes