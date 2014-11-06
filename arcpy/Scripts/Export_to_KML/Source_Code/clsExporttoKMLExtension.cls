VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsExporttoKMLExtension"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
' ---------------------------------------------
' Export to KML Extension
' 12/7/2005

' Kevin Martin
' City of Portland/Bureau of Planning
' kmartin@ci.portland.or.us

' Description: Class module (IExtension) to create
'              'Export to KML' extension

' Object Type: CLASS MODULE (IEXTENSION)
' Language: VB

' Called by: application
' Calls: many

' History:
' 12/7/2005 - coded
' ---------------------------------------------

Option Explicit

Implements esriSystem.IExtension
Implements esriSystem.IExtensionConfig   'Allows extension to appear in the Extensions dialog

Private m_extState As esriSystem.esriExtensionState

Private Property Get IExtension_Name() As String
  IExtension_Name = "ExporttoKML"
End Property
 
Private Sub IExtension_Startup(ByRef initializationData As Variant)

End Sub
 
Private Sub IExtension_Shutdown()

End Sub
 
Private Property Get IExtensionConfig_ProductName() As String
  IExtensionConfig_ProductName = "Export to KML"
End Property
 
Private Property Get IExtensionConfig_Description() As String
  IExtensionConfig_Description = "ExporttoKML" & vbCrLf & "Version 2.5.5 -- May 24th, 2010" _
  & vbCrLf & "City of Portland, Oregon" & vbCrLf & "Bureau of Planning & Sustainability" & vbCrLf _
  & vbCrLf & "Adds 'Export to KML' toolbar for exporting point, lines, and polygons" _
  & vbCrLf & "to Google Earth KML format."
End Property
 
Private Property Get IExtensionConfig_State() As esriSystem.esriExtensionState
   IExtensionConfig_State = m_extState
End Property
 
Private Property Let IExtensionConfig_State(ByVal ExtensionState As esriSystem.esriExtensionState)
   m_extState = ExtensionState
End Property

