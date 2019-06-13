#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'openssl'
require 'uri'

uri = URI.parse("https://#{ENV['MIQ']}/api/actions")

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
      "name" : "sample_action_1",
      "description" : "Sample Action 1",
      "action_type" : "custom_automation",
      "options" : {
        "ae_message" : "message",
        "ae_request" : "request",
        "ae_hash" : { "sample_key" : "sample_value" }
      }
    },
    {
      "name" : "sample_action_2",
      "description" : "Sample Action 2",
      "action_type" : "custom_automation",
      "options" : {
        "ae_message" : "message",
        "ae_request" : "request",
        "ae_hash" : { "sample_key" : "sample_value" }
      }
    },
    {
      "name" : "sample_action_3",
      "description" : "Sample Action 3",
      "action_type" : "custom_automation",
      "options" : {
        "ae_message" : "message",
        "ae_request" : "request",
        "ae_hash" : { "sample_key" : "sample_value" }
      }
    }
  ]
}
'
response = http.request(request)
puts JSON.pretty_generate(JSON.parse(response.body.strip))
