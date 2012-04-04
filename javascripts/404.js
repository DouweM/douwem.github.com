(function() {

  $(document).ready(function() {
    var filename, url;
    url = window.location.pathname;
    filename = url.slice(url.lastIndexOf("/") + 1);
    $("#filename").text("\"" + filename + "\"");
    return window.personalSite.setLastSectionMarginBottom();
  });

}).call(this);
