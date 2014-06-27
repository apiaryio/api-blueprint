# Configuration
config    = require '../config'

# Packages
bodyParser   = require 'body-parser'
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

  app.set 'trust proxy', true # trust headers like X-Forwarded-* for setting req.proto et al

  app.use compression(threshold: 512)

  # setup error handlers based on production vs. development use
  # modify `NODE_ENV` environment variable to force the right scope
  if process.env.NODE_ENV is 'development'
    app.use errorHandler
      dumpExceptions: true
      showStack: true
      fileUrls: 'txmt'

  else
    app.use logger('tiny')
    app.use errorHandler()


  app.options '/blueprint/ast', addCORS, (req, res) ->
    res.send ''


  app.post '/blueprint/ast', addCORS, bodyParser.urlencoded(extended: false, limit: '1mb'), (req, res) ->
    if not req.body.blueprintCode
      res.send 400, 'message', 'No blueprint code, nothing to parse'
    else
      blueprintCode = req.body.blueprintCode.replace(/\r\n/g,"\n").replace(/\r/g,"\n")
      t = process.hrtime()
      parseBlueprintCodeLocal blueprintCode, (errCode, parsedData) ->
        t = process.hrtime(t)
        t = t[0] + ' s, ' + (t[1]/1000000).toFixed(3) + ' ms' # nano (1/1000) => mikro (1/1000000) => ms
        res.set 'X-Parser-Time', t
        if errCode then return res.json errCode, parsedData
        return res.json parsedData

  app.all '/', (req, res) ->
    res.send 200, '<!doctype html><html><head><title>Greetings</title></head><body><h>Hi there!</h1></body>'
