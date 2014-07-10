print 'move uid to front of columns'
cols = df.columns.tolist()
cols = cols[-1:] + cols[:-1]
df = df[cols]