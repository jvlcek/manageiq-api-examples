#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'openssl'
require 'uri'

uri = URI.parse("https://#{ENV['MIQ']}/api/groups")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(uri.request_uri)
request.basic_auth("admin", "smartvm")

request_hash = 
{
  "action" => "delete",
  "resources" => [
    {
      "href"        => "https://#{ENV['MIQ']}/api/groups/25",
    },
    {
      "href"        => "https://#{ENV['MIQ']}/api/groups/26",
    },
    {
      "href"        => "https://#{ENV['MIQ']}/api/groups/27",
    },
    {
      "href"        => "https://#{ENV['MIQ']}/api/groups/28",
    }
  ]
}

request.body = JSON.generate(request_hash)
response = http.request(request)
puts JSON.pretty_generate(JSON.parse(response.body.strip))
