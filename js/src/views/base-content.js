// Generated by CoffeeScript 1.7.1
(function() {
  var Otalvaro, root,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  root = typeof window !== "undefined" && window !== null ? window : global;

  Otalvaro = root.Otalvaro;

  Otalvaro.Views.BaseContent = (function(_super) {
    __extends(BaseContent, _super);

    function BaseContent() {
      return BaseContent.__super__.constructor.apply(this, arguments);
    }

    BaseContent.prototype.setView = function(callback) {
      this.fetchModel(callback);
      return this;
    };

    BaseContent.prototype.fetchModel = function(callback) {
      this.model.fetch({
        success: (function(_this) {
          return function() {
            return _this.render(callback);
          };
        })(this),
        error: function(collection, response) {
          return console.log('Error while fetching the model', response);
        }
      });
      return this;
    };

    BaseContent.prototype.render = function(callback) {
      this.$el.html(this.template(this.model.toJSON()));
      callback(this.el);
      return this;
    };

    return BaseContent;

  })(Backbone.View);

}).call(this);

//# sourceMappingURL=base-content.map