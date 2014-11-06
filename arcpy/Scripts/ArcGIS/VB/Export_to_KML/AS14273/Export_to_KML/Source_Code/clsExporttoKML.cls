VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsExporttoKML"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
' ---------------------------------------------
' Export to KML Command
' 12/7/2005
'
' Kevin Martin
' City of Portland/Bureau of Planning
' kmartin@ci.portland.or.us
'
' Description: Class module (ICommand) for exporting a layer
'              to Google Earth KML format.
'
' Object Type: CLASS MODULE (ICOMMAND)
' Language: VB
'
' Called by: ICOMMAND INTERFACE
' Calls: frmExporttoKML
'
' History:
' 12/7/2005 - coded
' ---------------------------------------------

Option Explicit

Implements esriSystemUI.ICommand

Private m_App As esriFramework.IApplication  'ArcMap application
Private m_pMxDoc As esriArcMapUI.IMxDocument

' Variables used by the Error handler function - DO NOT REMOVE
Const c_sModuleFileName As String = "clsExporttoKML"       ' Constant reflect file module name
 
Private Property Get ICommand_Enabled() As Boolean
  On Error GoTo ErrorHandler
  
  ' enable button when at least one layer is in the TOC
  ICommand_Enabled = basPublicProcedures.EnableUIControl(m_pMxDoc)
  
  Exit Property
ErrorHandler:
  HandleError True, "ICommand_Enabled " & c_sModuleFileName & " " & GetErrorLineNumberString(Erl), Err.Number, Err.Source, Err.Description, 4
End Property
 
Private Property Get ICommand_Checked() As Boolean
  On Error GoTo ErrorHandler
  
  ' NO CODE
  
  Exit Property
ErrorHandler:
  HandleError True, "ICommand_Checked " & c_sModuleFileName & " " & GetErrorLineNumberString(Erl), Err.Number, Err.Source, Err.Description, 4
End Property
 
Private Property Get ICommand_Name() As String
  On Error GoTo ErrorHandler
  
  ' name for outside reference
  ICommand_Name = "ExporttoKML"
  
  Exit Property
ErrorHandler:
  HandleError True, "ICommand_Name " & c_sModuleFileName & " " & GetErrorLineNumberString(Erl), Err.Number, Err.Source, Err.Description, 4
End Property
 
Private Property Get ICommand_Caption() As String
  On Error GoTo ErrorHandler
  
  ' sets the caption
  ICommand_Caption = "Export to KML"
  
  Exit Property
ErrorHandler:
  HandleError True, "ICommand_Caption " & c_sModuleFileName & " " & GetErrorLineNumberString(Erl), Err.Number, Err.Source, Err.Description, 4
End Property
 
Private Property Get ICommand_Tooltip() As String
  On Error GoTo ErrorHandler
  
  ' set the tool tip
  ICommand_Tooltip = "Export to KML"
  
  Exit Property
ErrorHandler:
  HandleError True, "ICommand_Tooltip " & c_sModuleFileName & " " & GetErrorLineNumberString(Erl), Err.Number, Err.Source, Err.Description, 4
End Property
 
Private Property Get ICommand_Message() As String
  On Error GoTo ErrorHandler
  
  ' add message in status bar
  ICommand_Message = "Export a specified point, polyline, or polygon layer to Google Earth KML format"
  
  Exit Property
ErrorHandler:
  HandleError True, "ICommand_Message " & c_sModuleFileName & " " & GetErrorLineNumberString(Erl), Err.Number, Err.Source, Err.Description, 4
End Property
 
Private Property Get ICommand_HelpFile() As String
  On Error GoTo ErrorHandler
  
  ' NO CODE
  
  Exit Property
ErrorHandler:
  HandleError True, "ICommand_HelpFile " & c_sModuleFileName & " " & GetErrorLineNumberString(Erl), Err.Number, Err.Source, Err.Description, 4
End Property
 
Private Property Get ICommand_HelpContextID() As Long
  On Error GoTo ErrorHandler
  
  ' NO CODE
  
  Exit Property
