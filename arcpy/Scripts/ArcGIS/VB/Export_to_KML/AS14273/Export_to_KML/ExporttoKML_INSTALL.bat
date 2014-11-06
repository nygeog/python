@echo off
rem Installs City of Portland Bureau of Planning "Export to KML" extension and associated toolbars
rem Kevin Martin
rem 6/1/2008

@echo ------------------ 
@echo ------------------ 
@echo EXPORT TO KML
@echo Kevin Martin
@echo City of Portland
@echo Bureau of Planning
@echo ------------------ 
@echo This script will INSTALL the City of Portland's 'Export to KML'
@echo ArcMap extension.
@echo ------------------
@echo This extension is offered freely to the community, but is provided "as is".
@echo Any express or implied warranties, including the implied warranties of
@echo merchantability and fitness for a particular purpose are disclaimed. In no
@echo event shall myself or the City of Portland or contributors be liable for
@echo any direct, indirect, incidental, special, exemplary, or consequential
@echo damages.
@echo ------------------
@echo You must have administrative rights on your machine to install the extension.
@echo ------------------
@echo Please close ArcMap before proceeding.
@echo ------------------
@echo ------------------ 
pause

start /WAIT regsvr32 ExporttoKML.dll
start /WAIT regedit ExporttoKML.reg

