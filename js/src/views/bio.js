// Generated by CoffeeScript 1.7.1
(function() {
  var Otalvaro, root,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  root = typeof window !== "undefined" && window !== null ? window : global;

  Otalvaro = root.Otalvaro;

  Otalvaro.Views.Bio = (function(_super) {
    __extends(Bio, _super);

    function Bio() {
      return Bio.__super__.constructor.apply(this, arguments);
    }

    Bio.prototype.template = root.template('bioTemplate');

    Bio.prototype.className = 'grid';

    return Bio;

  })(Otalvaro.Views.BaseContent);

}).call(this);

//# sourceMappingURL=bio.map
