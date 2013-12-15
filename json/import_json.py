import json
a = json.loads('{"X":"value1","Y":"value2","Z":[{"A":"value3","B":"value4"}]}')

the_thing = a["Z"][0]["A"]

print the_thing