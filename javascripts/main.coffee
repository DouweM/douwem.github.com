$(document).ready ->
  setLastSectionMarginBottom()
  $(window).on "resize", setLastSectionMarginBottom
  
  $("header nav a").on "click", handleNavLinkClick
  
  $(window).on "keydown", handleKeyDown

verticallyCenterTextEl = (el) ->    
  elCenter = el.offset().top + (el.outerHeight() / 2)
  windowCenter = $(window).height() / 2
  
  $(window).scrollTop Math.ceil(elCenter - windowCenter)

setLastSectionMarginBottom = ->
  lastSection = $("#traits section").last()
  lastCenterable = $("h2, ul li", lastSection).last()
  lastSectionMarginBottom = ($(window).height() / 2) - (lastCenterable.outerHeight() / 2)
  lastSection.css "margin-bottom", Math.ceil(lastSectionMarginBottom)

handleNavLinkClick = (event) ->  
  event.preventDefault()
  
  link    = $(event.target)
  href    = link.attr "href"
  section = $(href)
  firstCenterable = $("h2, ul li", section).first()
  
  verticallyCenterTextEl firstCenterable

currentlyCenteredEl = (centerableEls) ->
  # Reverse centerableEls
  centerableEls = $(centerableEls.get().reverse())
  
  scrollCenter = $(window).scrollTop() + ($(window).height() / 2)
  
  centeredEl = null
  lastElTop = 10000 # Arbitrary large number
  for el in centerableEls
    el = $(el)
    offset = el.offset()
    elTop = offset.top
    if elTop <= scrollCenter <= lastElTop
      centeredEl = el
      break
    lastElTop = elTop
  
  centeredEl || centerableEls.last()
  
handleKeyDown = (event) ->
  return unless event.which in [38, 40] # Up, Down
  event.preventDefault()
  
  if event.altKey # Scroll down one section 
    centerableEls = $("h2:first-child, section > ul:first-child li:first-child", $("section"))
  else # Scroll down one line
    centerableEls = $("h2, ul li", $("section"))

  centeredEl = currentlyCenteredEl centerableEls
  centeredElIndex = centerableEls.index centeredEl
  
  otherIndex = if event.which == 38 then centeredElIndex - 1 else centeredElIndex + 1
  return unless 0 <= otherIndex < centerableEls.length
  
  otherEl = centerableEls.eq otherIndex
  verticallyCenterTextEl otherEl