#!/usr/bin/env python

import requests
import json
import os

url = 'https://' + str(os.environ["MIQ"]) + '/api/groups'
response = requests.get(url, auth=('admin', 'smartvm'), verify=False)
print("Result:\n" + json.dumps(json.loads(response.text), indent=4, sort_keys=True))
