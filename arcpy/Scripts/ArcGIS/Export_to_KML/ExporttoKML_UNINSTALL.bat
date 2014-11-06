@echo off
rem Uninstalls City of Portland Bureau of Planning "Export to KML" extension and associated toolbars
rem Kevin Martin
rem 6/1/2008

@echo ------------------ 
@echo ------------------ 
@echo EXPORT TO KML
@echo Kevin Martin
@echo City of Portland
@echo Bureau of Planning
@echo ------------------ 
@echo This script will UNINSTALL the City of Portland's 'Export to KML'
@echo ArcMap extension.
@echo ------------------
@echo You must have administrative rights on your machine to uninstall the extension.
@echo ------------------
@echo Please close ArcMap before proceeding.
@echo ------------------
@echo ------------------ 
pause

start /WAIT regsvr32 /u ExporttoKML.dll