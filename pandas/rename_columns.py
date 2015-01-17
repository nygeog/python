df = df.rename(columns=lambda x: x.replace('$', ''))
#or
df = pd.DataFrame({'$a':[1,2], '$b': [10,20]})
df.columns = ['a', 'b'] #just delcare col names here

#from http://stackoverflow.com/questions/11346283/renaming-columns-in-pandas
