#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'openssl'
require 'uri'

uri = URI.parse("https://#{ENV['MIQ']}/api/groups")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(uri.request_uri)
request.basic_auth("admin", "smartvm")
request_hash =
{
  "action"      => "create",
  "resources"   => [
    {
      "description" => "roughrider_sample_group",
      "role"        => { "id"        => "2" },
      "tenant"      => { "href"      => "http://#{ENV['MIQ']}/api/tenants/1" },
      "filters"     => { "belongsto" => [ "/managed/area/1", "/managed/area/2" ],
                         "managed"   => [[ "/managed/infra/1", "/managed/infra/2" ]]
                       }
    },
    {
      "description" => "argonauts_sample_group",
      "role"        => { "id"        => "2" },
      "tenant"      => { "href"      => "http://#{ENV['MIQ']}/api/tenants/1" },
      "filters"     => { "belongsto" => [ "/managed/area/1", "/managed/area/2" ],
                         "managed"   => [[ "/managed/infra/1", "/managed/infra/2" ]]
                       }
    },
    {
      "description" => "alouettes_sample_group",
      "role"        => { "id"        => "2" },
      "tenant"      => { "href"      => "http://#{ENV['MIQ']}/api/tenants/1" },
      "filters"     => { "belongsto" => [ "/managed/area/1", "/managed/area/2" ],
                         "managed"   => [[ "/managed/infra/1", "/managed/infra/2" ]]
                       }
    },
  ]
}


request.body = JSON.generate(request_hash)
response = http.request(request)
puts JSON.pretty_generate(JSON.parse(response.body.strip))
