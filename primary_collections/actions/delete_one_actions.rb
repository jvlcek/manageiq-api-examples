#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'openssl'
require 'uri'

uri = URI.parse("https://#{ENV['MIQ']}/api/actions/46")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Delete.new(uri.request_uri)
request.basic_auth("admin", "smartvm")
response = http.request(request)
puts "Returned code shoud be 204. Code returned is ->#{response.code}<-"
