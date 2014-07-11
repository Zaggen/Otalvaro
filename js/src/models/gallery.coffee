root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Models.Gallery extends Backbone.Model
  url: '/fotos'

  defaults:
    images: ['imgs/dummy-0.jpg', 'imgs/dummy-2.jpg']