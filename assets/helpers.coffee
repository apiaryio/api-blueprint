# read cookie
readCookie = (name) ->
  nameEQ = escape(name) + "="
  ca = document.cookie.split(";")
  i = 0
  while i < ca.length
    c = ca[i]
    c = c.substring(1, c.length)  while c.charAt(0) is " "
    return unescape(c.substring(nameEQ.length, c.length).replace(/"/g, ''))  if c.indexOf(nameEQ) is 0
    i++
  return

# set cookie
setCookie = (cookieName, cookieValue, expire = null) ->
  if not expire
    expire = new Date()
    expire.setDate(expire.getDate() + 365 * 30)
  document.cookie = escape(cookieName) + "=" + escape(cookieValue) + ";expires=" + expire.toGMTString() + ";domain=." + location.hostname + ";path=/";

variant = false

abTest = (usableVariants, fallbackVariant) ->
  maxI = usableVariants.length - 1
  minI = -1
  variant = readCookie('ab_testing_variant')

  if (!!variant) or (variant is '0') or (variant is '-1')
    variant = parseInt(variant, 10)
    if variant < 0
      window.ab_variant = fallbackVariant
      return
    if variant > maxI
      variant = false
  else
    variant = false

  if variant is false
    variant = Math.floor(Math.random() * (maxI - minI + 1) + minI)
    setCookie 'ab_testing_variant', variant, new Date(1*new Date() + 3600*1000)

  if variant > -1
    window.ab_variant = usableVariants[variant][0]
    return usableVariants[variant]

abTestWrite = (klass, usableVariants, fallbackVariant) ->
  chosenVariant = abTest usableVariants, fallbackVariant
  if not chosenVariant
    return
  s  = "#{unescape('%3Cspan')} class=\"#{klass}\"#{unescape("%3E")}"
  s += chosenVariant[1]
  s += unescape("%3C/span%3E")
  document.write s

initDots = ->
  $els = [].slice.call(document.querySelectorAll('.anim__item'), 0)
  $els.forEach (dot, ind) ->
    i = parseInt dot.getAttribute('data-dots'), 10
    frg = document.createElement 'span'
    frg.setAttribute 'class', "anim__dots__all anim__len__#{i} anim__delay__#{ind}"
    dot.style.width = frg.style.width = i * 11 + 'px'
    s = ''
    s += '<span class="anim--dot"></span>'
    frg.innerHTML = s
    dot.insertBefore(frg, dot.lastChild)

getAST = (code, thenBack, errorBack) ->
  promise.post(window.astParserURI + '?_t=' + ( 1 * ( new Date() ) ), JSON.stringify(blueprintCode: code), {
    "Accept": "application/json"
    'Content-type': 'application/json; charset=utf-8'
  }).then thenBack
  return

editorTimer = null
baseEditorChange = ->
  if !!editorTimer then clearTimeout editorTimer
  editorTimer = setTimeout validateEditor, 200

editors = {}
validateEditor = ->
  code = editors['editor_ace'].getSession().getValue().replace(/\r\n/g,"\n").replace(/\r/g,"\n")
  newCode = code + ''
  editors['editor_ace'].getSession().clearAnnotations()
  handleNewBlueprintFormat code

sendCodeString = ''
sending = false
handleNewBlueprintFormat = (code, codeInside) ->
  if sending
    clearTimeout sending
    sending = false

  sendCodeString = ''.concat code
  timeoutInProgress = true
  sending = setTimeout( sendCode, 500 )

allMarkers = []

timeoutInProgress = false

AceRange = null

sendCode = ->
  timeoutInProgress = false
  getAST sendCodeString, (err, text, xhr) ->
    sess = editors['editor_ace'].getSession()
    sess.clearAnnotations()
    doc = sess.getDocument()

    if timeoutInProgress
      timeoutInProgress = false
      return false

    while oneMarker = allMarkers.shift()
      sess.removeMarker oneMarker

    allMarkers = []

    try
      data = JSON.parse(xhr.responseText)
    catch e
      data = false
    if data
      editors['output_ast'].setValue(JSON.stringify((if data.ast then data.ast else data), null, '\t'), -1)
      editors['output_ast'].getSession().getUndoManager().reset()

    if err and text
      editorErrors = []
      if data?.location?
        if data?.location?[0]?.index?
          positioning = doc.indexToPosition(parseInt(data.location[0].index, 10), 0)
          editorErrors.push({
            type: 'error'
            row: positioning.row
            column: positioning.column
            text: data.description.substr(0, 1).toUpperCase() + data.description.slice(1)
          })
          sess.setAnnotations editorErrors
        else
          errorRowNumber.text("")
          codeValidity.not('.notValidContent').attr("class", "notValidContent")

        invalidContent.text "\"#{data.description}\""
      else
        alert("There was an error with your blueprint code.\n\n#{xhr.responseText}")
      return
    else if err and not xhr.responseText
      alert 'Error sending blueprint code to server for elementary parser check.'
      return
    else if not err and xhr.responseText
      if not (data?.warnings?.length > 0)
        codeValidity.not('.valid').attr("class", "valid")
        sess.clearAnnotations()
        return

      warnings = []
      positioning = false

      for warn, warnKey in data.warnings or []
        if not warn.location?[0]?.index? then continue
        rangePos = new Array()
        positioning = doc.indexToPosition(parseInt(warn.location[0].index, 10), 0)
        warnings.push {
          type: 'warning' # add basic warning icon
          row: positioning.row, column: positioning.column
          text: warn.message.substr(0, 1).toUpperCase() + warn.message.slice(1)
        }
        rangePos.push positioning.row # add this warning position into lines array, just for sure
        warnColumnEnd = warn.location[0].length

        if warn.location.length > 0 # more lines
          for loc, locKey in warn.location or []
            positioning = doc.indexToPosition(parseInt(loc.index, 10), 0)
            rangePos.push positioning.row

        if rangePos.length > 0
          rangePos.sort()
          allMarkers.push sess.addMarker(new AceRange(rangePos[0], 0, rangePos.pop(), warnColumnEnd), 'warningLine', "fullLine")

      if positioning isnt false
        invalidContent.text "\"There #{if warnings.length > 1 then "are #{warnings.length} warnings" else "is one warning at line #{positioning.row + 1}"}\""
      else
        invalidContent.text ": #{data.warnings[0].message}"

      codeValidity.not('.notValidContent').attr("class", "notValidContent")

      sess.setAnnotations warnings

    return

class basicJqueryObject
  not:  () -> @
  attr: (name, val) ->
    @
  text: (s) -> 
    @

codeValidity   = new basicJqueryObject()
errorRowNumber = new basicJqueryObject()
invalidContent = new basicJqueryObject()

initEditors = ->
  AceRange = ace.require('ace/range').Range
  ['editor_ace', 'output_ast'].forEach (editorName) ->
    editor = ace.edit(editorName)
    if editorName is 'editor_ace'
      editor.getSession().setMode('ace/mode/markdown')
    else
      editor.getSession().setMode('ace/mode/json')
      editor.renderer.hideCursor()

    editor.setHighlightActiveLine(false)
    editor.setReadOnly(true)
    editor.session.setFoldStyle('markbeginend')
    editor.getSession().setUseSoftTabs(true)
    editor.setTheme("ace/theme/twilight")
    editor.setShowPrintMargin(false)
    editor.setShowFoldWidgets(true);
    editors[editorName] = editor

  loadExample = (listItem) ->
    editors['editor_ace'].setValue(listItem.querySelector('code.markdown').firstChild.data, -1)
    editors['editor_ace'].getSession().getUndoManager().reset()
    editors['output_ast'].setValue(listItem.querySelector('code.ast').firstChild.data, -1)
    editors['output_ast'].getSession().getUndoManager().reset()

  hashed = false
  if window.location.hash
    hashed = document.querySelector('a[href*="' + window.location.href.split('#').pop() + '"]')

  if !hashed
    loadExample(document.querySelector('li.examples__tab.active'))
  else
    old = document.querySelector('li.examples__tab.active')
    old.className = old.className.replace('active', '').trim()
    hashed.parentNode.className += ' active'
    loadExample(hashed.parentNode)

  clickListItem = () ->
    if this.parentNode.className.indexOf('active') < 0
      old = document.querySelector('li.examples__tab.active')
      old.className = old.className.replace('active', '').trim()
      this.parentNode.className += ' active'
      loadExample(this.parentNode)
    return

  document.querySelector('.page--examples').className += ' loaded'

  $els = [].slice.call(document.querySelectorAll('.examples__tab a'), 0)

  $els.forEach (linkItem) ->
    if linkItem.addEventListener
      linkItem.addEventListener('click', clickListItem, false)
    else if linkItem.attachEvent
      linkItem.attachEvent('onclick', clickListItem);

initLive = ->
  editor = editors['editor_ace']
  editor.setHighlightActiveLine(true)
  editor.setReadOnly(false)
  editor.getSession().on 'paste',  baseEditorChange
  editor.getSession().on 'change', baseEditorChange
  return
