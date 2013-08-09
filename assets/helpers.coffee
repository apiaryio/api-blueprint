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

codeCache = {}

getAST = (code, thenBack) ->
  args = codeCache.get code, false
  if args isnt false
    args.push code
    thenBack.apply this, args
    return

  promise.post(window.astParserURI + '?_t=' + ( 1 * ( new Date() ) ), JSON.stringify(blueprintCode: code), {
    "Accept": "application/json"
    'Content-type': 'application/json; charset=utf-8'
  }).then (err, text, xhr) ->
    args = [err, text, code]

    if not codeCache.get code, false
      codeCache.set code, args

    thenBack.apply this, args
  return

editorTimer = null
baseEditorChange = ->
  resizeEditor editors['editor_ace']

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

handleErrors = (data, sess, doc, text) ->
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
    alert("There was an error with your blueprint code.\n\n#{text}")
  return

handleAst = (data, sess, doc) ->
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

handleData = (sess, doc, data, code) ->
  sess.clearAnnotations()
  while oneMarker = allMarkers.shift()
    sess.removeMarker oneMarker
  allMarkers = []
  if data
    renderAST(JSON.stringify((if data.ast then data.ast else data), null, '\t'), -1)
  return data

sendCode = ->
  timeoutInProgress = false
  getAST sendCodeString, (err, text, code) ->
    if timeoutInProgress
      timeoutInProgress = false
      return false

    try
      data = JSON.parse(text)
    catch e
      data = false

    sess = editors['editor_ace'].getSession()
    doc = sess.getDocument()
    data = handleData sess, doc, data, code

    if err and text
      handleErrors(data, sess, doc, text)
    else if err and not text
      alert 'Error sending blueprint code to server for elementary parser check.'
      return
    else if not err and text
      handleAst(data, sess, doc)
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
editorAce = null
resizeEditor = ->
renderAST = ->


initEditors = ->
  dom         = ace.require('ace/lib/dom')
  highlighter = ace.require("ace/ext/static_highlight")
  AceRange    = ace.require('ace/range').Range
  theme       = ace.require('ace/theme/twilight')
  modeJSON    = ace.require('ace/mode/json')
  modeJSON    = new modeJSON.Mode()
  editorAce   = document.getElementById('editor_ace')

  MdMode      = ace.require("ace/mode/markdown").Mode

  MdMode::getNextLineIndent = (state, line, tab) ->
    if state is "listblock"
      match = listBlockRegExp.exec(line)
      if not match then return ''
      marker = match[2]
      if not marker
        marker = (parseInt(match[3], 10) + 1) + "."
      return match[1] # + marker + match[4] # origin from mode-markdown, commented to ignore all the +, -, *, [\d] etc.
    else
      return @.$getIndent line

  MdMode = new MdMode()


  oldPass = -1
  newPass = 0
  passes = 0

  resizeAST = (size = '0px', clsnm) ->
    dom.importCssString(".ace_editor.ace_gutter_size_#{size or '0px'} .ace_gutter-cell { width: #{size or '0px'}; }", 'ace_gutter_size_' + (size or '0px'))
    clsnm = editors['output_ast'].className.replace(/ace_gutter_size_([\S]{2,})/g, '')
    editors['output_ast'].className = "#{clsnm.trim()} ace_gutter_size_#{size or '0px'}"
    return

  resizeEditor = (editor) ->
    sess = editor.getSession()
    newHeight = sess.getScreenLength() * parseInt(editor.renderer.lineHeight, 10) + (if editor.renderer.$horizScroll then editor.renderer.scrollBar.getWidth() else 0)
    editorAce.style.height = newHeight + 'px'
    editors['editor_ace'].resize()
    checker = ->
      passes++
      newPass = editorAce.querySelector('.ace_gutter-layer').style.width
      if (newPass is oldPass and newPass isnt '') or passes >= 20
        oldPass = -1
        passes = 0
        resizeAST newPass
      else
        oldPass = newPass
        setTimeout checker, 7
      return

    setTimeout checker, 7

  ['editor_ace', 'output_ast'].forEach (editorName) ->
    if editorName is 'editor_ace'
      editor = ace.edit(editorName)
      editor.getSession().setMode(MdMode)
      editor.setHighlightActiveLine(false)
      editor.setReadOnly(true)
      editor.session.setFoldStyle('markbeginend')
      editor.getSession().setUseSoftTabs(true)
      editor.setTheme("ace/theme/twilight")
      editor.setShowPrintMargin(false)
      editor.setShowFoldWidgets(true)
    else
      editor = document.getElementById('output_ast')

    editors[editorName] = editor

  loadExample = (listItem, sess, editor) ->
    editor = editors['editor_ace']
    sess   = editor.getSession()

    editor.setValue(listItem.querySelector('code.markdown').firstChild.data, -1)
    sess.getUndoManager().reset()

    resizeEditor editor

    renderAST listItem.querySelector('code.ast').firstChild.data
    return

  renderAST = (text) ->
    editors['output_ast'].setAttribute('data-text', text)
    highlighter.render text, modeJSON, theme, 1, false, (highlighted) ->
      editors['output_ast'].innerHTML = highlighted.html
      return

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
      old.querySelector('code.ast').firstChild.data = editors['output_ast'].getAttribute('data-text')
      old.querySelector('code.markdown').firstChild.data = editors['editor_ace'].getValue()
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
      linkItem.attachEvent('onclick', clickListItem)
  return

initLive = ->
  codeCache = new SafeMap()
  editor = editors['editor_ace']
  editor.setHighlightActiveLine(true)
  editor.setReadOnly(false)
  editor.getSession().on 'paste',  baseEditorChange
  editor.getSession().on 'change', baseEditorChange
  return

loadedAceAndThings = ->
  loadedAceAndThings = ->
    return
  initEditors()
  initLive()
  return

injectScript = (code) ->
  head = document.head || document.getElementsByTagName('head')[0]
  if code.indexOf("use strict") is 1
    script = document.createElement("script");
    script.text = code;
    head.appendChild( script ).parentNode.removeChild( script )
  else
    eval( code )

initLocalStore = (callback) ->
  if not store.enabled
    return callback false
  scriptsJSON = store.get('apiblueprint-scripts')
  if scriptsJSON?.arr and parseInt(scriptsJSON['time_of_creation'], 10) is parseInt(window.time_of_creation, 10)
    inserted = 0
    scriptText = ["\n;\n"]
    for scriptKey in [0..scriptsJSON.arr-1]
      if scriptToInsert = store.get "apiblueprint-scripts-item-#{scriptKey}"
        scriptText.push scriptToInsert
        inserted++
    if scriptsJSON.arr is inserted
      injectScript scriptText.join('\n;\n')
      return callback true
  return callback false

saveScriptsToStore = (scriptsPaths) ->
  scripts = []
  arr = 0

  allFinished = ->
    window.store.set 'apiblueprint-scripts', {
      'time_of_creation': parseInt(window.time_of_creation, 10)
      'arr': arr
    }
    for i in [0..20]
      window.store.remove("apiblueprint-scripts-item-#{i}")
    for i in [0..arr-1]
      window.store.set "apiblueprint-scripts-item-#{i}", scripts[i]
    return

  for script, scriptKey in scriptsPaths
    do (script, scriptKey) ->
      promise.get(script).then (err, text, xhr) ->
        scripts[scriptKey] = text
        arr++
        if scriptsPaths.length is arr
          allFinished()
        return
  return
