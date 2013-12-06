restify = require 'restify'
btc = require 'btc'

serve = ->
  server = restify.createServer(
    name: "btc-api"
    version: "0.1.0"
  )

		server.use restify.acceptParser(server.acceptable)
		server.use restify.queryParser()
		server.use restify.bodyParser()

		server.get('/price/:source', (req, res, next) ->
			if req.params.source is 'all'
				btc.price (err, prices) ->
					res.send prices
			else
				btc.price(req.params.source, (err, prices) ->
					res.send prices
				)
			return next()
		)

		server.listen 3000, ->
			console.log '%s listening at %s', server.name, server.url

exports.serve = serve
