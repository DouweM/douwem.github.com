(function() {
  var currentlyCenteredEl, handleKeyDown, handleNavLinkClick, setLastSectionMarginBottom, verticallyCenterTextEl;

  $(document).ready(function() {
    setLastSectionMarginBottom();
    $(window).on("resize", setLastSectionMarginBottom);
    $("header nav a").on("click", handleNavLinkClick);
    return $(window).on("keydown", handleKeyDown);
  });

  verticallyCenterTextEl = function(el) {
    var elCenter, windowCenter;
    elCenter = el.offset().top + (el.outerHeight() / 2);
    windowCenter = $(window).height() / 2;
    return $(window).scrollTop(Math.ceil(elCenter - windowCenter));
  };

  setLastSectionMarginBottom = function() {
    var lastCenterable, lastSection, lastSectionMarginBottom;
    lastSection = $("#traits section").last();
    lastCenterable = $("h2, ul li", lastSection).last();
    lastSectionMarginBottom = ($(window).height() / 2) - (lastCenterable.outerHeight() / 2);
    return lastSection.css("margin-bottom", Math.ceil(lastSectionMarginBottom));
  };

  handleNavLinkClick = function(event) {
    var firstCenterable, href, link, section;
    event.preventDefault();
    link = $(event.target);
    href = link.attr("href");
    section = $(href);
    firstCenterable = $("h2, ul li", section).first();
    return verticallyCenterTextEl(firstCenterable);
  };

  currentlyCenteredEl = function(centerableEls) {
    var centeredEl, el, elTop, lastElTop, offset, scrollCenter, _i, _len;
    centerableEls = $(centerableEls.get().reverse());
    scrollCenter = $(window).scrollTop() + ($(window).height() / 2);
    centeredEl = null;
    lastElTop = 10000;
    for (_i = 0, _len = centerableEls.length; _i < _len; _i++) {
      el = centerableEls[_i];
      el = $(el);
      offset = el.offset();
      elTop = offset.top;
      if ((elTop <= scrollCenter && scrollCenter <= lastElTop)) {
        centeredEl = el;
        break;
      }
      lastElTop = elTop;
    }
    return centeredEl || centerableEls.last();
  };

  handleKeyDown = function(event) {
    var centerableEls, centeredEl, centeredElIndex, otherEl, otherIndex, _ref;
    if ((_ref = event.which) !== 38 && _ref !== 40) return;
    event.preventDefault();
    if (event.altKey) {
      centerableEls = $("h2:first-child, section > ul:first-child li:first-child", $("section"));
    } else {
      centerableEls = $("h2, ul li", $("section"));
    }
    centeredEl = currentlyCenteredEl(centerableEls);
    centeredElIndex = centerableEls.index(centeredEl);
    otherIndex = event.which === 38 ? centeredElIndex - 1 : centeredElIndex + 1;
    if (!((0 <= otherIndex && otherIndex < centerableEls.length))) return;
    otherEl = centerableEls.eq(otherIndex);
    return verticallyCenterTextEl(otherEl);
  };

}).call(this);
