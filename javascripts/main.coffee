$(document).ready ->
  $("header nav a").on "click", handleNavLinkClick

verticallyCenterTextEl = (el) ->    
  elCenter = el.offset().top + (el.height() / 2)
  windowCenter = $(window).height() / 2
  
  $(window).scrollTop(Math.ceil(elCenter - windowCenter))

handleNavLinkClick = (event) ->  
  event.preventDefault()
  
  link      = $(event.target)
  href      = link.attr "href"
  sectionEl = $(href)
  headerEl  = $("h2", sectionEl)
  
  verticallyCenterTextEl(headerEl)

