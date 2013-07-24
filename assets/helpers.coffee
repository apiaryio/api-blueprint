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

initEditors = ->
  editors = {}
  ['editor_ace', 'output_ast'].forEach (editorName) ->
    editor = ace.edit(editorName)
    if editorName is 'editor_ace'
      editor.getSession().setMode('ace/mode/markdown')
      editor.session.setFoldStyle('markbeginend')
      editor.setShowFoldWidgets(true)
      editor.setReadOnly(true)
    else
      editor.session.setFoldStyle('markbeginend')
      editor.getSession().setMode('ace/mode/json')
      editor.setReadOnly(true)
      editor.renderer.hideCursor()

    editor.getSession().setUseSoftTabs(true)
    editor.setHighlightActiveLine(false)
    editor.setTheme("ace/theme/twilight")
    editor.setShowPrintMargin(false)
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
