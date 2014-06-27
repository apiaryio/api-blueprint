# Configuration
config    = require '../config'

# Packages
express      = require 'express'
compression  = require 'compression'
errorHandler = require 'errorhandler'
logger       = require 'morgan'
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
parseBlueprintCodeLocal = (code, cb) ->
  blueprint.getLocalAst code, (err, ast, warnings) ->
    if not err
      log.debug 'Parsing code successful'
      return cb null,
        'ast': ast
        'warnings': warnings if warnings

    # TODO: log.debug is here until we have client-side parser
    log.debug 'Cannot parse blueprint code', err
    return cb 400,
      'message' : 'Cannot parse blueprint code',   'description' : err.message if err.message
      'code'    : err.code if err.code,            'location'    : err.location if err.location


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


# Setup
exports.setup = (app) ->

  app.set 'trust proxy', true # trust headers like X-Forwarded-* for setting req.proto et al

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


  app.options '/blueprint/ast', addCORS, (req, res) ->
    res.send ''


  processIt = (req, res, data) ->
    data.blueprintCode = data.blueprintCode.replace(/\r\n/g,"\n").replace(/\r/g,"\n")
    t = process.hrtime()
    parseBlueprintCodeLocal data.blueprintCode, (errCode, parsedData) ->
      t = process.hrtime(t)
      t = t[0] + ' s, ' + (t[1]/1000000).toFixed(3) + ' ms' # nano (1/1000) => mikro (1/1000000) => ms
      res.set 'X-Parser-Time', t
      if errCode then return res.json errCode, parsedData
      return res.json parsedData


  app.post '/blueprint/ast', addCORS, (req, res) ->
    buffer = new Buffer(0)
    errorException = null
    bodyBufferFull = false
    received = 0

    onData = (chunk) ->
      received += chunk.length
      buffer = Buffer.concat [buffer, chunk] unless bodyBufferFull
      if received > BUFFER_LIMIT
        bodyBufferFull = true

    onEnd = (err) ->
      errorException = null
      data = null
      if err
        res.send 400, 'message': 'An error with your request happened. The server cannot go further.'
      else
        try
          data = qs.parse buffer.toString 'utf-8'
        catch exc
          errorException = exc
        finally
          if errorException
            res.send 400, 'message': 'Cannot parse retrieved data'
          else if not data.blueprintCode
            res.send 400, 'message', 'No blueprint code, nothing to parse'
          else
            processIt(req, res, data)

        cleanup()

    cleanup = ->
      buffer = errorException = received = null
      req.removeListener 'data',  onData
      req.removeListener 'end',   onEnd
      req.removeListener 'error', onEnd
      req.removeListener 'close', onEnd

    req.on 'data', onData
    req.once 'end', onEnd
    req.once 'close', onEnd
    req.once 'error', onEnd

  app.get '/', (req, res) ->
    res.send 200, '<!doctype html><html><head><title>Greetings</title></head><body><h>Hi there!</h1></body>'

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
