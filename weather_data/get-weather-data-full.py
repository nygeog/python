import urllib2
from BeautifulSoup import BeautifulSoup
import pandas as pd
#### THIS SCRIPT IS TOTALLY MODIFIED (with some modifications) FROM NATHAN YAU's book VISUALIZE THIS. http://book.flowingdata.com/downloads.html
 
#Create/open a file called wunder.txt (which will be a comma-delimited file)
 
#Iterate through year, month, and day
for y in range(2014, 2015):
  table  = '/Users/danielmsheehan/GitHub/python/weather_data/nyc_weather_data_'+str(y)+'.txt'
  outcsv = '/Users/danielmsheehan/GitHub/python/weather_data/nyc_weather_data_'+str(y)+'.csv'

  f = open(table, 'w')

  for m in range(1, 13): #use 13 for full year. 
    for d in range(1, 32): #use 32 for full month. 
 
      # Check if leap year
      if y%400 == 0:
        leap = True
      elif y%100 == 0:
        leap = False
      elif y%4 == 0:
        leap = True
      else:
        leap = False
 
      # Check if already gone through month
      if (m == 2 and leap and d > 29):
        continue
      elif (m == 2 and d > 28):
        continue
      elif (m in [4, 6, 9, 10] and d > 30):
        continue
 
      # Open wunderground.com url
      url = "http://www.wunderground.com/history/airport/KNYC/"+str(y)+ "/" + str(m) + "/" + str(d) + "/DailyHistory.html"
      page = urllib2.urlopen(url)
      print url 
 
      # Get temperature from page
      soup = BeautifulSoup(page)
      # dayTemp = soup.body.nobr.b.string
      try:
        dayTemp = soup.findAll(attrs={"class":"nobr"})[2].span.string
      except:
        dayTemp = ''
      try:
        maxTemp = soup.findAll(attrs={"class":"nobr"})[4].span.string
      except:
        maxTemp = ''
      try:
        minTemp = soup.findAll(attrs={"class":"nobr"})[7].span.string
      except:
        minTemp = ''
      try:
        precip = soup.findAll(attrs={"class":"nobr"})[11].span.string
      except:
        precip = ''
      try:
        snow = soup.findAll(attrs={"class":"nobr"})[14].span.string 
      except:
        snow = ''
      try:
        dewpt = soup.findAll(attrs={"class":"nobr"})[10].span.string 
      except:
        dewpt = '' 
      try:
        wind = soup.findAll(attrs={"class":"nobr"})[18].span.string 
      except:
        wind = ''
      # Format month for timestamp
      if len(str(m)) < 2:
        mStamp = '0' + str(m)
      else:
        mStamp = str(m)
 
      # Format day for timestamp
      if len(str(d)) < 2:
        dStamp = '0' + str(d)
      else:
        dStamp = str(d)
 
      # Build timestamp
      timestamp = str(y) + mStamp + dStamp
 
      # Write timestamp and temperature to file
      f.write(timestamp + ',' + dayTemp + ',' + maxTemp + ',' + minTemp + ',' + precip + ',' + snow + ',' + dewpt +',' + wind +'\n')

      print 'added ' + timestamp + '-' + dayTemp + '-' + maxTemp + '-' + minTemp + '-' + precip + '-' + snow + '-' + dewpt + '-' + wind
 
# Done getting data! Close file.
f.close()


for y in range(2014, 2015):
  table  = '/Users/danielmsheehan/GitHub/python/weather_data/nyc_weather_data_'+str(y)+'.txt'
  outcsv = '/Users/danielmsheehan/GitHub/python/weather_data/nyc_weather_data_'+str(y)+'.csv'

  df = pd.read_csv(table, header=None) 
  #NEEEED TO TELL PYTHON THAT THERE IS CURRENTLY NO HEADER

  df.columns = ['date','tempmean','tempmax','tempmin','precip','snow','dewpt','wind']

  df['location'] = 'knyc-central park'

  df = df.replace('T', 0.001)

  df.to_csv(outcsv, index=False)


