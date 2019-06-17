#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'openssl'
require 'uri'

uri = URI.parse("https://#{ENV['MIQ']}/api/vms/124")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(uri.request_uri)
request.basic_auth("admin", "smartvm")

# Set one of the valid actions
# A scan will be done by this example since that is the last action set

# Starting a VM
request_hash = { "action" => "start" }

# Stopping a VM
request_hash = { "action" => "stop" }

# Suspending a VM
request_hash = { "action" => "suspend" }

# Refreshing a VM
request_hash = { "action" => "refresh" }

# Resetting a VM
request_hash = { "action" => "reset" }

# Rebooting guest in VM
request_hash = { "action" => "reboot_guest" }

# Shuts down guest in VM
request_hash = { "action" => "shutdown_guest" }

# Scanning a VM
request_hash = { "action" => "scan" }


request.body = JSON.generate(request_hash)
response = http.request(request)
puts JSON.pretty_generate(JSON.parse(response.body.strip))


