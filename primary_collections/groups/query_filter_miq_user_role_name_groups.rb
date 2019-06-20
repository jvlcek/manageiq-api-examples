#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'openssl'
require 'uri'


expand_resources="expand=resources&attributes=description,miq_user_role_name"
uri = URI.parse("https://#{ENV['MIQ']}/api/groups/?#{expand_resources}&filter[]=miq_user_role_name='*user*'")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(uri.request_uri)
request.basic_auth("admin", "smartvm")

response = http.request(request)

puts "Reply:\n " + JSON.pretty_generate(JSON.parse(response.body.strip))
