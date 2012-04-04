$(document).ready ->
  url = window.location.pathname
  filename = url[(url.lastIndexOf("/") + 1)..]
  $("#filename").text "\"#{filename}\""
  window.personalSite.setLastSectionMarginBottom()