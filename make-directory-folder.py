import os

nearDirList = ['air_pollution','multipurpose','baseball','parks','basketball',
'playgrounds','beaches','pools','building_footprints','roadbed','centerline_2013',
'sidewalk','centerline_2013_lanes_g2','soccer_football','centerline_2013_lanes_l2',
'tennis','centerline_2014','tracks','centerline_2014_highway','truck_routes_all',
'golfcourses','truck_routes_local','handball','truck_routes_through']

for i in nearDirList:
	newpath = '/Volumes/Lima/GIS/projects/driscoll/tasks/201602_gps_points/data/tables/near/'+i
	if not os.path.exists(newpath):
		os.makedirs(newpath)