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
request_hash =
{
  "action"   => "edit",
  "resource" => { "description"     => "Updated Again VM Description",
                  "custom_1"        => "custom_attribute_1",
                  "parent_resource" => { "href" => "http://#{ENV['MIQ']}/api/vms/11" },
                  "child_resources" => [ { "href" => "http://#{ENV['MIQ']}/api/vms/101" },
                                         { "href" => "http://#{ENV['MIQ']}/api/vms/102" },
                                         { "href" => "http://#{ENV['MIQ']}/api/vms/103" },
                                         { "href" => "http://#{ENV['MIQ']}/api/vms/104" }
                                       ]
  }
}

request.body = JSON.generate(request_hash)
response = http.request(request)
puts JSON.pretty_generate(JSON.parse(response.body.strip))

