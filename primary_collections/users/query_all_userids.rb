#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'openssl'
require 'uri'

uri = URI.parse("https://#{ENV['MIQ']}/api/users")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(uri.request_uri)
# request.basic_auth("admin", "smartvm")
request.basic_auth("admin", "smartvm")

response = http.request(request)
raise("Api::AuthenticationError") if response.body.include?("Api::AuthenticationError")

JSON.parse(response.body.strip)["resources"].each do |resource|
  uri = URI.parse(resource["href"].to_s)

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(uri.request_uri)
  request.basic_auth("admin", "smartvm")

  response = http.request(request)

  puts uri.path.ljust(20) +
       JSON.parse(response.body.strip)["userid"].ljust(45)  +
       "current_group_id: " +
       JSON.parse(response.body.strip)["current_group_id"]
end



