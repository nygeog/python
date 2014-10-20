df = df[(df.state == 'NY') | (df.state == 'NJ') | (df.state == 'PA')]

# 1 == 1 # true
# 1 != 1 # false
# 1 <> 1 # false
# [] is [] # false (distinct objects)
# a = b = []; a is b # true (same object)