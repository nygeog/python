import datetime
import time

now = datetime.datetime.now()

while True: 
	print 'test'
	
	if now.strftime("%H-%M") == '13-22':
		print 'whoa'

	time.sleep(40)
	
	