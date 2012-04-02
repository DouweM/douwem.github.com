(function() {
  var handleKeyDown, handleNavLinkClick, setLastSectionMinHeight, verticallyCenterTextEl;

  $(document).ready(function() {
    setLastSectionMinHeight();
    $(window).on("resize", setLastSectionMinHeight);
    $("header nav a").on("click", handleNavLinkClick);
    return $(window).on("keydown", handleKeyDown);
  });

  verticallyCenterTextEl = function(el) {
    var elCenter, windowCenter;
    elCenter = el.offset().top + (el.outerHeight() / 2);
    windowCenter = $(window).height() / 2;
    return $(window).scrollTop(Math.ceil(elCenter - windowCenter));
  };

  setLastSectionMinHeight = function() {
    var headerEl, lastSection, lastSectionMinHeight;
    lastSection = $("#traits section").last();
    headerEl = $("h2", lastSection);
    lastSectionMinHeight = ($(window).height() / 2) + (headerEl.outerHeight() / 2);
    return lastSection.css("min-height", Math.ceil(lastSectionMinHeight));
  };

  handleNavLinkClick = function(event) {
    var headerEl, href, link, sectionEl;
    event.preventDefault();
    link = $(event.target);
    href = link.attr("href");
    sectionEl = $(href);
    headerEl = $("h2", sectionEl);
    return verticallyCenterTextEl(headerEl);
  };

  handleKeyDown = function(event) {
    var centerableEls, centeredEl, centeredElIndex, el, elBottom, lastElBottom, offset, otherEl, otherIndex, scrollCenter, _i, _len, _ref;
    if ((_ref = event.which) !== 38 && _ref !== 40) return;
    event.preventDefault();
    scrollCenter = $(window).scrollTop() + ($(window).height() / 2);
    centeredEl = null;
    centerableEls = $("section h2, section ul li");
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
    if (centeredEl === null) centeredEl = centerableEls.last();
    centeredElIndex = centerableEls.index(centeredEl);
    otherIndex = event.which === 38 ? centeredElIndex - 1 : centeredElIndex + 1;
    if (!((0 <= otherIndex && otherIndex < centerableEls.length))) return;
    otherEl = centerableEls.eq(otherIndex);
    return verticallyCenterTextEl(otherEl);
  };

}).call(this);
