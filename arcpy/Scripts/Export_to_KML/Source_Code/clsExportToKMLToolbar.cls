VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsExportToKMLToolbar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
' ---------------------------------------------
' Export to KML ToolBar
' 12/7/2005

' Kevin Martin
' City of Portland/Bureau of Planning
' kmartin@ci.portland.or.us

' Description: Class module (IToolBarDef) to create
'              'Export to KML' toolbar

' Object Type: CLASS MODULE (ITOOLBARDEF)
' Language: VB

' Called by: ITOOLBARDEF INTERFACE
' Calls: many

' History:
' 12/7/2005 - coded
' ---------------------------------------------

Option Explicit

Implements esriSystemUI.IToolBarDef

' Variables used by the Error handler function - DO NOT REMOVE
Const c_sModuleFileName As String = "clsExportToKMLToolbar"       ' Constant reflect file module name

Private Sub Class_Terminate()
  ' unload all forms
  Dim pForm As VB.Form
  For Each pForm In VB.Forms
    Unload pForm
  Next pForm
End Sub

Private Property Get IToolBarDef_ItemCount() As Long
  On Error GoTo ErrorHandler
  
  ' number of commands
  IToolBarDef_ItemCount = 1
  
  Exit Property
ErrorHandler:
  HandleError True, "IToolBarDef_ItemCount " & c_sModuleFileName & " " & GetErrorLineNumberString(Erl), Err.Number, Err.Source, Err.Description, 4
End Property
 
Private Sub IToolBarDef_GetItemInfo(ByVal pos As Long, ByVal itemDef As esriSystemUI.IItemDef)
  On Error GoTo ErrorHandler
  
  ' define the commands on the toolbar
  Select Case pos
    Case 0
      itemDef.ID = "prjExporttoKML.clsExporttoKML"
      itemDef.Group = False
  End Select
  
  Exit Sub
ErrorHandler:
  HandleError True, "IToolBarDef_GetItemInfo " & c_sModuleFileName & " " & GetErrorLineNumberString(Erl), Err.Number, Err.Source, Err.Description, 4
End Sub
 
Private Property Get IToolBarDef_Name() As String
  On Error GoTo ErrorHandler
  
  ' internal name
  IToolBarDef_Name = "ExporttoKMLToolbar"
  
  Exit Property
ErrorHandler:
  HandleError True, "IToolBarDef_Name " & c_sModuleFileName & " " & GetErrorLineNumberString(Erl), Err.Number, Err.Source, Err.Description, 4
End Property
 
Private Property Get IToolBarDef_Caption() As String
  On Error GoTo ErrorHandler
  
  ' caption and title
  IToolBarDef_Caption = "Export to KML"
  
  Exit Property
ErrorHandler:
  HandleError True, "IToolBarDef_Caption " & c_sModuleFileName & " " & GetErrorLineNumberString(Erl), Err.Number, Err.Source, Err.Description, 4
End Property

