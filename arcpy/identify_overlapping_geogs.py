import arcpy
from arcpy import env
env.overwriteOutput = True

def makeOverlapDict(fc, returnID = None):  
    """This function creates a dictionary relating each feature to a list of its  
    overlapping features. The optional returnID parameter can be used to create  
    an overlapDict with keys equal to a different unique ID than OID, which is the  
    default."""  
    fcName = arcpy.Describe(fc).name  
    if not returnID:  
        returnID = 'FID_' + fcName  
        returnID2 = 'FID_' + fcName + '_1'  
    else:  
        returnID2 = returnID + '_1'  
  
    identity = arcpy.Identity_analysis(fc, fc, fcName + 'ID')  
  
    overlapDict = {}  
    with arcpy.da.SearchCursor(identity, (returnID, returnID2)) as cursor:  
        for row in cursor:  
            if row[0] <> row[1]:  
                if not overlapDict.get(row[0]):  
                    overlapDict[row[0]] = [row[1]]  
                else:  
                    overlapDict[row[0]].append(row[1])  
  
    arcpy.Delete_management(identity)  
  
    return overlapDict  
  
def makeExplodeDict(overlapDict):  
    """This function creates a new dictionary relating each feature to  
    its explode value based on the overlapDict."""  
  
    # set initial explode value to 1  
    expl = 1  
    # create dictionary to hold explode values of oids  
    explDict = {}  
    overlapDict2 = overlapDict.copy()  
    # while there are still keys in overlapDict2 not also in explDict  
    while len([k for k in overlapDict2.iterkeys() if not explDict.get(k)]) > 0:  
        # create list to hold overlapping oids  
        ovSet = set()  
        # loop over overlapDict2  
        for oid, ovlps in overlapDict2.iteritems():  
            if not explDict.get(oid) and oid not in ovSet:  
                explDict[oid] = expl  
                for o in ovlps:  
                    ovSet.add(o)  
        for oid in explDict.iterkeys():  
            if overlapDict2.get(oid):  
                del overlapDict2[oid]  
        print expl  
        expl += 1  
    return explDict  
  
def defineOverlaps(fc):  
    """This function creates three fields: 'overlaps', which lists the OBJECTIDs  
    of all other polygons overlapping each polygon, and 'ovlpCount', which counts  
    the number of overlaps per feature, and 'expl', which separates all features  
    into unique non-overlapping groups by value."""  
  
    # Build dicts used to relate each feature to all identical, overlapping shapes  
    overlapDict = makeOverlapDict(fc)  
  
    # Loop through overlapDict and give each oid an expl value that separates all oids into  
    # non-overlapping groups  
    explDict = makeExplodeDict(overlapDict)  
  
    # Add remaining non-overlapping oids into explDict and give them an expl value  
    # equal to the max expl; the max should have the least members, and this preserves  
    # a good distribution of values so that each processing step is somewhat balanced  
    maxExpl = max(explDict.itervalues())  
    query = str(tuple(explDict.keys()))  
    fillVals = []  
    with arcpy.da.SearchCursor(fc, ("OID@"), '"OBJECTID" NOT IN ' + query) as cursor:  
        for row in cursor:  
            fillVals.append(row[0])  
    for val in fillVals:  
        explDict[val] = maxExpl  
  
    # Add overlaps, ovlpCount, and expl fields  
    arcpy.AddField_management(fc,'overlaps',"TEXT",'','',1000) # the 1000 is the field character limit... increase if need be  
    arcpy.AddField_management(fc,'ovlpCount',"SHORT")  
    arcpy.AddField_management(fc,'expl',"SHORT")  
  
    # For each row with an overlapping poly (i.e. with an entry in idDict)  
    # give overlaps value of all overlapping ids, ovlpCount value of how  
    # many overlaps occur, and expl value that separates all features into  
    # unique non-overlapping groups (explode value)  
  
    with arcpy.da.UpdateCursor(fc,("OID@","overlaps","ovlpCount","expl")) as cursor:  
        for row in cursor:  
            # If oid in overlapDict, write overlapping oids and their count  
            # to the appropriate fields  
            if overlapDict.get(row[0]):  
                row[1] = str(overlapDict[row[0]]).strip('[]')  
                row[2] = len(overlapDict[row[0]])  
            # Write expl value to expl field  
            row[3] = explDict[row[0]]  
            cursor.updateRow(row)  



#####CHANGE THE STUFF HERE


dr = 'V'
wd = dr+':/GIS/projects/naas/tasks/201410_pollen_sites/data/'
wi = wd+'input/'
wp = wd+'processing/'
wo = wd+'output/'

#from _misc import wi, dbox
geogList     = ['p']#,'h','s','g']
radbufListFn = ['r0050m','r0100m','r0250m','r0500m','r1000m']
radbufListFn = radbufListFn[2:]

for a in geogList:
    for b in radbufListFn:
        defineOverlaps(wp+'geogs/buffers.gdb/'+a+b)  


#MUST RUN THIS IN ARCMAP