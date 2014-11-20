from _misc import tm, geogList, radbufListMe, radbufListFn
import pandas as pd
import numpy as np
import os

for a in geogList:
	for b in radbufListFn:
		print a + b + ' esri traffic'
		df = pd.read_csv(tm+'traffic/'+a+b+'_esri_traffic.csv').rename(columns=lambda x: x.lower()) #.drop(['XCoord','YCoord'], axis=1)
		df = df[['siteid','year','adt']]
		df['aadt'] = df['adt']
		df = df.drop('adt',axis=1)
		df.to_csv(tm+'traffic/'+a+b+'_esri_traffic_w.csv', index=False)

		df = df.groupby(['siteid','year']).sum()
		df.to_csv(tm+'traffic/'+a+b+'_esri_traffic_w_g.csv', index=True)

		df = pd.read_csv(tm+'traffic/'+a+b+'_esri_traffic_w_g.csv')
		df = pd.pivot_table(df, values='aadt', index='siteid',columns='year', aggfunc=np.sum)
		#df = df.fillna(0)
		df.to_csv(tm+'traffic/'+a+b+'_esri_traffic_w_g_piv.csv', index=True)

		os.remove(tm+'traffic/'+a+b+'_esri_traffic_w.csv')
		os.remove(tm+'traffic/'+a+b+'_esri_traffic_w_g.csv')

		print a + b + ' nys dot traffic'
		df = pd.read_csv(tm+'traffic/'+a+b+'_nysd_traffic.csv',sep=';').rename(columns=lambda x: x.lower()) #.drop(['XCoord','YCoord'], axis=1)
		df = df[['siteid','aadt','aadt_year']]
		df['year'] = df['aadt_year']
		df = df.drop('aadt_year',axis=1)
		df.to_csv(tm+'traffic/'+a+b+'_nysd_traffic_w.csv', index=False)

		df = df.groupby(['siteid','year']).sum()
		df.to_csv(tm+'traffic/'+a+b+'_nysd_traffic_w_g.csv', index=True)

		df = pd.read_csv(tm+'traffic/'+a+b+'_nysd_traffic_w_g.csv')
		df = pd.pivot_table(df, values='aadt', index='siteid',columns='year', aggfunc=np.sum)
		#df = df.fillna(0)
		df.to_csv(tm+'traffic/'+a+b+'_nysd_traffic_w_g_piv.csv', index=True)

		os.remove(tm+'traffic/'+a+b+'_nysd_traffic_w.csv')
		os.remove(tm+'traffic/'+a+b+'_nysd_traffic_w_g.csv')
		