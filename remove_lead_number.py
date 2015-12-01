x = '51 LINDEN BLVD'
y = '1 114TH AVE'


def removeLeadNumber(addy):
	addr = str(addy)
	if addr.split(' ',1)[0].isdigit() == True:
		z = addr.replace(addr.split(' ',1)[0],'')
	else:
		z = addr

	print z

removeLeadNumber(x)
removeLeadNumber(y)