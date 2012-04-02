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

  currentlyCenteredEl = function() {
    var centerableEls, centeredEl, el, elBottom, lastElBottom, offset, scrollCenter, _i, _len;
    scrollCenter = $(window).scrollTop() + ($(window).height() / 2);
    centerableEls = $("section h2, section ul li");
    centeredEl = null;
    lastElBottom = 0;
    for (_i = 0, _len = centerableEls.length; _i < _len; _i++) {
      el = centerableEls[_i];
      el = $(el);
      offset = el.offset();
      elBottom = offset.top + el.outerHeight();
      if ((lastElBottom <= scrollCenter && scrollCenter <= elBottom)) {
        centeredEl = el;
        break;
      }
      lastElBottom = elBottom;
    }
    return centeredEl || centerableEls.last();
  };

  handleKeyDown = function(event) {
    var centerableEls, centeredEl, centeredElIndex, otherEl, otherIndex, _ref;
    if ((_ref = event.which) !== 38 && _ref !== 40) return;
    event.preventDefault();
    centerableEls = $("section h2, section ul li");
    centeredEl = currentlyCenteredEl();
    centeredElIndex = centerableEls.index(centeredEl);
    otherIndex = event.which === 38 ? centeredElIndex - 1 : centeredElIndex + 1;
    if (!((0 <= otherIndex && otherIndex < centerableEls.length))) return;
    otherEl = centerableEls.eq(otherIndex);
    return verticallyCenterTextEl(otherEl);
  };

}).call(this);
