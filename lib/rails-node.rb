require 'openssl'
require 'base64'

require "rails-node/engine"

module RailsNode
	module CookieSignature
		
		# Sign the given `val` with `secret`
		# @param {String} val
		# @param {String} secret
		# @return {String}
		# @api private
		def self.sign(val, secret)
			raise TypeError, 'cookie required' unless val.is_a? String
			raise TypeError, 'secret required' unless secret.is_a? String

			sign = OpenSSL::HMAC.digest('sha512', secret, val)
			sign = Base64.encode64(sign.to_s).gsub(/(\n|\=+\n\Z)/,'')
			return "#{val}.#{sign}"
		end

		# Unsign and decode the given `val` with `secret`,
		# returning `false` if the signature is invalid.
		# @param {String} val
		# @param {String} secret
		# @return {String|Boolean}
		# @api private
		def self.unsign(val, secret)
			raise TypeError, 'cookie required' unless val.is_a? String
			raise TypeError, 'secret required' unless secret.is_a? String

			str, mac = val.split '.'
			mac = sign(str, secret)

			if sign(mac, secret) == sign(val, secret)
				return str
			else
				return false
			end
		end
	end
end