ErrorHandler:
  HandleError True, "ICommand_HelpContextID " & c_sModuleFileName & " " & GetErrorLineNumberString(Erl), Err.Number, Err.Source, Err.Description, 4
End Property
 
Private Property Get ICommand_Bitmap() As esriSystem.OLE_HANDLE
  On Error GoTo ErrorHandler
  
    ' get the icon for the button
    ICommand_Bitmap = frmBitmaps.picExporttoKMLIcon.Picture.Handle
  
  Exit Property
ErrorHandler:
  HandleError True, "ICommand_Bitmap " & c_sModuleFileName & " " & GetErrorLineNumberString(Erl), Err.Number, Err.Source, Err.Description, 4
End Property
 
Private Property Get ICommand_Category() As String
  On Error GoTo ErrorHandler
  
  ' places the command in the proper category
  ICommand_Category = "Export to KML"
  
  Exit Property
ErrorHandler:
  HandleError True, "ICommand_Category " & c_sModuleFileName & " " & GetErrorLineNumberString(Erl), Err.Number, Err.Source, Err.Description, 4
End Property
 
Private Sub ICommand_OnCreate(ByVal hook As Object)
  On Error GoTo ErrorHandler
  
  ' get the hook to the ESRI application object
  Set m_App = hook
  Set m_pMxDoc = m_App.Document
  
  Exit Sub
ErrorHandler:
  HandleError True, "ICommand_OnCreate " & c_sModuleFileName & " " & GetErrorLineNumberString(Erl), Err.Number, Err.Source, Err.Description, 4
End Sub
 
Private Sub ICommand_OnClick()
  On Error GoTo ErrorHandler
  
  ' send application to form
  Load frmExporttoKML
  frmExporttoKML.Application = m_App
    
  ' get map layers
  Dim pEnumLayers As esriCarto.IEnumLayer
  Set m_pMxDoc = m_App.Document
  Set pEnumLayers = m_pMxDoc.FocusMap.Layers
  
  ' populate input layer dropdown with point, line, and polygon feature layer names
  Dim pLayer As esriCarto.ILayer
  Dim pFLayer As esriCarto.IFeatureLayer2
  Dim n As Integer
  n = 0
  Set pLayer = pEnumLayers.Next
  Do Until pLayer Is Nothing
    If TypeOf pLayer Is IFeatureLayer And Not TypeOf pLayer Is IGroupLayer Then
      Set pFLayer = pLayer
      If pFLayer.ShapeType = esriGeometryPoint Or pFLayer.ShapeType = esriGeometryPolyline Or _
      pFLayer.ShapeType = esriGeometryPolygon Then
        If Not pFLayer.FeatureClass Is Nothing Then
          If pFLayer.FeatureClass.FeatureType <> esriFTCoverageAnnotation And _
          pFLayer.FeatureClass.FeatureType <> esriFTAnnotation Then
            If pFLayer.FeatureClass.FeatureCount(Nothing) > 0 Then
              frmExporttoKML.cboInputLayer.AddItem pLayer.Name, n
              n = n + 1
            End If
          End If
        End If
      End If
    End If
    Set pLayer = pEnumLayers.Next
  Loop
  
  ' exit if no supported feature layers are found in the map
  If frmExporttoKML.cboInputLayer.ListCount < 1 Then
    MsgBox "The map does not contain any POINT, POLYLINE, or POLYGON features." _
    & "There are no layers to export.", vbExclamation, "Export to Google Earth KML"
    Unload frmExporttoKML
    Exit Sub
  Else
    ' show form
    Load frmExporttoKMLOptions
    frmExporttoKML.Show vbModal
  End If
  
  Exit Sub
ErrorHandler:
  HandleError True, "ICommand_OnClick " & c_sModuleFileName & " " & GetErrorLineNumberString(Erl), Err.Number, Err.Source, Err.Description, 4
End Sub

Private Sub Class_Terminate()
   ' clean up code
   Set m_App = Nothing
   Set m_pMxDoc = Nothing
   
   ' unload all forms
   Dim pForm As VB.Form
   For Each pForm In VB.Forms
     Unload pForm
   Next pForm
End Sub

