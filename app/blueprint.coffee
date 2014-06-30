# Packages
protagonist = require 'protagonist'

# Logging
log         = require('./logging').get 'app/blueprint'

# Constants
STRICT_OPTIONS =
  requireBlueprintName: false

# Local functions
getLocalAst = (code, cb) ->
  protagonist.parse code, STRICT_OPTIONS, (err, result) ->
    if err then return cb err
    cb null, result

# Export
module.exports = {
  getLocalAst
}
