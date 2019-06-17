#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'openssl'
require 'uri'

uri = URI.parse("https://#{ENV['MIQ']}/api/groups/24")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(uri.request_uri)
request.basic_auth("admin", "smartvm")
request.body = '
{
  "action" : "edit",
  "resource" : {
    "description" : "updated_sample_group",
    "filters"     : {
      "belongsto" : [ "/managed/area/1", "/managed/area/2", "/managed/area/3" ],
      "managed"   : [[ "/managed/infra/1", "/managed/infra/2" ], ["/managed/other/3"]]
    }
  }
}
'
response = http.request(request)
puts JSON.pretty_generate(JSON.parse(response.body.strip))

