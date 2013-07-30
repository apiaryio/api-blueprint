# Configuration
config  = require './app/config'

# System libraries
express = require 'express'
http    = require 'http'

# Logging
logging         = require('./app/logging')
log             = logging.get 'index'
logExpressError = logging.get 'express/error'

# Export
module.exports = new (require 'events').EventEmitter()

# Create the VHost multiplexer server instance.
multiplexer = express()

# Instance
module.exports.instance = http.createServer multiplexer

# Express Server
apiServer = express()

apiServer  .disable 'x-powered-by'
multiplexer.disable 'x-powered-by'

apiModule = require './app/controllers/api'
apiModule.setup(apiServer)

# Set up error handlers last; yeah, really, they need to be AFTER the controllers :(
apiServer.use logExpressError

# catch EXCEPTIONS...
process.on 'uncaughtException', (err) ->
  console.trace 'EXCEPTION uncaught: ', err
  log = require('./app/logging').get 'index'
  log.error 'Uncaught exception: ', err


multiplexer.use express.vhost '*', apiServer

port = process.env.PORT * 1

module.exports.instance.listen port
log.info "Started server on port #{port}"
log.debug 'Application started'

module.exports.emit 'start'
