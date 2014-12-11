#Use os.walk to recursively walk a directory and fnmatch.filter to match against a simple expression:

import fnmatch
import os

matches = []
for root, dirnames, filenames in os.walk('src'):
  for filename in fnmatch.filter(filenames, '*.c'):
      matches.append(os.path.join(root, filename))
#For Python versions older than 2.2, use glob.glob against each filename instead of fnmatch.filter.