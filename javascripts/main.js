(function() {
  var handleNavLinkClick, setLastSectionMinHeight, verticallyCenterTextEl;

  $(document).ready(function() {
    setLastSectionMinHeight();
    $(window).on("resize", setLastSectionMinHeight);
    return $("header nav a").on("click", handleNavLinkClick);
  });

  verticallyCenterTextEl = function(el) {
    var elCenter, windowCenter;
    elCenter = el.offset().top + (el.height() / 2);
    windowCenter = $(window).height() / 2;
    return $(window).scrollTop(Math.ceil(elCenter - windowCenter));
  };

  setLastSectionMinHeight = function() {
    var headerEl, lastSection, lastSectionMinHeight;
    lastSection = $("#traits section").last();
    headerEl = $("h2", lastSection);
    lastSectionMinHeight = ($(window).height() / 2) + (headerEl.height() / 2);
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

}).call(this);
