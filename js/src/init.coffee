root = window ? global

$ = root.jQuery

root.template = (id)->
  #_.template( $('#' + id).html() ) # Underscore Version
  Handlebars.compile( $('#' + id).html() )

root.removeTrailingSlash = (route)->
  index = route.length - 1
  if route.charAt(index) is '/'
    route = route.substring(0, index)
  else
    route

# Used to filter each ajax json request for the backbone models
baseFolder = window.location.pathname.replace('/','').split('/')[0] # Also used as the backbone history root
rootUrl = window.location.protocol + "//" + window.location.host + "/" + baseFolder;
$.ajaxPrefilter (options)->
  options.url = rootUrl + options.url
  false

class root.Otalvaro
  @Models: {}
  @Collections: {}
  @Views: {}
  @Routers: {}