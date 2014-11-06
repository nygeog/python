Attribute VB_Name = "basPublicProcedures"
Option Explicit

Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hWnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Global Const SW_SHOWNORMAL = 1

' ENABLEUICONTROL
' 3/4/2002
' Description: Returns BOOLEAN indicating whether to enable/disable a UIControl
' Procedure Type: Function
' Called by: clsExporttoKML
' Calls: None
' Notes: Valid qualifiers : SELECTION - must have something selected
'                           LAYOUT - must be in page layout mode
'
' -- otherwise, assumes that must have at least 1 layer added --

Public Function EnableUIControl(aMXDocument As esriArcMapUI.IMxDocument, Optional strQualifier As String) As Boolean
  ' dimension variables
  Dim pMXdocument As esriArcMapUI.IMxDocument
  Dim pMap As esricarto.IMap
  Set pMXdocument = aMXDocument
  Set pMap = pMXdocument.FocusMap
  
  ' enables layout tools
  If UCase(strQualifier) = "LAYOUT" Then
    If pMXdocument.ActiveView Is pMXdocument.PageLayout Then
      EnableUIControl = True
    End If
  
  ' checks for at least one layer
  ElseIf pMXdocument.FocusMap.LayerCount > 0 Then
    ' if boolMustHaveSelection = True, then checks if selection count > 0
    If UCase(strQualifier) = "SELECTION" Then
      If pMap.SelectionCount > 0 Then
        EnableUIControl = True
      Else
        EnableUIControl = False
      End If
    Else
      EnableUIControl = True
    End If
  Else
    EnableUIControl = False
  End If
End Function

' CURRENTDIRECTORY
' 12/23/2002
' Description: Returns the path of the current document directory
' Procedure Type: Function
' Called by: many
' Calls:

Public Function CurrentDirectory(aApplication As IApplication, Optional boolWithFileName As Boolean = False) As String
  Dim pTemplates As ITemplates
  Dim lTempCount As Long
  Dim strDocument As String
  Dim strDocPath As String
  Set pTemplates = aApplication.Templates
  lTempCount = pTemplates.Count
    
  ' the document is always the last template item
  strDocument = pTemplates.Item(lTempCount - 1)
  If boolWithFileName = True Then
    CurrentDirectory = strDocument
  Else
    CurrentDirectory = Left(strDocument, InStrRev(strDocument, "\"))
  End If
End Function
