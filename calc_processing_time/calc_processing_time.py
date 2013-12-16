def CalcTime(not_ov, rev_ov):
	total_time_mins = 20 * (not_ov + (rev_ov * 25))
	total_time_hrs  = total_time_mins/60.

	#return total_time_hrs 
	return total_time_hrs

not_ov = 8.1 #minutes for class 0 
reg_ov = 1.33 #minutes for class 1-25

print CalcTime(8.1, 1.33)

start_time = 11 #11am

end_time = CalcTime(8.1, 1.33) + start_time

print end_time