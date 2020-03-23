#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'openssl'
require 'uri'

uri = URI.parse("https://#{ENV['MIQ']}/api/users/2")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(uri.request_uri)

request.basic_auth("admin", "smartvm")

request.body = '
{
  "action" : "edit",
  "resource" : {
    "miq_groups" : [
      { "description" : "EvmGroup-auditor" },
      { "description" : "EvmGroup-super_administrator" },
      { "description" : "EvmGroup-operator" },
      { "description" : "EvmGroup-user" }
    ]
  }
}
'

response = http.request(request)
puts JSON.pretty_generate(JSON.parse(response.body.strip))

