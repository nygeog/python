df['location_temp'] = df.uid.map(str)
df['location'] = df.location_temp.str[4:6]
df = df.drop('location_temp', axis=1)