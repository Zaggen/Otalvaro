root = window ? global
Otalvaro = root.Otalvaro

class Otalvaro.Views.Gallery extends Otalvaro.Views.BaseContent
  template: root.template('galleryTemplate')

  events:
    'click img' : 'openLightBox'

  openLightBox: ->
    alert 'Lightbox en proceso de desarrollo'