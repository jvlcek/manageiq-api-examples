# manageiq-api-examples

This repo is for maintaining examples of how to use the ManageIQ REST API.

All examples will be written in Ruby and use the Net::HTTP libary which is
included in the Ruby Standard Library.

The goal is to have a collection of simple, stand alone, examples illustrating
one, or a small set, of the supported ManageIQ REST API functions. The goal
is not to produce DRY, terse or slick ruby code.

The examples require the shell environment variable `MIQ` to contain the IP
Address or hostname of a ManageIQ instance.

All examples will have the following format:

```ruby
#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'openssl'
require 'uri'

uri = URI.parse("https://#{ENV['MIQ']}/api/<collection>/<:id>")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

# One of:
request = Net::HTTP::Delete.new(uri.request_uri)
request = Net::HTTP::Get.new(uri.request_uri)
request = Net::HTTP::Post.new(uri.request_uri)

request.basic_auth("admin", "smartvm")

# Any payload:
request_hash = { <payload> }

request.body = JSON.generate(request_hash)
response = http.request(request)

```
