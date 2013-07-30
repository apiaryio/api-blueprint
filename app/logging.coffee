# Configuration
config  = require './config'

# System libraries
HipChat = require 'node-hipchat'
winston = require 'winston'

loggers = {}

hipchat = if process.env.HIPCHAT_API_KEY then new HipChat process.env.HIPCHAT_API_KEY else undefined

oldLog = winston.transports.Console::log

winston.transports.Console::log = (level, msg, meta, callback) ->
  if meta and (meta instanceof Error) and (stack = meta.stack)
    meta = stack
  oldLog.call @, level, msg, meta, callback

# # Apiary Logging Library
#
# ### Log Levels
# (our internal on the left, how they map to sentry on the right)
# - silly:   'debug'
# - verbose: 'debug'
# - info:    'info'
# - warn:    'warning'
# - debug:   'debug'
# - error:   'error'
custom_levels =
  levels:
    silly:    0
    verbose:  1
    debug:    2
    info:     3
    warn:     4
    error:    5
    critical: 6
  colors:
    silly:    'grey'
    verbose:  'cyan'
    debug:    'green'
    info:     'yellow'
    warn:     'magenta'
    error:    'red'
    critical: 'blue'

winston.addColors custom_levels.colors

default_transports = exports.default = (logger, name, opts = {}) ->
  logger.setLevels custom_levels.levels
  opts.level       ?= log_level
  opts.colorize    ?= parseInt(process.env.LOG_COLORIZE, 10) is 1
  opts.prettyPrint ?= true
  opts.timestamp   ?= true
  logger.add winston.transports.Console, opts

  logger.hipchat = exports.hipchat
  return logger

handleExpressError = (err, req, res) ->
  if err instanceof URIError
    res.send 501, "Requested URI is not valid. Please correct it and try it again"
  else
    res.send 500, "Page you are looking for does not exist"


get = exports.get = (name, opts) ->
  switch name
    when 'express/error'
      unless loggers[name]
        express_logger = default_transports new winston.Logger(), name, opts
        loggers[name] = (err, req, res, next) ->
          express_logger.error "express/error: on #{ if req then req.url else 'unknown url'} - ", err
          handleExpressError err, req, res
    else
      loggers[name] = default_transports new winston.Logger(), name, opts unless loggers[name]
  return loggers[name]

io_log_level = exports.io_log_level = if process.env.VERBOSE then 3 else if process.env.NODE_ENV is 'development' then 2 else 1
log_level = exports.log_level = process.env.LOG_LEVEL or if process.env.VERBOSE then 'verbose' else if process.env.NODE_ENV is 'development' then 'debug' else 'info'

if hipchat and process.env.HIPCHAT_ROOM_ID
  exports.hipchat = (msg, cb) ->
    hipchat.postMessage
      room: process.env.HIPCHAT_ROOM_ID,
      from: 'Api.ApiBlueprint.org'
      message: msg
      color: 'green'
    , (result, err) ->
      cb err, result if cb
else
  exports.hipchat = (msg, cb) ->
    if exports.log_level is 'silly'
      console.log "Message not send to hipchat (no hipchat available)", msg
    cb null if cb
