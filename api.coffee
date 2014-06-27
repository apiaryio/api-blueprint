# Configuration
config  = require './app/config'

# System libraries
express = require 'express'
http    = require 'http'
logger  = require 'morgan'

# Logging
logging         = require('./app/logging')
log             = logging.get 'index'
logExpressError = logging.get 'express/error'

# Export
module.exports = new (require 'events').EventEmitter()

# Express Server
apiServer = express()
apiServer.disable   'x-powered-by'

# logger
if process.env.NODE_ENV is 'development'
  apiServer.use logger('dev')

# api controller
apiModule = require './app/controllers/api'
apiModule.setup(apiServer)

# Set up error handlers last; yeah, really, they need to be AFTER the controllers :(
apiServer.use logExpressError

# catch EXCEPTIONS...
process.on 'uncaughtException', (err) ->
  console.trace 'EXCEPTION uncaught: ', err
  log.error 'Uncaught exception: ', err


port = process.env.PORT * 1

# Instance
module.exports.instance = apiServer

module.exports.instance.listen port, (err) ->
  if err
    log.error 'Unable to start api.apiblueprint.org server', err

  log.info "Started server on port #{port}"
  log.debug 'Application started'

  module.exports.emit 'start'
