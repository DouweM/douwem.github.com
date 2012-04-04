(function() {
  var PersonalSite,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  PersonalSite = (function() {

    function PersonalSite() {
      this.handleKeyDown = __bind(this.handleKeyDown, this);
      this.handleNavLinkClick = __bind(this.handleNavLinkClick, this);
      this.setLastSectionMarginBottom = __bind(this.setLastSectionMarginBottom, this);
      var _this = this;
      this.setLastSectionMarginBottom();
      $(window).on("resize", this.setLastSectionMarginBottom);
      $(window).on("orientationchange", this.setLastSectionMarginBottom);
      $(window).on("keydown", this.handleKeyDown);
      $("header nav a").on("click", this.handleNavLinkClick);
      $("section h2").on("click", function(event) {
        return _this.focusOnEl(event.target);
      });
    }

    PersonalSite.prototype.setLastSectionMarginBottom = function() {
      var lastFocusable, lastSection, lastSectionMarginBottom;
      lastSection = $("#traits section").last();
      lastFocusable = $("h2, ul li", lastSection).last();
      lastSectionMarginBottom = this._realWindowHeight() - (this._focusCenterFromWindowTop() + (lastFocusable.outerHeight() / 2));
      return lastSection.css("margin-bottom", Math.ceil(lastSectionMarginBottom));
    };

    PersonalSite.prototype.focusOnEl = function(focusableEl) {
      var focusableCenter;
      focusableEl = $(focusableEl);
      focusableCenter = focusableEl.offset().top + (focusableEl.outerHeight() / 2);
      return $(window).scrollTop(Math.ceil(focusableCenter - this._focusCenterFromWindowTop()));
    };

    PersonalSite.prototype.currentlyFocusedEl = function(focusableEls) {
      var el, elTop, focusedEl, lastElTop, offset, scrolledFocusCenter, _i, _len;
      if (focusableEls == null) focusableEls = $("h2, ul li", $("section"));
      focusableEls = $(focusableEls.get().reverse());
      scrolledFocusCenter = $(window).scrollTop() + this._focusCenterFromWindowTop();
      focusedEl = null;
      lastElTop = 10000;
      for (_i = 0, _len = focusableEls.length; _i < _len; _i++) {
        el = focusableEls[_i];
        el = $(el);
        offset = el.offset();
        elTop = offset.top;
        if ((elTop <= scrolledFocusCenter && scrolledFocusCenter <= lastElTop)) {
          focusedEl = el;
          break;
        }
        lastElTop = elTop;
      }
      return focusedEl || focusableEls.last();
    };

    PersonalSite.prototype.handleNavLinkClick = function(event) {
      var firstFocusable, href, link, section;
      event.preventDefault();
      link = $(event.target);
      href = link.attr("href");
      section = $(href);
      firstFocusable = $("h2, ul li", section).first();
      return this.focusOnEl(firstFocusable);
    };

    PersonalSite.prototype.handleKeyDown = function(event) {
      var focusableEls, focusedEl, focusedElIndex, link, otherEl, otherIndex, url;
      switch (event.which) {
        case 13:
          event.preventDefault();
          focusedEl = this.currentlyFocusedEl();
          link = $("a", focusedEl);
          if (link.length) {
            url = link.attr("href");
            if (link.attr("target") === "_blank") {
              return window.open(url);
            } else {
              return window.location.href = url;
            }
          }
          break;
        case 38:
        case 40:
          if (event.metaKey) return;
          event.preventDefault();
          if (event.altKey) {
            focusableEls = $("h2, ul:first-child li:first-child", $("section"));
          } else {
            focusableEls = $("h2, ul li", $("section"));
          }
          focusedEl = this.currentlyFocusedEl(focusableEls);
          focusedElIndex = focusableEls.index(focusedEl);
          otherIndex = event.which === 38 ? focusedElIndex - 1 : focusedElIndex + 1;
          if (!((0 <= otherIndex && otherIndex < focusableEls.length))) return;
          otherEl = focusableEls.eq(otherIndex);
          return this.focusOnEl(otherEl);
      }
    };

    PersonalSite.prototype._realWindowHeight = function() {
      if (navigator.userAgent.match(/(iPhone|iPod)/)) {
        return window.innerHeight;
      } else {
        return $(window).height();
      }
    };

    PersonalSite.prototype._focusCenterFromWindowTop = function() {
      if (navigator.userAgent.match(/(iPhone|iPod)/)) {
        return $("header").outerHeight(true) / 2;
      } else {
        return $(window).height() / 2;
      }
    };

    return PersonalSite;

  })();

  $(document).ready(function() {
    return window.personalSite = new PersonalSite;
  });

}).call(this);
