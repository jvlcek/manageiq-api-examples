#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'openssl'
require 'uri'

uri = URI.parse("https://#{ENV['MIQ']}/api/vms")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(uri.request_uri)
request.basic_auth("admin", "smartvm")

request_hash = 
{
  "action" => "edit",
  "resources"   => [
    {
      "href"        => "http://#{ENV['MIQ']}/api/vms/325",
      "description" => "Roughrider VM Updated",
    },
    {
      "href"        => "http://#{ENV['MIQ']}/api/vms/331",
      "description" => "Argonauts VM Updated",
    },
    {
      "href"        => "http://#{ENV['MIQ']}/api/vms/332",
      "description" => "Alouettes VM Updated",
    },
  ]
}

request.body = JSON.generate(request_hash)
response = http.request(request)
puts JSON.pretty_generate(JSON.parse(response.body.strip))
