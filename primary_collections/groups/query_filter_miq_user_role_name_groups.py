#!/usr/bin/env python

import requests
import json
import os

expand_resources="expand=resources&attributes=description,miq_user_role_name"
url = "https://" + str(os.environ["MIQ"]) + "/api/groups/?" + str(expand_resources) + "&filter[]=miq_user_role_name='*user*'"
response = requests.get(url, auth=('admin', 'smartvm'), verify=False)
print("Result:\n" + json.dumps(json.loads(response.text), indent=4, sort_keys=True))
