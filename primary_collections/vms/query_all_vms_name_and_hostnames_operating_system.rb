#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'openssl'
require 'uri'

uri = URI.parse("https://#{ENV['MIQ']}/api/vms?expand=resources&attributes=name,hostnames,operating_system")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(uri.request_uri)
request.basic_auth("admin", "smartvm")

response = http.request(request)

puts "Reply:\n " + JSON.pretty_generate(JSON.parse(response.body.strip))

