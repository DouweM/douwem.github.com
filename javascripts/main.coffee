class PersonalSite
  isSmartphone: window.matchMedia("only screen and (min-device-width: 320px) and (max-device-width: 600px)").matches
  
  constructor: ->
    @setLastSectionMarginBottom()
    $(window).on "resize",            @setLastSectionMarginBottom
    $(window).on "orientationchange", @setLastSectionMarginBottom
  
    $(window).on "keydown",           @handleKeyDown
  
    $("header nav a").on "click",     @handleNavLinkClick
  
    $("section h2").on "click",       (event) => @focusOnEl event.target
  
  setLastSectionMarginBottom: =>
    lastSection = $("#traits section").last()
    lastFocusable = $("h2, ul li", lastSection).last()
    lastFocusableBottom = @_focusCenterFromWindowTop() - @_focusableCenterForElement(lastFocusable) + lastFocusable.outerHeight()
    lastSectionMarginBottom = window.innerHeight - lastFocusableBottom

    lastSection.css "margin-bottom", Math.ceil(lastSectionMarginBottom)

  focusOnEl: (focusableEl) ->  
    focusableEl = $(focusableEl)
    focusableCenter = focusableEl.offset().top + @_focusableCenterForElement(focusableEl)
  
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
      when 32, 38, 40 # Space, Up, Down
        return if event.metaKey # Don't handle if Windows or Command key was pressed
      
        event.preventDefault()
  
        if event.altKey || event.which == 32 # Scroll up/down one section 
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
  _focusCenterFromWindowTop: ->  
    if @isSmartphone
      parseInt($("header").css("padding-top")) + (parseInt($("header h1").css("line-height")) / 2)
    else
      (window.innerHeight / 2)    
  
  _focusableCenterForElement: (focusableEl) ->
    parseInt(focusableEl.css("padding-top")) + (parseInt(focusableEl.css("line-height")) / 2)

$(document).ready ->
  window.personalSite = new PersonalSite
