$(document).ready ->
  setLastSectionMinHeight()
  $(window).on "resize", setLastSectionMinHeight
  
  $("header nav a").on "click", handleNavLinkClick

verticallyCenterTextEl = (el) ->    
  elCenter = el.offset().top + (el.height() / 2)
  windowCenter = $(window).height() / 2
  
  $(window).scrollTop Math.ceil(elCenter - windowCenter)

setLastSectionMinHeight = ->
  lastSection = $("#traits section").last()
  headerEl    = $("h2", lastSection)
  lastSectionMinHeight = ($(window).height() / 2) + (headerEl.height() / 2)
  lastSection.css "min-height", Math.ceil(lastSectionMinHeight)

handleNavLinkClick = (event) ->  
  event.preventDefault()
  
  link      = $(event.target)
  href      = link.attr "href"
  sectionEl = $(href)
  headerEl  = $("h2", sectionEl)
  
  verticallyCenterTextEl headerEl

