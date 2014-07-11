root = window ? global
Otalvaro = root.Otalvaro

#Models

class Otalvaro.Models.Bio extends Backbone.Model
  url: '/biografia'

  defaults:
    title: 'Lorem'
    content: '2 Abril 2014'
    profileImg: 'dummy.jpg'