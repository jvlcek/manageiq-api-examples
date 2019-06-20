#!/usr/bin/env python

import requests
import json
import os

url = 'https://' + str(os.environ["MIQ"]) + '/api/groups/23'

request_body = { 'action':  'edit', 'resource' : { 'description' : 'updated group description from python' } }
headers = {'Content-type': 'application/json'}
response = requests.post(url, data=json.dumps(request_body), headers=headers,  auth=('admin', 'smartvm'), verify=False)
print("Result:\n" + json.dumps(json.loads(response.text), indent=4, sort_keys=True))
