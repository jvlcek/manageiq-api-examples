#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'openssl'
require 'uri'

uri = URI.parse("https://#{ENV['MIQ']}/api/users")

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
      "href"  => "https://#{ENV['MIQ']}/api/users/23",
      "group" => { "href" => "http://#{ENV['MIQ']}/api/groups/2" }
    },
    {
      "href"  => "https://#{ENV['MIQ']}/api/users/24",
      "group" => { "href" => "http://#{ENV['MIQ']}/api/groups/2" }
    },
    {
      "href"  => "https://#{ENV['MIQ']}/api/users/25",
      "group" => { "href" => "http://#{ENV['MIQ']}/api/groups/2" }
    }
  ]
}

request.body = JSON.generate(request_hash)
response = http.request(request)
puts JSON.pretty_generate(JSON.parse(response.body.strip))
