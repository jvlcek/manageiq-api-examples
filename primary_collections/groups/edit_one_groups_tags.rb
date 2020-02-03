#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'openssl'
require 'uri'

uri = URI.parse("https://#{ENV['MIQ']}/api/groups/1000000000022")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(uri.request_uri)
request.basic_auth("admin", "smartvm")
request.body = '
{
  "action" : "edit",
  "resource" : {
    "description" : "testgroup",
    "filters"     : {
      "belongsto" : [],
      "managed"   : ["/managed/prov_scope/testgroup"]
    }
  }
}
'
response = http.request(request)
puts JSON.pretty_generate(JSON.parse(response.body.strip))

