df = df.groupby('idx').apply(lambda x: x.to_json(orient='records'))

#http://stackoverflow.com/questions/35608208/pandas-groupby-and-convert-to-json-list