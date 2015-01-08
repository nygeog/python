print 'variables after running sum stats'
#old freq = 38716.0
freq = 35646.0
minV = 0
maxV = freq

CalcQuartilesExpr  = "Reclass(!OBJECTID!, minV, maxV)"
CalcQuartilesBlock = """def Reclass(qVal, Min, Max):
  quant1 = Min + ((Max - Min)/4)
  quant2 = Min + (((Max - Min)/4)*2)
  quant3 = Min + (((Max - Min)/4)*3)
  if (qVal >= Min and qVal < quant1):
  	return 1
  elif (qVal >= quant1 and qVal < quant2):
  	return 2
  elif (qVal >= quant2 and qVal < quant3):
  	return 3
  elif (qVal >= quant3 and qVal <= Max):
  	return 4
  else:
  	return 99"""

print 'calculate bulkdens quartiles'
arcpy.AddField_management(wd+"processing/census.gdb/nycb2010_bulkdens_sel_loc_sort",'bulkdensquant','LONG')
arcpy.CalculateField_management(wd+"processing/census.gdb/nycb2010_bulkdens_sel_loc_sort",'bulkdensquant',CalcQuartilesExpr , "PYTHON_9.3",CalcQuartilesBlock )
