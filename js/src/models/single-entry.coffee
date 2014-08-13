root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Models.SingleEntry extends Otalvaro.Models.Base

  fetch: ->
    @url = '/' + Backbone.history.fragment
    console.log '@url', @url
    super
    true