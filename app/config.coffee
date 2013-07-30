process.env.DOMAIN           ?= 'apiblueprint.dev'
process.env.PORT             ?= 8000
process.env.BUFFER_LIMIT     ?= 20000 # ms before a proxy request times out; note that Heroku kills anything over 30s anyway
process.env.VERBOSE          ?= ''

process.env.NODE_ENV         ?= 'development'

# Logging
process.env.LOG_COLORIZE     ?= '0'

process.env.HIPCHAT_API_KEY  ?= ''
process.env.HIPCHAT_ROOM_ID  ?= ''
