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
request.body = '
{
  "name"       : "new_user_1",
  "userid"     : "new_user_1@domain.com",
  "first_name" : "New",
  "last_name"  : "User1",
  "group"      : { "id" : 4 },
  "password"   : "smartvm"
}
'

require 'pry'; binding.pry # JJV

response = http.request(request)
puts JSON.pretty_generate(JSON.parse(response.body.strip))

