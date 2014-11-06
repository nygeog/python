VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCustomGXFilter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
' ---------------------------------------------
' clsCustomGXFilter
' 9/7/05
'
' Kevin Martin
' City of Portland/Bureau of Planning
' kmartin@ci.portland.or.us
'
' Description: Defines a custom GX filter for
' saving out to KML format (adapted from
' ESRI developer sample)
'
' Object Type: CLASS MODULE
' Language: VB
'
' History:
' 9/7/05 - coded in VBA
' 9/13/05 - converted to VB
' ---------------------------------------------

Option Explicit

Implements esricatalog.IGxObjectFilter

Private m_pBasicFilter As esricatalog.IGxObjectFilter
Private m_pFileSystemObject As Object
Private m_strFileTypeExtension As String
Private m_strFileTypeDescription As String

Public Property Let FileTypeExtension(ByVal strExtension As String)
  m_strFileTypeExtension = VBA.UCase(strExtension)
End Property

Public Property Let FileTypeDescription(ByVal strDescription As String)
  m_strFileTypeDescription = strDescription
End Property

Private Sub Class_Initialize()
  ' Create a BasicFilter first.
  Set m_pBasicFilter = New esricatalog.GxFilterBasicTypes
  Set m_pFileSystemObject = CreateObject("Scripting.FileSystemObject")
End Sub

Private Sub Class_Terminate()
  Set m_pBasicFilter = Nothing
  Set m_pFileSystemObject = Nothing
End Sub

Private Function IGxObjectFilter_CanChooseObject(ByVal Object As esricatalog.IGxObject, result As esricatalog.esriDoubleClickResult) As Boolean
  result = esricatalog.esriDoubleClickResult.esriDCRNothing
  
  IGxObjectFilter_CanChooseObject = IsFileType(Object)
End Function

Private Function IGxObjectFilter_CanDisplayObject(ByVal Object As esricatalog.IGxObject) As Boolean
  IGxObjectFilter_CanDisplayObject = False
  If m_pBasicFilter.CanDisplayObject(Object) Then
    IGxObjectFilter_CanDisplayObject = True
  Else
    IGxObjectFilter_CanDisplayObject = IsFileType(Object)
  End If
End Function

Private Function IGxObjectFilter_CanSaveObject(ByVal Location As esricatalog.IGxObject, ByVal newObjectName As String, objectAlreadyExists As Boolean) As Boolean
  IGxObjectFilter_CanSaveObject = True ' False
  Dim sExt As String
  sExt = GetExtension(newObjectName)
  If VBA.Len(sExt) = 0 Then
    newObjectName = newObjectName & "." & m_strFileTypeExtension
  ElseIf Not VBA.UCase(sExt) = "." & m_strFileTypeExtension Then
    newObjectName = VBA.Left(newObjectName, VBA.Len(newObjectName) - VBA.Len(sExt)) & VBA.LCase("." & m_strFileTypeExtension)
  End If
  If m_pFileSystemObject Is Nothing Then Exit Function
  
  Dim sFullPath As String
  sFullPath = Location.FullName & "\" & newObjectName
  objectAlreadyExists = m_pFileSystemObject.FileExists(sFullPath)
  
  If TypeOf Location Is esricatalog.IGxFolder Then
    IGxObjectFilter_CanSaveObject = True
  End If
End Function

Private Property Get IGxObjectFilter_Description() As String
  IGxObjectFilter_Description = m_strFileTypeDescription & " (." & VBA.LCase(m_strFileTypeExtension) & ")"
End Property

Private Property Get IGxObjectFilter_Name() As String
  IGxObjectFilter_Name = m_strFileTypeExtension & " File Filter"
End Property

Private Function IsFileType(ByVal Object As esricatalog.IGxObject) As Boolean
  IsFileType = False
  If VBA.UCase(Object.FullName) Like "*." & m_strFileTypeExtension Then
    IsFileType = True
  End If
End Function

Private Function GetExtension(filename As String) As String
  Dim extPos As Long
  extPos = VBA.InStrRev(filename, ".")
  If extPos > 0 Then
    GetExtension = VBA.Mid(filename, extPos)
  Else
    GetExtension = ""
  End If
End Function


