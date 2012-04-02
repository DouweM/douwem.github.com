(function() {
  var handleNavLinkClick, verticallyCenterTextEl;

  $(document).ready(function() {
    return $("header nav a").on("click", handleNavLinkClick);
  });

  verticallyCenterTextEl = function(el) {
    var elCenter, windowCenter;
    elCenter = el.offset().top + (el.height() / 2);
    windowCenter = $(window).height() / 2;
    return $(window).scrollTop(Math.ceil(elCenter - windowCenter));
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
