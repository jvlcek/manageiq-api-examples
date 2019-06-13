#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'openssl'
require 'uri'

uri = URI.parse("https://#{ENV['MIQ']}/api/actions")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(uri.request_uri)
request.basic_auth("admin", "smartvm")

request_hash = 
{
  "action" => "edit",
  "resources" => [
    {
      "href"        => "https://#{ENV['MIQ']}/api/actions/41",
      "description" => "Sample Action 1 multiple edit"
    },
    {
      "href"        => "https://#{ENV['MIQ']}/api/actions/42",
      "description" => "Sample Action 2 multiple edit"
    },
    {
      "href"        => "https://#{ENV['MIQ']}/api/actions/43",
      "description" => "Sample Action 3 multiple edit"
    }
  ]
}

request.body = JSON.generate(request_hash)
response = http.request(request)
puts JSON.pretty_generate(JSON.parse(response.body.strip))
