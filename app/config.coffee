process.env.DOMAIN           ?= 'api.apiblueprint.dev'
process.env.PORT             ?= 8000
process.env.BUFFER_LIMIT     ?= 200000 # bytes for buffering sent body
process.env.VERBOSE          ?= ''

process.env.NODE_ENV         ?= 'development'

# Logging
process.env.LOG_COLORIZE     ?= '0'

process.env.HIPCHAT_API_KEY  ?= ''
process.env.HIPCHAT_ROOM_ID  ?= ''
