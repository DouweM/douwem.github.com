$(document).ready ->
  setLastSectionMinHeight()
  $(window).on "resize", setLastSectionMinHeight
  
  $("header nav a").on "click", handleNavLinkClick
  
  $(window).on "keydown", handleKeyDown

verticallyCenterTextEl = (el) ->    
  elCenter = el.offset().top + (el.outerHeight() / 2)
  windowCenter = $(window).height() / 2
  
  $(window).scrollTop Math.ceil(elCenter - windowCenter)

setLastSectionMinHeight = ->
  lastSection = $("#traits section").last()
  headerEl    = $("h2", lastSection)
  lastSectionMinHeight = ($(window).height() / 2) + (headerEl.outerHeight() / 2)
  lastSection.css "min-height", Math.ceil(lastSectionMinHeight)

handleNavLinkClick = (event) ->  
  event.preventDefault()
  
  link      = $(event.target)
  href      = link.attr "href"
  sectionEl = $(href)
  headerEl  = $("h2", sectionEl)
  
  verticallyCenterTextEl headerEl

handleKeyDown = (event) ->
  return unless event.which in [38, 40] # Up, Down
  event.preventDefault()
  
  scrollCenter = $(window).scrollTop() + ($(window).height() / 2)
  
  centeredEl = null
  centerableEls = $("section h2, section ul li")
  lastElBottom = 0
  for el in centerableEls
    el = $(el)
    offset = el.offset()
    elBottom = (offset.top + el.outerHeight())
    
    if lastElBottom <= scrollCenter <= elBottom
      centeredEl = el
      break
      
    lastElBottom = elBottom
  
  centeredEl = centerableEls.last() if centeredEl == null
  
  centeredElIndex = centerableEls.index centeredEl
  
  otherIndex = if event.which == 38 then centeredElIndex - 1 else centeredElIndex + 1
  return unless 0 <= otherIndex < centerableEls.length
  
  otherEl = centerableEls.eq(otherIndex)
  verticallyCenterTextEl otherEl