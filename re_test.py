import re

x = '<time>2015-03-20T09:20:28Z</time>'
m = re.findall('<time>(.*)</time>', x)

print m