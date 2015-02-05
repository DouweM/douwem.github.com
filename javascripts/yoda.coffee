class window.YodaSpeak
  @yodaize: ->
    YodaSpeak._createVerbsColumn()
    YodaSpeak._mirrorLayout()
    YodaSpeak._yodaizeText()
    
  @_mirrorLayout: ->
    _mirror = (string) ->
      return string.replace "left", "right" if string.match /left/
      return string.replace "right", "left" if string.match /right/
      
    _swapProperty = (el, property) ->
      value = el.css property
      otherProperty = _mirror property
      otherValue = el.css otherProperty
      
      changes = {}
      changes[property] = otherValue
      changes[otherProperty] = value
      el.css changes
    
    _mirrorValue = (el, property) ->
      value = el.css property
      otherValue = _mirror value
      
      el.css property, otherValue
    
    header = $("header")
    _swapProperty header, "left"
    _mirrorValue  header, "text-align"
    
    _swapProperty $("h1", header), "right"
    _swapProperty $("nav", header), "left"
    
    traitsColumn = $(".traits.main")
    _swapProperty traitsColumn, property for property in ["left", "margin-left", "padding-left"]
    _mirrorValue  traitsColumn, "text-align"
  
  @_createVerbsColumn: ->
    traitsColumn = $(".traits").first()
    verbsColumn = traitsColumn.clone()
    verbsColumn.addClass "verbs"
    verbsColumn.css
      "margin-left":  "60%"
      "padding-left": "195px"
      "text-align":   "left"
    $(document.body).prepend verbsColumn
    
    traitsColumn.addClass "main"
  
  @_yodaizeText: ->
    traitsColumn  = $(".traits.main")
    verbsColumn   = $(".traits.verbs")
    
    traitEls = $("h2, li", traitsColumn)
    verbEls = $("h2, li", verbsColumn)
    for traitEl, index in traitEls
      traitEl = $(traitEl)
      verbEl = verbEls.eq(index)
      
      verbEl.empty().append traitEl.find("span.verb")

      traitEl.find("span.name, span.verb").remove()
      lastNode = traitEl.contents().last().get(0)
      lastNode.textContent = lastNode.textContent.replace /\s+$/, "" if lastNode.nodeType == 3
      traitEl.append ","

$(document).ready ->
  yodaized  = false
  code      = [38, 38, 40, 40, 37, 39, 37, 39, 66, 65]
  keysDown  = []
  $(window).on "keydown", (event) ->
    keysDown.push event.keyCode
    if keysDown.length >= code.length && (keysDown[keysDown.length-code.length...keysDown.length]).join("") == code.join("")
      if yodaized
        window.location.reload()
      else
        YodaSpeak.yodaize()
        yodaized = true