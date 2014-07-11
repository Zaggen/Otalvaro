root = window ? global
Otalvaro = root.Otalvaro

#Models

class Otalvaro.Models.Blog extends Backbone.Model

  defaults:
    title: 'Lorem'
    content: 'Lorem ipsum dolor, the cake was really yummy.'
    excerpt: 'Lorem ipsum dolor...'
    thumbnail: 'dummy.jpg'
    date: '2 Abril 2014'

#Collections

class Otalvaro.Collections.Blog extends Backbone.Collection
  model: Otalvaro.Models.Blog
  url: '/blog'