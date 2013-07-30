# Configuration
config    = require '../config'

# Packages
express   = require 'express'
gzippo    = require 'gzippo'

# Modules
blueprint = require '../blueprint'

# Logging
log       = require('../logging').get 'app/controllers/api'

# Constants
BUFFER_LIMIT   = parseInt(process.env.BUFFER_LIMIT, 10)
ORIGIN_REGEXP  = new RegExp "#{process.env.DOMAIN}".replace(/[\-{}\[\]+?.,\\\^$|#\s]/g, '\\$&') + "$"
APIARY_REGEXP  = new RegExp /apiary\.io$/
DEVELOP_REGEXP = new RegExp /apiblueprint\.dev:([\d]{1,})$/

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

  app.enable 'trust proxy' # trust headers like X-Forwarded-* for setting req.proto et al

  app.configure ->
    app.use gzippo.compress()

  # setup error handlers based on production vs. development use
  # modify `NODE_ENV` environment variable to force the right scope
  app.configure 'development', ->
    app.use express.errorHandler
      dumpExceptions: true
      showStack: true
      fileUrls: 'txmt'

  app.configure 'production', ->
    app.use express.logger()
    app.use express.errorHandler()

  app.options '/blueprint/ast', addCORS, (req, res) ->
    res.send ''

  app.post '/blueprint/ast', addCORS, (req, res) ->
    buffer = new Buffer(0)

    req.on 'data', (chunk) ->
      buffer = Buffer.concat [buffer, chunk] unless bodyBufferFull
      if buffer.length > BUFFER_LIMIT
        bodyBufferFull = true

    # end should be enough as in this case, we'll just discard request on 'close'
    req.on 'end', ->
      try
        data = JSON.parse buffer.toString 'utf-8'
      catch err
        return res.send 400, 'message': 'Cannot JSON-parse retrieved data'

      data.blueprintCode = data.blueprintCode.replace(/\r\n/g,"\n").replace(/\r/g,"\n")
      t = process.hrtime()
      parseBlueprintCodeLocal data.blueprintCode, (errCode, parsedData) ->
        t = process.hrtime(t)
        t = t[0] + ' s, ' + (t[1]/1000000).toFixed(3) + ' ms' # nano (1/1000) => mikro (1/1000000) => ms
        res.set 'X-Parser-Time', t
        if errCode then return res.json errCode, parsedData
        return res.json parsedData

  app.get '/', (req, res) ->
    res.send 200, '<!doctype html><html><head><title>Greetings</title></head><body><h>Hi there!</h1></body>'
