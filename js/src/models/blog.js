// Generated by CoffeeScript 1.7.1
(function() {
  var Otalvaro, root,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  root = typeof window !== "undefined" && window !== null ? window : global;

  Otalvaro = root.Otalvaro;

  Otalvaro.Models.Blog = (function(_super) {
    __extends(Blog, _super);

    function Blog() {
      return Blog.__super__.constructor.apply(this, arguments);
    }

    Blog.prototype.defaults = {
      title: 'Lorem',
      content: 'Lorem ipsum dolor, the cake was really yummy.',
      excerpt: 'Lorem ipsum dolor...',
      thumbnail: 'dummy.jpg',
      date: '2 Abril 2014'
    };

    return Blog;

  })(Backbone.Model);

  Otalvaro.Collections.Blog = (function(_super) {
    __extends(Blog, _super);

    function Blog() {
      return Blog.__super__.constructor.apply(this, arguments);
    }

    Blog.prototype.model = Otalvaro.Models.Blog;

    Blog.prototype.url = '/blog';

    return Blog;

  })(Backbone.Collection);

}).call(this);

//# sourceMappingURL=blog.map
