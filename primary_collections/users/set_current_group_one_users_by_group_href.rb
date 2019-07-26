#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'openssl'
require 'uri'

# /api/users/2 is for new_user_2
uri = URI.parse("https://#{ENV['MIQ']}/api/users/2")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(uri.request_uri)

# set_current_group can only be used to set the authenticated user's current group
# So the ID specified in the uri must be for the authenticated user
# set_current_group can only be used to set the group to a group the user already belongs to"
# /api/users/2 is for new_user_2
request.basic_auth("new_user_2", "smartvm")


# api/groups/5 is the uri for the group EvmGroup-administrator, which user new_user_2 does belong to.
request_hash = 
{
  "action" => "set_current_group",
  "resource" => {
    "current_group" => { "href" => "https://#{ENV['MIQ']}/api/groups/5" },
  },
}

request.body = JSON.generate(request_hash)

response = http.request(request)
puts JSON.pretty_generate(JSON.parse(response.body.strip))

