# Configuration
config    = require '../config'

# Packages
express      = require 'express'
compression  = require 'compression'
errorHandler = require 'errorhandler'
logger       = require 'morgan'
YAML         = require 'json2yaml'
qs           = require 'qs'

# Modules
blueprint = require '../blueprint'

# Logging
log       = require('../logging').get 'app/controllers/api'

# Constants
DEVELOPMENT_MODE = process.env.NODE_ENV is 'development'
BUFFER_LIMIT     = parseInt(process.env.BUFFER_LIMIT, 10)
ORIGIN_REGEXP    = new RegExp "#{process.env.DOMAIN}".replace(/[\-{}\[\]+?.,\\\^$|#\s]/g, '\\$&') + "$"
APIARY_REGEXP    = new RegExp /apiary\.io$/
DEVELOP_REGEXP   = new RegExp /apiblueprint\.dev:([\d]{1,})$/


# Local functions
normalizeNewlines = (s) ->
  s.replace(/\r\n/g, "\n").replace(/\r/g, "\n")


formatTime = (hrtime) ->
  # nano (1/1000) => mikro (1/1000000) => ms
  hrtime[0] + ' s, ' + (hrtime[1] / 1000000).toFixed(3) + ' ms'


parseBlueprintCodeLocal = (blueprintCode, cb) ->
  blueprint.getLocalAst blueprintCode, (err, result) ->
    if err
      log.debug 'Cannot parse blueprint code', err
      result.error = err
    else
      log.debug 'Parsing code successful'
      result.error = {code: 0}

    cb result


addCORS = (req, res, next) ->
  res.set 'Access-Control-Allow-Credentials', 'true'
  res.set 'Access-Control-Allow-Methods', 'POST, GET'
  res.set 'Access-Control-Allow-Headers', 'Content-Type, Accept'
  res.set 'Access-Control-Expose-Headers', 'Content-Type, Accept'
  res.set 'Access-Control-Max-Age', 60 * 60 * 24

  origin = req.get('Origin') or ''
  if ORIGIN_REGEXP.test(origin) or APIARY_REGEXP.test(origin) or DEVELOP_REGEXP.test(origin)
    res.set 'Access-Control-Allow-Origin', origin
  else
    res.set 'Access-Control-Allow-Origin', process.env.DOMAIN

  next()


bodyParser = (req, res, next) ->
  req.setEncoding 'utf8'
  req.body = ''
  req.on 'data', (chunk) ->
    req.body += chunk
  req.on 'end', ->
    next()


sendParserResult = (reqHeaders, res, result) ->
  formatName = 'json'
  format = JSON
  if reqHeaders.accept is 'vnd.apiblueprint.parseresult.raw+yaml'
    formatName = 'yaml'
    format = YAML

  res.set 'Content-Type', "vnd.apiblueprint.parseresult.raw+#{formatName}; version=1.0"
  res.send (if result.error.code is 0 then 200 else 400), format.stringify result


# Setup
exports.setup = (app) ->
  app.set 'trust proxy', true  # trust headers like X-Forwarded-* for setting req.proto et al
  app.use compression(threshold: 512)

  # Setup development error handler.
  # Modify `NODE_ENV` environment variable to force the right scope.
  if DEVELOPMENT_MODE
    app.use errorHandler
      dumpExceptions: true
      showStack: true
      fileUrls: 'txmt'
  else
    app.use logger('tiny')


  app.options '/parser', addCORS, (req, res) ->
    res.send ''


  app.post '/parser', addCORS, bodyParser, (req, res) ->
    if not req.body
      res.send 400, format.stringify
        error:
          code: -1  # TODO consult this with proper snowcrash/protagonist error codes
          message: 'No blueprint code, nothing to parse'
        warnings: []
    else
      blueprintCode = normalizeNewlines req.body
      t = process.hrtime()
      parseBlueprintCodeLocal blueprintCode, (result) ->
        result._version = '1.0'
        res.set 'X-Parser-Time', formatTime process.hrtime t
        sendParserResult req.headers, res, result


  app.get '/', (req, res) ->
    res.set 'Content-Type', 'application/hal+json'
    res.set 'Link', '<http://docs.apiblueprintapi.apiary.io>; rel="profile"'
    res.json 200,
      _links:
        self: {href: '/'}
        parse: {href: '/parser'}

  # Setup production error handler returning JSON.
  # Modify `NODE_ENV` environment variable to force the right scope.
  if not DEVELOPMENT_MODE
    app.use (error, req, res, next) ->
      res.json 500,
        message: 'Internal server error.'
        description: error.toString()

  # HTTP 404 error handler. We're not serving any static files,
  # so this is okay.
  app.get '*', (req, res) ->
    res.json 404,
      message: 'Specified resource was not found.'
