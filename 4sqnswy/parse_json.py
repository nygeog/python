import urllib2, json, sys, csv, re, time

with open('checkins_mini.csv', 'rb') as f, open("checkins_mini_out.csv", "wb") as out_file:
	reader = csv.reader(f)
	next(reader, None)  # skip the headers
	writer = csv.writer(out_file)
	for row in reader:

		try:
			venue_id = row[1]
			ts_epoch = float(row[0])
			ts = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(ts_epoch))
			the_url = 'https://api.foursquare.com/v2/venues/' + str(venue_id) + '?oauth_token=DKMQRQ5G33P5B1XQIHBJRPPVS2QXJ1NX4US0CWOEFEOJDLIK&v=20131021'
			response = urllib2.urlopen(the_url)
			data = json.load(response)
			nam_return = data["response"]["venue"]["name"]
			adr_return = data["response"]["venue"]["location"]["address"]
			web_return = data["response"]["venue"]["shortUrl"]
			chk_return = data["response"]["venue"]["stats"] ["checkinsCount"]
			lat_return = data["response"]["venue"]["location"]["lat"]
			lng_return = data["response"]["venue"]["location"]["lng"]
			the_info = venue_id + ',' + ts + ',' + nam_return + ',' + adr_return + ',' + str(chk_return)  + ',' + web_return  + ',' + str(lat_return) + ',' + str(lng_return)
			print the_info
			outputRow = [venue_id, ts, nam_return, adr_return, web_return, chk_return, lat_return, lng_return]
			writer.writerow(outputRow)
		except:
			print "yo - I'm a weird address"