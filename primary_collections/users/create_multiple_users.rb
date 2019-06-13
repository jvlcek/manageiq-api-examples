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
  "action" : "create",
  "resources" : [
    {
      "name"       : "new_user_2",
      "userid"     : "new_user_2@domain.com",
      "first_name" : "New",
      "last_name"  : "User2",
      "group"      : { "id" : 4 },
      "password"   : "smartvm"
    },
    {
      "name"       : "new_user_3",
      "userid"     : "new_user_3@domain.com",
      "first_name" : "New",
      "last_name"  : "User3",
      "group"      : { "id" : 4 },
      "password"   : "smartvm"
    },
    {
      "name"       : "new_user_4",
      "userid"     : "new_user_4@domain.com",
      "first_name" : "New",
      "last_name"  : "User4",
      "group"      : { "id" : 4 },
      "password"   : "smartvm"
    },
    {
      "name"       : "new_user_5",
      "userid"     : "new_user_5@domain.com",
      "first_name" : "New",
      "last_name"  : "User5",
      "group"      : { "id" : 4 },
      "password"   : "smartvm"
    }
  ]
}
'
response = http.request(request)
puts JSON.pretty_generate(JSON.parse(response.body.strip))
