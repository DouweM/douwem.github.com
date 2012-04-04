class PersonalSite
  constructor: ->
    @setLastSectionMarginBottom()
    $(window).on "resize",            @setLastSectionMarginBottom
    $(window).on "orientationchange", @setLastSectionMarginBottom
  
    $(window).on "keydown",           @handleKeyDown
  
    $("header nav a").on "click",     @handleNavLinkClick
  
    $("h2, ul li", $("section")).on "click", (event) => @focusOnEl event.target
  
  setLastSectionMarginBottom: =>
    lastSection = $("#traits section").last()
    lastFocusable = $("h2, ul li", lastSection).last()
    lastSectionMarginBottom = @_realWindowHeight() - (@_focusCenterFromWindowTop() + (lastFocusable.outerHeight() / 2))

    lastSection.css "margin-bottom", Math.ceil(lastSectionMarginBottom)

  focusOnEl: (focusableEl) ->  
    focusableEl = $(focusableEl)
    focusableCenter = focusableEl.offset().top + (focusableEl.outerHeight() / 2)
  
    $(window).scrollTop Math.ceil(focusableCenter - @_focusCenterFromWindowTop())

  currentlyFocusedEl: (focusableEls = $("h2, ul li", $("section"))) ->
    # Reverse focusableEls
    focusableEls = $(focusableEls.get().reverse())
  
    scrolledFocusCenter = $(window).scrollTop() + @_focusCenterFromWindowTop()
  
    focusedEl = null
    lastElTop = 10000 # Arbitrary large number
    for el in focusableEls
      el = $(el)
      offset = el.offset()
      elTop = offset.top
      if elTop <= scrolledFocusCenter <= lastElTop
        focusedEl = el
        break
      lastElTop = elTop
  
    focusedEl || focusableEls.last()

  # Event handlers
  handleNavLinkClick: (event) =>  
    event.preventDefault()
  
    link    = $(event.target)
    href    = link.attr "href"
    section = $(href)
    firstFocusable = $("h2, ul li", section).first()
  
    @focusOnEl firstFocusable
  
  handleKeyDown: (event) =>
    switch event.which
      when 13 # Enter
        event.preventDefault()
      
        focusedEl = @currentlyFocusedEl()
        link = $("a", focusedEl)
      
        if link.length
          url = link.attr "href"
          if link.attr("target") == "_blank"
            window.open url
          else
            window.location.href = url
      
      when 38, 40 # Up, Down
        return if event.metaKey # Don't handle if Windows or Command key was pressed
      
        event.preventDefault()
  
        if event.altKey # Scroll up/down one section 
          focusableEls = $("h2, ul:first-child li:first-child", $("section"))
        else # Scroll up/down one line
          focusableEls = $("h2, ul li", $("section"))

        focusedEl = @currentlyFocusedEl focusableEls
        focusedElIndex = focusableEls.index focusedEl
  
        otherIndex = if event.which == 38 then focusedElIndex - 1 else focusedElIndex + 1
        return unless 0 <= otherIndex < focusableEls.length
  
        otherEl = focusableEls.eq otherIndex
        @focusOnEl otherEl
  
  # Private
  _realWindowHeight: ->  
    # $(window).height() != window.innerHeight on iPhone
    # See http://bugs.jquery.com/ticket/6724
    if navigator.userAgent.match /(iPhone|iPod)/
      window.innerHeight
    else
      $(window).height()
    
  _focusCenterFromWindowTop: ->  
    if navigator.userAgent.match /(iPhone|iPod)/
      ($("header").outerHeight(true) / 2)
    else
      ($(window).height() / 2)    

$(document).ready ->
  window.personalSite = new PersonalSite