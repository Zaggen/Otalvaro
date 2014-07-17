// Generated by CoffeeScript 1.7.1
(function() {
  var Otalvaro, root,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  root = typeof window !== "undefined" && window !== null ? window : global;

  Otalvaro = root.Otalvaro;

  Otalvaro.Views.Gallery = (function(_super) {
    __extends(Gallery, _super);

    function Gallery() {
      return Gallery.__super__.constructor.apply(this, arguments);
    }

    Gallery.prototype.template = root.template('galleryTemplate');

    Gallery.prototype.events = {
      'click img': 'openLightBox'
    };

    Gallery.prototype.openLightBox = function() {
      return alert('Lightbox en proceso de desarrollo');
    };

    return Gallery;

  })(Otalvaro.Views.BaseContent);

}).call(this);

//# sourceMappingURL=gallery.map