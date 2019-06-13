#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'openssl'
require 'uri'

uri = URI.parse("https://#{ENV['MIQ']}/api/actions/41")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(uri.request_uri)
request.basic_auth("admin", "smartvm")
request.body = '
{
  "action" : "edit",
  "resource" : {
      "description" : "Sample Action 1 edit"
    }
}
'
response = http.request(request)
puts JSON.pretty_generate(JSON.parse(response.body.strip))

