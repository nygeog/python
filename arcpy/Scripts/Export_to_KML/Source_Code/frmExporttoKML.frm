VERSION 5.00
Begin VB.Form frmExporttoKML 
   Caption         =   "Export to Google Earth KML"
   ClientHeight    =   4035
   ClientLeft      =   8790
   ClientTop       =   1170
   ClientWidth     =   5565
   Icon            =   "frmExporttoKML.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4035
   ScaleWidth      =   5565
   Begin VB.CheckBox chkExtrudeFeatures 
      Caption         =   "Extrude features based on the height"
      Enabled         =   0   'False
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   3000
      Width           =   3375
   End
   Begin VB.CommandButton cmdMoreOptions 
      Caption         =   "Options"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   4560
      TabIndex        =   10
      ToolTipText     =   "Advanced export options"
      Top             =   960
      Width           =   855
   End
   Begin VB.CheckBox chkUseLayerSymbology 
      Caption         =   "Group and color features using the layer's symbology"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   840
      Value           =   1  'Checked
      Width           =   4335
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   4560
      TabIndex        =   9
      Top             =   1680
      Width           =   855
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   4560
      TabIndex        =   11
      Top             =   240
      Width           =   855
   End
   Begin VB.CommandButton cmdBrowsetoOutput 
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   400
      Left            =   4920
      Picture         =   "frmExporttoKML.frx":628A
      Style           =   1  'Graphical
      TabIndex        =   8
      ToolTipText     =   "Browse to file"
      Top             =   3555
      Width           =   500
   End
   Begin VB.OptionButton optHeightinMeters 
      Caption         =   "meters"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   2760
      TabIndex        =   5
      Top             =   2640
      Width           =   855
   End
   Begin VB.OptionButton optHeightinFeet 
      Caption         =   "feet"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   1920
      TabIndex        =   4
      Top             =   2640
      Value           =   -1  'True
      Width           =   735
   End
   Begin VB.TextBox txtOutputKML 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   120
      Locked          =   -1  'True
      TabIndex        =   7
      Top             =   3600
      Width           =   4695
   End
   Begin VB.ComboBox cboHeightAttribute 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   120
      Style           =   2  'Dropdown List
      TabIndex        =   3
      Top             =   2160
      Width           =   4095
   End
   Begin VB.ComboBox cboLabelAttribute 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   120
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   1440
      Width           =   4095
   End
   Begin VB.ComboBox cboInputLayer 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   120
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   360
      Width           =   4095
   End
   Begin VB.Label lblBogusLayer 
      Caption         =   "lblBogusLayer"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   120
      TabIndex        =   17
      Top             =   840
      Visible         =   0   'False
      Width           =   4215
   End
   Begin VB.Label lblHeightUnits 
      Caption         =   "Height attribute units:"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   16
      Top             =   2640
      Width           =   1935
   End
   Begin VB.Label lblOutputKML 
      Caption         =   "Name and location of the output KML:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   15
      Top             =   3360
      Width           =   4575
   End
   Begin VB.Label lblHeightAttribute 
      Caption         =   "Select an attribute that represents the height (Optional):"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   14
      Top             =   1920
      Width           =   4335
   End
   Begin VB.Label lblLabelAttribute 
      Caption         =   "Select an attribute for labeling features (Optional):"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   13
      Top             =   1200
      Width           =   4095
   End
   Begin VB.Label lblInputLayer 
      Caption         =   "Select the layer to export:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   12
      Top             =   120
      Width           =   3975
   End
End
Attribute VB_Name = "frmExporttoKML"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' ---------------------------------------------
' frmExportToKML
' 12/7/2005
'
' Kevin Martin
' City of Portland/Bureau of Planning
' kmartin@ci.portland.or.us
'
' Description: Exports 2D and 3D point, line, and
' polygon features to Google Earth KML format
'
' Object Type: FORM
' Language: VB
'
' History:
' 12/7/05 -  upgraded to Version 2.1 (see "what's new" in documentation for
'            a complete description of new functionality)
' 12/8/05 -  fixed problems with modeless forms
' 12/9/05 -  fixed error with path name
' 12/28/05 - fixed problems with extruded symbology (modified code
'            to export exterior polygon segments in cc direction); separated
'            3D height/extrusion; added safegaurds when dealing with 3D polygons
' 2/21/06  - upgraded to version 2.2; see "what's new" in documentation for
'            a complete description of new functionality
' 2/21/06  - fixed error with GXDialog freezing
' 2/27/06  - fixed error with polygons that resulted from topology errors;
'            modified code to correctly display "no color" fill and outlines
' 3/15/06  - modified code to skip over any features with empty geometries
' 3/21/06  - fixed error when null values were in symbolization field; modified
'            the way Null values are handled and labeled
' 4/3/06   - modified to recognize defintion query; correctly numbers labels and
'            info points in progress bar; use CDATA tag for descriptions
' 8/1/06   - upgraded to version 2.3; see "what's new" in documentation for
'            a complete description of new functionality
' 8/8/06   - fixed issue with Euro operating systems; clean polygon topology
'            on export (IPolygon4.Simplifyex)
' 8/14/06  - fixed issue with "info points" (was only displaying info for last
'            feature)
' 9/7/06   - fixed MAJOR error introduced at version 2.3.2 regarding height coversion
'            to meters
' 3/27/07  - removed unnecessary leading comma from line/polygon coordinates; caused
'            problems with Google Maps
' 5/10/07  - fixed issue with circles and curves not being exported from geodatabases
' 9/5/07   - added "schema options"; added manual surface offsets; implemented
'            CDATA tag; made feature names independent of labels; modified code
'            to adhere to VB variable-naming conventions
' 9/12/07  - added ability to save and import layer and feature description files
' 9/13/07  - added ability to manually shift the data using x/y parameters
' 11/20/07 - incorporated "start" and "end" time stamps for features
' 11/21/07 - fixed issue with string/double class breaks conversion
' 12/20/07 - fixed issue with info points and multi-part geometries; added checkbox option
'            for forcing labels/info points to fall inside polygons; changed the way
'            label and info points are generated (GetFeatureLabelPoint function)
' 1/4/08   - added timestamp date/time XML formatting
' 1/10/08  - fixed a glitch with the way time stamps were recorded
' 2/6/08   - fixed error that occurred in GE if non-alphanumeric characters were present
'            in the layer symbology
' 3/20/08  - removed adding of <br /> to cleaning of feature descriptions(to allow for cleaner
'            use of HTML; added snippet tags to layer and feature descriptions (currently only
'            used to prevent descriptions from appearing under item names); used <BalloonStyles>
'            to clean up feature descriptions (feature names no longer added by default)
' 6/5/08   - fully implemented 2.2 Schema and ExtendedData tags and balloon styles (greatly
'            improving the efficiency and transferability of the output KML); new structure
'            allows much more flexibility for HTML customizations
' 6/11/08  - fixed issue with true curves in polylines; added ability to specify a coordinate
'            transformation method when exporting data in a different coordinate system
' 6/18/08  - added support for geodatabase domain values; use field aliases when available
' 5/13/09  - added latest KML encoding; layers created from selections now supported; <Snippets>
'            can be edited; schemas can be exported as "typed" or "untyped"; option
'            to export Google Maps compatible KMLs
' 5/24/10  - fixed issues with label end times being incorrectly recorded
' ---------------------------------------------

Option Explicit
Option Compare Text

' GLOBAL VARIABLES
' input layer
Public g_pInputLayer As esricarto.ILayer

' layer's symbol db field
Public g_pLayerSymbolField As esriGeoDatabase.IField

' variables for naming and labeling features
Public g_boolFeatureNameAttributeManuallySet As Boolean
Public g_boolExportSeparateLabels As Boolean

' variable for determining if a eographic transformation is necessary
Public g_strGCSTransformation As String

' MODULE-LEVEL VARIABLES
' application  variables
Private m_pApplication As esriFramework.IApplication
Private m_pMxDocument As esriArcMapUI.IMxDocument
Private m_pMap As esricarto.IMap

' arcMap status bar variables
Private m_pStatusBar As esriSystem.IStatusBar
Private m_pProgressBar As esriSystem.IStepProgressor

' KML file lines
Private m_strNextKMLLine As String

' variables for dealing with projections and units
Private m_pSpRefInput As esriGeometry.ISpatialReference
Private m_pSpRefOutput As esriGeometry.ISpatialReference
Private m_pOutputGeoTransformation As esriGeometry.IGeoTransformation
Private m_boolSpRefEqual As Boolean
Private m_boolPerformGCSTransform As Boolean

' variable for setting layer transparency
Private m_strTransparency As String

' variables for storing and managing renderers
Private m_pGFLayerRenderer As esricarto.IFeatureRenderer
Private m_pUniqueValueRenderer As esricarto.IUniqueValueRenderer
Private m_pClassBreaksRenderer As esricarto.IClassBreaksRenderer
Private m_pSimpleRenderer As esricarto.ISimpleRenderer
Private m_boolUseArcMapSymbology As Boolean
Private m_strLayerRendererHeading As String
Private m_boolClassBreaksAscending As Boolean
Private m_intClassBreakIndex As Integer

' variables for getting, organizing and storing style and group names
' feature values
Private m_strFeatureValue As String
Private m_lngFeatCount As Long
Private m_boolExporttheFeature As Boolean

' KML "style" names
Private m_strKMLStyles() As String
Private m_strStyleName As String
Private m_strLabelStyleName As String
Private m_strLabelStyleNames() As String

' KML "group" (folder) names
Private m_strGroupName As String
Private m_strPreviousGroupName As String
Private m_lngGroupCount As Long
Private m_boolGroupExists As Boolean

' variables for labeling, describing, and attributing features
Private m_pDBFields As esriGeoDatabase.IFields2
Private m_boolLabelFeatures As Boolean
Private m_strLabelNames() As String
Private m_strFeatureSnippet As String
Private m_strFeatureDescription As String
Private m_intSchemaFieldCount As Integer
Private m_strFeatureSchema() As String
Private m_strFeatureSchemas() As String
Private m_strLabelXYZs() As String
Private m_strInfoPointXYZs() As String
Private m_strFeatureName As String
Private m_strFeatureNames() As String
Private m_strKMLSchemaName As String
Private m_boolGoogleMapsCompatible As Boolean
Private m_boolUseUnTypedData As Boolean

' variables for extrusion and tessellation
Private m_intExtrusion As Integer
Private m_intTessellate As Integer
Private m_strAltitudeMode As String
Private m_intLabelExtrusion As Integer
Private m_strAltitudeModeLabels As String
Private m_intInfoPtExtrusion As Integer
Private m_strAltitudeModeInfoPts As String

' variables for recording X/Y/Z coordinates
Private m_strXCoord As String
Private m_strYCoord As String
Private m_strZCoord As String
Private m_dblZCoord As Double
Private m_dblOffsetValue As Double
Private m_strOffsetValue As String
Private m_sglUnitConversion As Single
Private m_boolIs3DShape As Boolean
Private m_boolIs3DAttribute As Boolean

' variables for adding time information
Private m_boolAddTimeStamps As Boolean
Private m_strStartTime As String
Private m_strEndTime As String
Private m_strStartTimes() As String
Private m_strEndTimes() As String

' other module-level variables
Private m_pMouseCursor As esriFramework.IMouseCursor
Private m_lngCount As Long

Public Property Let Application(ByVal pApp As esriFramework.IApplication)
  Set m_pApplication = pApp
End Property

Private Sub cboHeightAttribute_Click()
  ' enable/disable extrusion checkbox
  If Trim(cboHeightAttribute.Text <> "<NONE>") Then
    lblHeightUnits.Enabled = True
    optHeightinFeet.Enabled = True
    optHeightinMeters.Enabled = True
    chkExtrudeFeatures.Enabled = True
    chkExtrudeFeatures.Value = vbChecked
    frmExporttoKMLOptions.lblOffsetAttribute.Enabled = True
    frmExporttoKMLOptions.cboOffsetAttribute.Enabled = True
    frmExporttoKMLOptions.lblOffsetManual.Enabled = True
    frmExporttoKMLOptions.txtOffsetManual.Enabled = True
    frmExporttoKMLOptions.optAMClamped.Enabled = False
    frmExporttoKMLOptions.optAMRelative.Enabled = True
    frmExporttoKMLOptions.optAMAbsolute.Enabled = True
    If frmExporttoKMLOptions.optAMClamped.Value = True Then
      frmExporttoKMLOptions.optAMRelative.Value = True
    End If
  Else
    lblHeightUnits.Enabled = False
    optHeightinFeet.Enabled = False
    optHeightinMeters.Enabled = False
    chkExtrudeFeatures.Enabled = False
    chkExtrudeFeatures.Value = vbUnchecked
    frmExporttoKMLOptions.lblOffsetAttribute.Enabled = False
    frmExporttoKMLOptions.cboOffsetAttribute.Enabled = False
    If frmExporttoKMLOptions.cboOffsetAttribute.ListCount > 0 Then
      frmExporttoKMLOptions.cboOffsetAttribute.ListIndex = 0
    End If
    frmExporttoKMLOptions.lblOffsetManual.Enabled = False
    frmExporttoKMLOptions.txtOffsetManual.Enabled = False
    frmExporttoKMLOptions.txtOffsetManual.Text = "0"
    frmExporttoKMLOptions.optAMClamped.Enabled = True
    frmExporttoKMLOptions.optAMRelative.Enabled = False
    frmExporttoKMLOptions.optAMAbsolute.Enabled = False
    frmExporttoKMLOptions.optAMClamped.Value = True
  End If
End Sub

Private Sub cboInputLayer_Click()
  ' Get ahold of the specified map layer
  Dim pEnumLayers As esricarto.IEnumLayer
  Dim pLayer As esricarto.ILayer
  Set pEnumLayers = m_pMap.Layers
  pEnumLayers.Reset
  Set pLayer = pEnumLayers.Next
  Do Until pLayer.Name = cboInputLayer.Text
    Set pLayer = pEnumLayers.Next
  Loop
  Set g_pInputLayer = pLayer
  
  ' get the attributes of the specified layer
  Dim pFeatureLayer As esricarto.IFeatureLayer
  Dim pFeatureClass As esriGeoDatabase.IFeatureClass
  Set pFeatureLayer = pLayer
  Set pFeatureClass = pFeatureLayer.FeatureClass
  
  ' get the database fields from the featureclass
  Set m_pDBFields = pFeatureClass.Fields

  ' determine the spatial reference of the input layer
  Dim pGeodataset As esriGeoDatabase.IGeoDataset
  Dim boolIsSpatialRef As Boolean
  Set pGeodataset = pFeatureLayer
  Set m_pSpRefInput = pGeodataset.SpatialReference
  boolIsSpatialRef = True
  If m_pSpRefInput Is Nothing Then
    boolIsSpatialRef = False
  ElseIf Trim(UCase(m_pSpRefInput.Name)) = "UNKNOWN" Then
    boolIsSpatialRef = False
  End If
  If boolIsSpatialRef = False Then
    lblBogusLayer.Caption = "!! ERROR -- the layer has no defined projection !!"
    chkUseLayerSymbology.Visible = False
    lblBogusLayer.Visible = True
    cboLabelAttribute.SetFocus
    MsgBox "The layer must have a defined spatial reference before it can be " _
    & "exported to KML. Please define a coordinate system for " & UCase(pFeatureLayer.Name) & "." _
    , vbCritical, "Export to Google Earth KML"
    cmdOK.Enabled = False
  Else
    lblBogusLayer.Visible = False
    chkUseLayerSymbology.Visible = True
    cmdOK.Enabled = True
  End If
  
  ' set the default output location using the MXD location
  Dim strAppPath As String
  strAppPath = CurrentDirectory(m_pApplication, False)
  txtOutputKML.Text = strAppPath & Replace(pLayer.Name, ":", ";") & ".kml"
  
  ' determine whether layer has Z values (i.e., 3D shapefile)
  Dim lngGeomIndex As Long
  Dim strShapeFieldName As String
  Dim pField As esriGeoDatabase.IField
  Dim pGeometry2Def As esriGeoDatabase.IGeometryDef
  Dim boolHasZValues As Boolean
  strShapeFieldName = pFeatureClass.ShapeFieldName
  lngGeomIndex = m_pDBFields.FindField(strShapeFieldName)
  Set pField = m_pDBFields.Field(lngGeomIndex)
  Set pGeometry2Def = pField.GeometryDef
  boolHasZValues = pGeometry2Def.HasZ
  
  ' loop through attribute list and add to main form attribute-based combo boxes
  Dim intField As Integer
  cboLabelAttribute.Clear
  cboHeightAttribute.Clear
  For intField = 0 To m_pDBFields.FieldCount - 1
    If m_pDBFields.Field(intField).Name <> strShapeFieldName And m_pDBFields.Field(intField).Type < 7 Then
      cboLabelAttribute.AddItem m_pDBFields.Field(intField).AliasName
      If m_pDBFields.Field(intField).Type = esriFieldTypeDouble Or _
      m_pDBFields.Field(intField).Type = esriFieldTypeInteger Or _
      m_pDBFields.Field(intField).Type = esriFieldTypeSingle Or _
      m_pDBFields.Field(intField).Type = esriFieldTypeSmallInteger Then
        cboHeightAttribute.AddItem m_pDBFields.Field(intField).AliasName
      End If
    End If
  Next intField
  
  ' add remaining items to main form combo boxes
  cboLabelAttribute.AddItem "<NONE>", 0
  cboLabelAttribute.ListIndex = 0
  cboHeightAttribute.AddItem "<NONE>", 0
  If boolHasZValues = True Then
    cboHeightAttribute.AddItem "--Use feature Z values--", 1
    cboHeightAttribute.ListIndex = 1
  Else
    cboHeightAttribute.ListIndex = 0
  End If
  
  ' loop through attribute list and add to options form attribute-based combo boxes
  g_boolFeatureNameAttributeManuallySet = False
  frmExporttoKMLOptions.cboFeatureNameAttribute.Clear
  frmExporttoKMLOptions.lstSnippetAttributes.Clear
  frmExporttoKMLOptions.lstDescriptionAttributes.Clear
  frmExporttoKMLOptions.lstTableAttributesMaster.Clear
  frmExporttoKMLOptions.cboOffsetAttribute.Clear
  frmExporttoKMLOptions.txtFeatureSnippet = ""
  frmExporttoKMLOptions.txtFeatureDescription = ""
  frmExporttoKMLOptions.cboStartTime.Clear
  frmExporttoKMLOptions.cboEndTime.Clear
  frmExporttoKMLOptions.cmdAddAllAttributes.Enabled = True
  strShapeFieldName = pFeatureClass.ShapeFieldName
  For intField = 0 To m_pDBFields.FieldCount - 1
    If m_pDBFields.Field(intField).Name <> strShapeFieldName And m_pDBFields.Field(intField).Type < 7 Then
      ' populate attribute combo and list boxes
      frmExporttoKMLOptions.cboFeatureNameAttribute.AddItem m_pDBFields.Field(intField).AliasName
      frmExporttoKMLOptions.lstSnippetAttributes.AddItem m_pDBFields.Field(intField).AliasName
      frmExporttoKMLOptions.lstDescriptionAttributes.AddItem m_pDBFields.Field(intField).AliasName
      frmExporttoKMLOptions.lstTableAttributesMaster.AddItem m_pDBFields.Field(intField).AliasName
      frmExporttoKMLOptions.cboStartTime.AddItem m_pDBFields.Field(intField).AliasName
      frmExporttoKMLOptions.cboEndTime.AddItem m_pDBFields.Field(intField).AliasName
      
      ' populate numeric attributes
      If m_pDBFields.Field(intField).Type = esriFieldTypeDouble Or _
      m_pDBFields.Field(intField).Type = esriFieldTypeInteger Or _
      m_pDBFields.Field(intField).Type = esriFieldTypeSingle Or _
      m_pDBFields.Field(intField).Type = esriFieldTypeSmallInteger Then
        frmExporttoKMLOptions.cboOffsetAttribute.AddItem m_pDBFields.Field(intField).AliasName
      End If
    End If
  Next intField
  
  ' add remaining items to option form combo boxes
  frmExporttoKMLOptions.cboFeatureNameAttribute.AddItem "<NONE>", 0
  frmExporttoKMLOptions.cboFeatureNameAttribute.ListIndex = 0
  frmExporttoKMLOptions.cboOffsetAttribute.AddItem "<NONE>", 0
  frmExporttoKMLOptions.cboOffsetAttribute.ListIndex = 0
  frmExporttoKMLOptions.cboStartTime.AddItem "<NONE>", 0
  frmExporttoKMLOptions.cboStartTime.ListIndex = 0
  frmExporttoKMLOptions.cboEndTime.AddItem "<NONE>", 0
  frmExporttoKMLOptions.cboEndTime.ListIndex = 0
  
  ' set default KML export options
  Dim strKMLName As String
  strKMLName = Right(txtOutputKML.Text, Len(txtOutputKML.Text) - InStrRev(txtOutputKML.Text, "\"))
  strKMLName = Left(strKMLName, InStrRev(strKMLName, ".kml") - 1)
  frmExporttoKMLOptions.txtKMLLayerName = strKMLName
  frmExporttoKMLOptions.txtKMLLayerDescription = "Exported from " & pFeatureLayer.Name & " on " & CStr(Date)
  frmExporttoKMLOptions.chkExportSeparateLabels.Value = vbChecked
  frmExporttoKMLOptions.chkFormatDateTime.Value = vbChecked
      
  ' set the output KML transparency
  Dim pLayerEffects As esricarto.ILayerEffects
  frmExporttoKMLOptions.txtOutputTransparency = "0"
  If chkUseLayerSymbology.Value = vbChecked Then
    Set pLayerEffects = pFeatureLayer  'QI
    If pLayerEffects.SupportsTransparency = True Then
      frmExporttoKMLOptions.txtOutputTransparency = CStr(pLayerEffects.Transparency)
    End If
  End If
  
  ' disable "selected features" option if nothing is selected
  Dim pFSelection As esricarto.IFeatureSelection
  Set pFSelection = pFeatureLayer   'QI
  If pFSelection.SelectionSet.Count > 0 Then
    frmExporttoKMLOptions.chkExportSelected.Value = vbChecked
    frmExporttoKMLOptions.chkExportSelected.Enabled = True
  Else
    frmExporttoKMLOptions.chkExportSelected.Value = vbUnchecked
    frmExporttoKMLOptions.chkExportSelected.Enabled = False
  End If
  
  ' set the "manual shift" units
  Dim pGCS As esriGeometry.IGeographicCoordinateSystem
  Dim pPCS As esriGeometry.IProjectedCoordinateSystem
  Dim strUnitName As String
  If TypeOf m_pSpRefInput Is esriGeometry.IGeographicCoordinateSystem Then
    Set pGCS = m_pSpRefInput
    strUnitName = pGCS.CoordinateUnit.Name
  ElseIf TypeOf m_pSpRefInput Is esriGeometry.IProjectedCoordinateSystem Then
    Set pPCS = m_pSpRefInput
    strUnitName = pPCS.CoordinateUnit.Name
  Else
    strUnitName = "unknown units"
  End If
  If VBA.UCase(strUnitName) = "FOOT" Then
    frmExporttoKMLOptions.lbShiftUnits.Caption = "feet"
  Else
    frmExporttoKMLOptions.lbShiftUnits.Caption = VBA.LCase(strUnitName) & "s"
  End If
  
  ' SET THE SYMBOL RENDERER BASED ON TYPE AND DETERMINE THE LAYER SYMBOLOGY FIELD
  Dim pGFlayer As esricarto.IGeoFeatureLayer
  Set pGFlayer = g_pInputLayer  'QI
  Set m_pGFLayerRenderer = pGFlayer.Renderer
  Dim pLegendInfo As esricarto.ILegendInfo
  
  ' handle unique value renderers (limited to one field)
  If TypeOf m_pGFLayerRenderer Is esricarto.IUniqueValueRenderer Then
    Set m_pUniqueValueRenderer = m_pGFLayerRenderer  'QI
    If m_pUniqueValueRenderer.FieldCount > 1 Then
      Set m_pGFLayerRenderer = Nothing
      Set m_pUniqueValueRenderer = Nothing
    Else
      Set g_pLayerSymbolField = m_pDBFields.Field(m_pDBFields.FindField(m_pUniqueValueRenderer.Field(0)))
    End If
    
  ' handle class breaks renderers (normalization is not allowed)
  ElseIf TypeOf m_pGFLayerRenderer Is esricarto.IClassBreaksRenderer Then
    Set m_pClassBreaksRenderer = m_pGFLayerRenderer  'QI
    If Trim(m_pClassBreaksRenderer.NormField) <> "" Then
      Set m_pGFLayerRenderer = Nothing
      Set m_pClassBreaksRenderer = Nothing
    Else
      Set g_pLayerSymbolField = m_pDBFields.Field(m_pDBFields.FindField(m_pClassBreaksRenderer.Field))
      ' determine whether breaks are ascending
      If m_pClassBreaksRenderer.Break(0) < m_pClassBreaksRenderer.Break(m_pClassBreaksRenderer.BreakCount - 1) Then
        m_boolClassBreaksAscending = True
      Else
        m_boolClassBreaksAscending = False
      End If
    End If
  
  ' handle simple renderers
  ElseIf TypeOf m_pGFLayerRenderer Is esricarto.ISimpleRenderer Then
    Set m_pSimpleRenderer = m_pGFLayerRenderer  'QI
    Set g_pLayerSymbolField = Nothing
  Else
    Set m_pGFLayerRenderer = Nothing
  End If
  
  ' get the heading from the renderer
  If Not m_pGFLayerRenderer Is Nothing Then
    Set pLegendInfo = m_pGFLayerRenderer  'QI
    m_strLayerRendererHeading = pLegendInfo.LegendGroup(pLegendInfo.LegendGroupCount - 1).Heading
  End If
  
  ' enable/disable ability to use layer symbology
  If Not m_pGFLayerRenderer Is Nothing Then
    chkUseLayerSymbology.Enabled = True
    If chkUseLayerSymbology.Value = vbChecked Then
      ' loop through and set label and feature name fields
      For m_lngCount = 0 To cboLabelAttribute.ListCount - 1
        If Not g_pLayerSymbolField Is Nothing Then
          If cboLabelAttribute.List(m_lngCount) = g_pLayerSymbolField.AliasName Then
            cboLabelAttribute.ListIndex = m_lngCount
          End If
          If frmExporttoKMLOptions.cboFeatureNameAttribute.List(m_lngCount) = g_pLayerSymbolField.AliasName Then
            frmExporttoKMLOptions.cboFeatureNameAttribute.ListIndex = m_lngCount
          End If
        End If
      Next m_lngCount
    End If
  Else
    chkUseLayerSymbology.Enabled = False
    chkUseLayerSymbology.Value = vbUnchecked
  End If
  
  ' enable options button
  cmdMoreOptions.Enabled = True
  'frmExporttoKMLOptions.tabExportOptions.Tab = 0  'VB
  
  ' enable browse button
  cmdBrowsetoOutput.Enabled = True
End Sub

Private Sub cboLabelAttribute_Click()
  ' use label field for feature names if labels are included with point features
  If g_boolExportSeparateLabels = False Then
    For m_lngCount = 0 To frmExporttoKMLOptions.cboFeatureNameAttribute.ListCount - 1
      If frmExporttoKMLOptions.cboFeatureNameAttribute.List(m_lngCount) = cboLabelAttribute.Text Then
        frmExporttoKMLOptions.cboFeatureNameAttribute.ListIndex = m_lngCount
      End If
    Next m_lngCount
  End If
  
  ' set feature name attribute to be the same as the label attribute (if not grouping)
  If g_boolFeatureNameAttributeManuallySet = False Then
    If chkUseLayerSymbology.Value = vbUnchecked Or g_pLayerSymbolField Is Nothing Then
      For m_lngCount = 0 To frmExporttoKMLOptions.cboFeatureNameAttribute.ListCount - 1
        If frmExporttoKMLOptions.cboFeatureNameAttribute.List(m_lngCount) = cboLabelAttribute.Text Then
          frmExporttoKMLOptions.cboFeatureNameAttribute.ListIndex = m_lngCount
        End If
      Next m_lngCount
    End If
  End If
  
  ' enable/disable offsetting
  If Trim(cboLabelAttribute.Text) <> "<NONE>" Then
    frmExporttoKMLOptions.lblLabelOffsetManual.Enabled = True
    frmExporttoKMLOptions.txtLabelOffsetManual.Enabled = True
  Else
    frmExporttoKMLOptions.txtLabelOffsetManual.Text = "0"
    frmExporttoKMLOptions.lblLabelOffsetManual.Enabled = False
    frmExporttoKMLOptions.txtLabelOffsetManual.Enabled = False
  End If
End Sub

Private Sub cmdBrowsetoOutput_Click()
  ' populate text box with output file name
  Dim strKMLFile As String
  strKMLFile = BrowsetoFile("kml", "Google Earth Keyhole Markup Language file", False)
  If VBA.Trim(strKMLFile) <> "" Then
    txtOutputKML.Text = strKMLFile
  End If
End Sub

Private Sub cmdCancel_Click()
  frmExporttoKML.Application = Nothing
  Unload frmExporttoKMLOptions
  Unload Me
End Sub

Private Sub cmdMoreOptions_Click()
  frmExporttoKMLOptions.Show vbModal
End Sub

Private Sub cmdOK_Click()
  ' make sure all required information has been filled in
  If cboInputLayer.Text = "" Or txtOutputKML.Text = "" Then
    MsgBox "Please fill in all required parameters.", vbExclamation, "Export to Google Earth KML"
    Exit Sub
  End If
  
  ' make sure the selected layer has features
  Dim pFLayer As esricarto.IFeatureLayer2
  Dim pFeatureClass As esriGeoDatabase.IFeatureClass
  Set pFLayer = g_pInputLayer
  Set pFeatureClass = pFLayer.FeatureClass
  If pFeatureClass.FeatureCount(Nothing) < 1 Then
    MsgBox "There are no features in the specified layer. Please select a layer with" _
    & " at least one feature.", vbExclamation, "Export to Google Earth KML"
    Exit Sub
  End If
  
  ' call exporting sub
  ExporttoKML pFLayer
  
  ' unload forms
  frmExporttoKML.Application = Nothing
  Unload frmExporttoKMLOptions
  Unload Me
End Sub

Public Sub ExporttoKML(aFeatureLayer As esricarto.IFeatureLayer)
  ' set layer objects
  Dim pFLayer As esricarto.IFeatureLayer
  Dim pFClass As esriGeoDatabase.IFeatureClass
  Set pFLayer = aFeatureLayer
  Set pFClass = pFLayer.FeatureClass

  ' get the defined selection set
  Dim pFLDef As esricarto.IFeatureLayerDefinition
  Dim pSelectionSet As esriGeoDatabase.ISelectionSet
  Set pFLDef = pFLayer 'QI
  If Not pFLDef.DefinitionSelectionSet Is Nothing Then
    Set pSelectionSet = pFLDef.DefinitionSelectionSet
  End If
  
  ' get the definition query
  Dim strDefintionQuery As String
  Dim pQueryFilter As esriGeoDatabase.IQueryFilter
  strDefintionQuery = pFLDef.DefinitionExpression
  Set pQueryFilter = New QueryFilter
  pQueryFilter.WhereClause = strDefintionQuery
  
  ' get the selection set
  Dim pFSelection As esricarto.IFeatureSelection
  Set pFSelection = pFLayer  'QI
  If pFSelection.SelectionSet.Count > 0 Or pSelectionSet Is Nothing Then
    Set pSelectionSet = pFSelection.SelectionSet
  End If
  
  ' set the spatial reference of output KML data
  Dim pSpRFc As esriGeometry.SpatialReferenceEnvironment
  Dim pGCS As esriGeometry.IGeographicCoordinateSystem
  Set pSpRFc = New esriGeometry.SpatialReferenceEnvironment
  Set pGCS = pSpRFc.CreateGeographicCoordinateSystem(esriSRGeoCS_WGS1984)
  Set m_pSpRefOutput = pGCS
  m_pSpRefOutput.SetFalseOriginAndUnits -180, -90, 1000000
  
  ' compare with spatial reference of the input layer
  Dim pInputSRClone As esriSystem.IClone
  Dim pOutputSRClone As esriSystem.IClone
  Dim m_boolSpRefEqual As Boolean
  Set pInputSRClone = m_pSpRefInput
  Set pOutputSRClone = m_pSpRefOutput
  m_boolSpRefEqual = pInputSRClone.IsEqual(pOutputSRClone)
  
  ' determine the geographic transformation to apply if necessary
  Dim pGeoTransformation As esriGeometry.IGeoTransformation
  Dim GTCollection As New Collection
  g_strGCSTransformation = ""
  m_boolPerformGCSTransform = False
  If m_boolSpRefEqual = False And Not m_pSpRefInput.Name Like "*1983*" Then  'WGS84/NAD83 coordinate systems are esentially equivalent
    BusyMouse True
    Set GTCollection = GetGCTransformations(m_pSpRefInput, m_pSpRefOutput)
    If GTCollection.Count > 0 Then
      frmExporttoKMLGCSTrans.cboGCSTransformation.Clear
      frmExporttoKMLGCSTrans.txtFromSR.Text = m_pSpRefInput.Name
      frmExporttoKMLGCSTrans.txtToSR.Text = m_pSpRefOutput.Name
      For m_lngCount = 1 To GTCollection.Count
        Set pGeoTransformation = GTCollection.Item(m_lngCount)
        frmExporttoKMLGCSTrans.cboGCSTransformation.AddItem pGeoTransformation.Name
      Next m_lngCount
      frmExporttoKMLGCSTrans.cboGCSTransformation.AddItem "<NONE>", 0
      frmExporttoKMLGCSTrans.cboGCSTransformation.ListIndex = 0
      frmExporttoKMLGCSTrans.Show vbModal
      If g_strGCSTransformation <> "" Then
        For m_lngCount = 1 To GTCollection.Count
          Set pGeoTransformation = GTCollection.Item(m_lngCount)
          If pGeoTransformation.Name = g_strGCSTransformation Then
            Set m_pOutputGeoTransformation = pGeoTransformation
            m_boolPerformGCSTransform = True
          End If
        Next m_lngCount
      End If
      Unload frmExporttoKMLGCSTrans
    End If
  End If
  
  ' determine whether output KML features are labeled
  If cboLabelAttribute.Text <> "<NONE>" Then
    m_boolLabelFeatures = True
  Else
    m_boolLabelFeatures = False
  End If
  
  ' set unit conversion (from feet/meters)
  If optHeightinFeet.Value = True Then
    m_sglUnitConversion = 0.3048
  Else
    m_sglUnitConversion = 1
  End If
  
  ' determine if and how features will be extruded
  If Trim(cboHeightAttribute.Text) = "<NONE>" Then
    m_intExtrusion = 0
    m_boolIs3DShape = False
    m_boolIs3DAttribute = False
  Else
    
    ' determine whether to use feature Z values or attribute for base heights
    If Trim(cboHeightAttribute.Text) = "--Use feature Z values--" Then
      m_boolIs3DShape = True
      m_boolIs3DAttribute = False
    Else
      m_boolIs3DShape = False
      m_boolIs3DAttribute = True
    End If
    
    ' set feature extrusion option
    If chkExtrudeFeatures.Value = vbChecked Then
      m_intExtrusion = 1
    Else
      m_intExtrusion = 0
    End If
  End If
  
  ' set the altitude mode for exported features
  If m_boolIs3DShape = True Or m_boolIs3DAttribute = True Then
    If frmExporttoKMLOptions.optAMRelative.Value = True Then
      m_strAltitudeMode = "relativeToGround"
      m_intTessellate = 0
    Else
      m_strAltitudeMode = "absolute"
      m_intTessellate = 0
    End If
  Else
    m_strAltitudeMode = "clampedToGround"
    m_intTessellate = 1
  End If
  
  ' set the altitude mode for labels
  If m_boolIs3DShape = True Or m_boolIs3DAttribute = True Or CDbl(frmExporttoKMLOptions.txtLabelOffsetManual) > 0 Then
    m_strAltitudeModeLabels = "relativeToGround"
    m_intLabelExtrusion = 1
  Else
    m_strAltitudeModeLabels = "clampedToGround"
    m_intLabelExtrusion = 0
  End If
  
  ' set the altitude mode for information points
  If m_boolIs3DShape = True Or m_boolIs3DAttribute = True Or CDbl(frmExporttoKMLOptions.txtInfoPtOffsetManual) > 0 Then
    m_strAltitudeModeInfoPts = "relativeToGround"
    m_intInfoPtExtrusion = 1
  Else
    m_strAltitudeModeInfoPts = "clampedToGround"
    m_intInfoPtExtrusion = 0
  End If
  
  ' get the name of the output KML layer
  Dim strKMLName As String
  strKMLName = Right(txtOutputKML.Text, Len(txtOutputKML.Text) - InStrRev(txtOutputKML.Text, "\"))
  strKMLName = Left(strKMLName, InStrRev(strKMLName, ".kml") - 1)
  
  ' determine whether output KML will be Google Maps compatible
  If frmExporttoKMLOptions.chkGoogleMapsKML.Value = vbChecked Then
    m_boolGoogleMapsCompatible = True
  Else
    m_boolGoogleMapsCompatible = False
  End If
  
  ' determine whether output KML schema will use "typed" data elements
  If frmExporttoKMLOptions.chkUseUnTypedData.Value = vbChecked Then
    m_boolUseUnTypedData = True
  Else
    m_boolUseUnTypedData = False
  End If
  
  ' initialize progress bar
  Dim lngNumbFeatures As Long
  Set m_pStatusBar = m_pApplication.StatusBar
  Set m_pProgressBar = m_pStatusBar.ProgressBar
  If frmExporttoKMLOptions.chkExportSelected = vbChecked And pSelectionSet.Count > 0 Then
    lngNumbFeatures = pSelectionSet.Count
  Else
    lngNumbFeatures = pFClass.FeatureCount(pQueryFilter)
  End If
  m_pProgressBar.Position = 0
  m_pStatusBar.ShowProgressBar "Exporting " & CStr(lngNumbFeatures) & " features from " _
  & pFLayer.Name & " to KML...", 0, lngNumbFeatures, 1, True
  
  ' intitialize random number generator
  Randomize
 
  ' create text file for KML output
  Open txtOutputKML.Text For Output As #1
  
  ' write out general KML header
  Dim intSnippetLines As Integer
  Print #1, "<?xml version=""1.0"" encoding=""UTF-8""?>"
  Print #1, "<kml xmlns=""http://www.opengis.net/kml/2.2"" xmlns:gx=""http://www.google.com/kml/ext/2.2"" xmlns:kml=""http://www.opengis.net/kml/2.2"" xmlns:atom=""http://www.w3.org/2005/Atom"">"
  Print #1, "<Document>"
  If Trim(frmExporttoKMLOptions.txtKMLLayerName.Text) <> "" Then
    Print #1, "  <name>" & CleanXMLString(frmExporttoKMLOptions.txtKMLLayerName.Text, True) & "</name>"
  Else
    Print #1, "  <name>" & CleanXMLString(strKMLName, True) & "</name>"
  End If
  Print #1, "  <open>1</open>"
  intSnippetLines = VBA.Round(VBA.Len(frmExporttoKMLOptions.txtKMLLayerSnippet.Text) / 30)
  Print #1, "  <Snippet maxLines=""" & intSnippetLines & """>" & CleanXMLString(frmExporttoKMLOptions.txtKMLLayerSnippet.Text, True) & "</Snippet>"
  Print #1, "  <description>" & CleanXMLString(frmExporttoKMLOptions.txtKMLLayerDescription.Text, True) & "</description>"
  If frmExporttoKMLOptions.chkIncludeLayerNameInDesc <> vbChecked And m_boolGoogleMapsCompatible = False Then
    Print #1, "  <styleUrl>#clean_balloon</styleUrl>"
    Print #1, "  <Style id=""clean_balloon"">"
    Print #1, "    <BalloonStyle>"
    Print #1, "      <text>$[description]</text>"
    Print #1, "    </BalloonStyle>"
    Print #1, "  </Style>"
  End If
  
  ' WRITE OUT BALANCE OF KML BASED ON FEATURE TYPE
  ' dimension variables for storing features and feature info
  Dim pFeatureCursor As esriGeoDatabase.IFeatureCursor
  Dim pLabelCursor As esriGeoDatabase.IFeatureCursor
  Dim pInfoPtCursor As esriGeoDatabase.IFeatureCursor
  Dim pFeature As esriGeoDatabase.IFeature
  Dim pField As esriGeoDatabase.IField
  Dim intFieldIndex As Integer
  Dim strFieldType As String
  Dim boolNoGeometry As Boolean
  Dim lngGeomNum As Long
  
  ' dimension variables for storing geometry
  Dim pGeometry2 As esriGeometry.IGeometry2
  Dim pTransform2D As esriGeometry.ITransform2D
  Dim pGeomCollection As esriGeometry.IGeometryCollection
  Dim pSegmentCollection As esriGeometry.ISegmentCollection
  Dim pPoint As esriGeometry.IPoint
  Dim pLabelPoint As esriGeometry.IPoint
  
  ' dimension variables for storing polygon ring info
  Dim pPolygon As esriGeometry.IPolygon4
  Dim pExtRings() As esriGeometry.IRing
  Dim pIntRings() As esriGeometry.IRing
  Dim boolIsOuterRing As Boolean
  Dim lngExtRing As Long
  Dim lngIntRing As Long
  
  ' dimension variables for dealing extracting unique values
  Dim pEnumUniqueStyles As esriSystem.IEnumVariantSimple
  Dim pTableSort As esriGeoDatabase.ITableSort
  Dim pTable As esriGeoDatabase.ITable
  Dim pNameField As esriGeoDatabase.IField
  Dim pLabelField As esriGeoDatabase.IField
  Dim strSortField1 As String
  Dim strSortField2 As String
  
  ' set the output KML transparency
  If IsNumeric(frmExporttoKMLOptions.txtOutputTransparency.Text) = False Then
    frmExporttoKMLOptions.txtOutputTransparency.Text = "0"
  Else
    If CSng(frmExporttoKMLOptions.txtOutputTransparency.Text) < 0 Then
      frmExporttoKMLOptions.txtOutputTransparency.Text = "0"
    ElseIf CSng(frmExporttoKMLOptions.txtOutputTransparency.Text) > 100 Then
      frmExporttoKMLOptions.txtOutputTransparency.Text = "100"
    End If
  End If
  m_strTransparency = CStr(Hex(((100 - CSng(frmExporttoKMLOptions.txtOutputTransparency.Text)) / 100) * 255))
  
  ' determine whether time information is being added
  If Trim(frmExporttoKMLOptions.cboStartTime.Text) <> "<NONE>" Or _
  Trim(frmExporttoKMLOptions.cboEndTime.Text) <> "<NONE>" Then
    m_boolAddTimeStamps = True
  Else
    m_boolAddTimeStamps = False
  End If
  
  ' determine whether features are being grouped
  If Not g_pLayerSymbolField Is Nothing And chkUseLayerSymbology.Value <> vbUnchecked Then
    m_boolUseArcMapSymbology = True
  Else
    m_boolUseArcMapSymbology = False
  End If
  
  ' if features are being grouped, define the KML styles
  If m_boolUseArcMapSymbology = True Then
    ReDim m_strKMLStyles(0)
    
    ' if using a unique values renderer
    If TypeOf m_pGFLayerRenderer Is esricarto.IUniqueValueRenderer Then
      
      ' get the style names from the renderer
      For m_lngCount = 0 To m_pUniqueValueRenderer.ValueCount - 1
        ReDim Preserve m_strKMLStyles(m_lngCount)
        m_strKMLStyles(m_lngCount) = m_pUniqueValueRenderer.Value(m_lngCount)
      Next m_lngCount
      
      '  get the default stlye name if it's being used
      If m_pUniqueValueRenderer.UseDefaultSymbol = True Then
        If UBound(m_strKMLStyles) > 0 Then
          ReDim Preserve m_strKMLStyles(UBound(m_strKMLStyles) + 1)
        End If
        m_strKMLStyles(UBound(m_strKMLStyles)) = m_pUniqueValueRenderer.DefaultLabel
      End If

    ' if using a class breaks renderer
    ElseIf TypeOf m_pGFLayerRenderer Is esricarto.IClassBreaksRenderer Then
      ' get the style names from the renderer
      For m_lngCount = 0 To m_pClassBreaksRenderer.BreakCount - 1
        ReDim Preserve m_strKMLStyles(m_lngCount)
        m_strKMLStyles(m_lngCount) = m_pClassBreaksRenderer.Break(m_lngCount)
      Next m_lngCount
    End If
    
  Else
    ' features not being grouped; dump all features into feature and label cursors
    ReDim m_strKMLStyles(0)
    m_strKMLStyles(0) = "FEATURES"
  End If
  
  ' determine the attribute to use for sorting feature folders and names
  If frmExporttoKMLOptions.cboFeatureNameAttribute.Text <> "<NONE>" Then
    Set pNameField = m_pDBFields.Field(m_pDBFields.FindFieldByAliasName(frmExporttoKMLOptions.cboFeatureNameAttribute.Text))
  End If
  If m_boolLabelFeatures = True Then
    Set pLabelField = m_pDBFields.Field(m_pDBFields.FindFieldByAliasName(cboLabelAttribute.Text))
  End If
  
  ' assign sorting order of attributes
  strSortField1 = ""
  strSortField2 = ""
  If m_boolUseArcMapSymbology = True Then
    strSortField1 = g_pLayerSymbolField.Name
    If Not pNameField Is Nothing Then
      If pNameField.Name <> strSortField1 Then
        strSortField2 = pNameField.Name
      ElseIf Not pLabelField Is Nothing Then
        If pLabelField.Name <> strSortField1 Then
          strSortField2 = pLabelField.Name
        End If
      End If
    ElseIf Not pLabelField Is Nothing Then
      If pLabelField.Name <> strSortField1 Then
        strSortField2 = pLabelField.Name
      End If
    End If
  ElseIf Not pNameField Is Nothing Then
    strSortField1 = pNameField.Name
    If Not pLabelField Is Nothing Then
      If pLabelField.Name <> strSortField1 Then
        strSortField2 = pLabelField.Name
      End If
    End If
  ElseIf Not pLabelField Is Nothing Then
    strSortField1 = pLabelField.Name
  End If
  
  ' sort features based on group, name, and labels
  If strSortField1 <> "" Then
    ' sort on the group and label attributes
    Set pTable = pFClass
    Set pTableSort = New esriGeoDatabase.TableSort
    If strSortField2 <> "" Then
      pTableSort.Fields = strSortField1 & "," & strSortField2
      pTableSort.Ascending(strSortField1) = True
      pTableSort.Ascending(strSortField2) = True
    Else
      pTableSort.Fields = strSortField1
      pTableSort.Ascending(strSortField1) = True
    End If
    
    ' get records to sort
    Set pTableSort.QueryFilter = pQueryFilter
    If frmExporttoKMLOptions.chkExportSelected = vbChecked And _
    pSelectionSet.Count > 0 Then
      Set pTableSort.SelectionSet = pSelectionSet
    Else
      Set pTableSort.Table = pTable
    End If
    pTableSort.Sort Nothing
    
    ' dump sorted features from the layer into feature and label cursors
    Set pFeatureCursor = pTableSort.Rows
    Set pLabelCursor = pTableSort.Rows
    Set pInfoPtCursor = pTableSort.Rows
    
  Else
    ' dump all features unsorted to cursors
    If frmExporttoKMLOptions.chkExportSelected = vbChecked And _
    pSelectionSet.Count > 0 Then
      pSelectionSet.Search pQueryFilter, False, pFeatureCursor
      pSelectionSet.Search pQueryFilter, False, pLabelCursor
      pSelectionSet.Search pQueryFilter, False, pInfoPtCursor
    Else
      Set pFeatureCursor = pFClass.Search(pQueryFilter, False)
      Set pLabelCursor = pFClass.Search(pQueryFilter, False)
      Set pInfoPtCursor = pFClass.Search(pQueryFilter, False)
    End If
  End If
      
  ' get the first feature from the cursor
  Set pFeature = pFeatureCursor.NextFeature
  m_lngFeatCount = 1
  ReDim m_strLabelStyleNames(0)
  ReDim m_strLabelNames(0)
  ReDim m_strFeatureNames(0)
  ReDim m_strLabelXYZs(0)
  ReDim m_strInfoPointXYZs(0)
  ReDim m_strStartTimes(0)
  ReDim m_strEndTimes(0)
  boolNoGeometry = True
  
  ' set the database schema name
  Dim strSchemaDelimiter As String
  If m_boolUseUnTypedData = True Then
    m_strKMLSchemaName = ""
    strSchemaDelimiter = ""
  Else
    m_strKMLSchemaName = VBA.Replace(frmExporttoKMLOptions.txtKMLLayerName.Text, " ", "_")
    strSchemaDelimiter = "/"
  End If
  
  ' build the feature snippet and add any fields to the export schema if necessary
  intSnippetLines = VBA.Round(VBA.Len(frmExporttoKMLOptions.txtFeatureSnippet.Text) / 20)
  m_strFeatureSnippet = ""
  If Trim(frmExporttoKMLOptions.txtFeatureSnippet) <> "" Then
    m_strFeatureSnippet = frmExporttoKMLOptions.txtFeatureSnippet.Text
    For m_lngCount = 0 To m_pDBFields.FieldCount - 1
      If InStr(" " & m_strFeatureSnippet, "[" & m_pDBFields.Field(m_lngCount).AliasName & "]") > 0 Then
        m_strFeatureSnippet = Replace(m_strFeatureSnippet, "[" & m_pDBFields.Field(m_lngCount).AliasName & "]", _
            "$[" & m_strKMLSchemaName & strSchemaDelimiter & m_pDBFields.Field(m_lngCount).Name & "]")
        AddItemtoExportSchema m_pDBFields.Field(m_lngCount).AliasName
      ElseIf InStr(" " & m_strFeatureSnippet, "[" & m_pDBFields.Field(m_lngCount).Name & "]") > 0 Then
        m_strFeatureSnippet = Replace(m_strFeatureSnippet, "[" & m_pDBFields.Field(m_lngCount).Name & "]", _
            "$[" & m_strKMLSchemaName & strSchemaDelimiter & m_pDBFields.Field(m_lngCount).Name & "]")
        AddItemtoExportSchema m_pDBFields.Field(m_lngCount).AliasName
      End If
    Next m_lngCount
  End If
  m_strFeatureSnippet = CleanXMLString(m_strFeatureSnippet, True)
 
  ' build the feature description and add any fields to the export schema if necessary
  m_strFeatureDescription = ""
  If Trim(frmExporttoKMLOptions.txtFeatureDescription) <> "" Then
    m_strFeatureDescription = frmExporttoKMLOptions.txtFeatureDescription.Text
    For m_lngCount = 0 To m_pDBFields.FieldCount - 1
      If InStr(" " & m_strFeatureDescription, "[" & m_pDBFields.Field(m_lngCount).AliasName & "]") > 0 Then
        m_strFeatureDescription = Replace(m_strFeatureDescription, "[" & m_pDBFields.Field(m_lngCount).AliasName & "]", _
            "$[" & m_strKMLSchemaName & strSchemaDelimiter & m_pDBFields.Field(m_lngCount).Name & "]")
        AddItemtoExportSchema m_pDBFields.Field(m_lngCount).AliasName
      ElseIf InStr(" " & m_strFeatureDescription, "[" & m_pDBFields.Field(m_lngCount).Name & "]") > 0 Then
        m_strFeatureDescription = Replace(m_strFeatureDescription, "[" & m_pDBFields.Field(m_lngCount).Name & "]", _
            "$[" & m_strKMLSchemaName & strSchemaDelimiter & m_pDBFields.Field(m_lngCount).Name & "]")
        AddItemtoExportSchema m_pDBFields.Field(m_lngCount).AliasName
      End If
    Next m_lngCount
  End If
  
  ' write out the database schema (for typed data)
  If m_boolGoogleMapsCompatible = False Then
    If frmExporttoKMLOptions.chkExportSchema.Value = vbChecked And _
    frmExporttoKMLOptions.lstTableAttributesExport.ListCount > 0 Then
      m_intSchemaFieldCount = frmExporttoKMLOptions.lstTableAttributesExport.ListCount
      If m_boolUseUnTypedData = False Then
        Print #1, "  <Schema name=""" & m_strKMLSchemaName & """ id=""" & m_strKMLSchemaName & "_schema"">"
        For m_lngCount = 0 To frmExporttoKMLOptions.lstTableAttributesExport.ListCount - 1
          intFieldIndex = pFeature.Fields.FindFieldByAliasName(frmExporttoKMLOptions.lstTableAttributesExport.List(m_lngCount))
          Set pField = m_pDBFields.Field(intFieldIndex)
          If pField.Type = esriFieldTypeSmallInteger Then
            strFieldType = "short"
          ElseIf pField.Type = esriFieldTypeInteger Or pField.Type = esriFieldTypeOID Then
            strFieldType = "int"
          ElseIf pField.Type = esriFieldTypeSingle Then
            strFieldType = "float"
          ElseIf pField.Type = esriFieldTypeDouble Then
            strFieldType = "double"
          ElseIf pField.Type = esriFieldTypeString Or pField.Type = esriFieldTypeDate Then
            strFieldType = "string"
          End If
          Print #1, "    <SimpleField type=""" & strFieldType & """ name=""" & pField.Name & """>"
          Print #1, "      <displayName>" & CleanXMLString(pField.AliasName, True) & "</displayName>"
          Print #1, "    </SimpleField>"
        Next m_lngCount
        Print #1, "  </Schema>"
      End If
    End If
    ReDim m_strFeatureSchemas(m_intSchemaFieldCount, 0)
  End If
  
  ' WRITE OUT FEATURE STYLES
  If pFeature.Shape.GeometryType = esriGeometryPoint Then
    WriteoutFeatureStyles "POINT"
  ElseIf pFeature.Shape.GeometryType = esriGeometryPolyline Then
    WriteoutFeatureStyles "POLYLINE"
  ElseIf pFeature.Shape.GeometryType = esriGeometryPolygon Then
    WriteoutFeatureStyles "POLYGON"
  End If
  
  ' WRITE OUT FEATURES
  ' open the features folder
  Print #1, "  <Folder>"
  If Trim(m_strLayerRendererHeading) <> "" Then
    Print #1, "    <name>Features (" & m_strLayerRendererHeading & ")</name>"
  Else
    Print #1, "    <name>Features</name>"
  End If
  Print #1, "    <open>0</open>"
    
  ' POINT features ---------
  If pFeature.Shape.GeometryType = esriGeometryPoint Then
    
    ' loop through point features and write out feature KML tags
    Do While Not pFeature Is Nothing
      
      ' get the geometry from the feature
      Set pGeometry2 = pFeature.Shape
    
      ' manually shift the points (if necessary)
      If frmExporttoKMLOptions.txtXShift <> 0 Or frmExporttoKMLOptions.txtYShift <> 0 Then
        Set pTransform2D = pGeometry2  'QI
        pTransform2D.Move frmExporttoKMLOptions.txtXShift, frmExporttoKMLOptions.txtYShift
      End If
    
      ' project feature into latitude/longtitude if necessary
      If m_boolSpRefEqual = False Then
        Set pGeometry2.SpatialReference = m_pSpRefInput
        If m_boolPerformGCSTransform = True Then
          pGeometry2.ProjectEx m_pSpRefOutput, esriTransformReverse, m_pOutputGeoTransformation, False, 0, 0
        Else
          pGeometry2.Project m_pSpRefOutput
        End If
      End If
      
      ' determine whether labels are a separate point feature
      If m_boolLabelFeatures = True Then
        If frmExporttoKMLOptions.chkExportSeparateLabels = vbUnchecked Then
          m_boolLabelFeatures = False
        End If
      End If
      
      ' get the point
      Set pPoint = pGeometry2
      
      ' write out KML header for each group if the feature has geometry
      m_boolExporttheFeature = True
      If Not pGeometry2.IsEmpty = True Then
        boolNoGeometry = False
        WriteOutFeatures pFeature, m_lngFeatCount  'SUB
      Else
        m_boolExporttheFeature = False
      End If
      
      ' write out KML header for each point
      If m_boolExporttheFeature = True Then
        Print #1, "       <Placemark>"
        Print #1, "         <name>" & CleanXMLString(m_strFeatureName, True) & "</name>"
        Print #1, "         <Snippet maxLines=""" & intSnippetLines & """>" & m_strFeatureSnippet & "</Snippet>"
        Print #1, "         <styleUrl>#" & CleanXMLString(m_strStyleName, False) & "</styleUrl>"
        If m_boolGoogleMapsCompatible = True Then
          Print #1, "         <description>" & m_strFeatureDescription & "</description>"
        Else
          If m_intSchemaFieldCount > 0 Then
            Print #1, "         <ExtendedData>"
            If m_boolUseUnTypedData = True Then
              For m_lngCount = 1 To UBound(m_strFeatureSchema)
                Print #1, "           " & m_strFeatureSchema(m_lngCount)
              Next m_lngCount
            Else
              Print #1, "           <SchemaData schemaUrl=""#" & m_strKMLSchemaName & "_schema""" & ">"
              For m_lngCount = 1 To UBound(m_strFeatureSchema)
                Print #1, "             " & m_strFeatureSchema(m_lngCount)
              Next m_lngCount
              Print #1, "           </SchemaData>"
            End If
            Print #1, "         </ExtendedData>"
          End If
        End If
        If m_boolAddTimeStamps = True Then
          Print #1, "         <TimeSpan>"
          Print #1, "           <begin>" & CleanXMLString(m_strStartTime, True) & "</begin>"
          Print #1, "           <end>" & CleanXMLString(m_strEndTime, True) & "</end>"
          Print #1, "         </TimeSpan>"
        End If
        Print #1, "         <Point>"
        Print #1, "           <extrude>" & CStr(m_intExtrusion) & "</extrude>"
        Print #1, "           <altitudeMode>" & m_strAltitudeMode & "</altitudeMode>"
        Print #1, "           <coordinates>"
          
        ' get extrusion value
        If m_boolIs3DAttribute = True Then
          If IsNull(GetFieldValue(pFeature, cboHeightAttribute.Text)) = False Then
            m_strZCoord = GetFieldValue(pFeature, cboHeightAttribute.Text)
            m_dblZCoord = CDbl(m_strZCoord)
          Else
            m_dblZCoord = 0
          End If
          
          ' add surface offsets if necessary
          If frmExporttoKMLOptions.cboOffsetAttribute.Text <> "<NONE>" Then
            If IsNull(GetFieldValue(pFeature, frmExporttoKMLOptions.cboOffsetAttribute.Text)) = False Then
              m_strOffsetValue = GetFieldValue(pFeature, frmExporttoKMLOptions.cboOffsetAttribute.Text)
              m_dblOffsetValue = CDbl(m_strOffsetValue)
              m_dblZCoord = m_dblZCoord + m_dblOffsetValue
            End If
          End If
          If CDbl(frmExporttoKMLOptions.txtOffsetManual.Text) <> 0 Then
            m_dblOffsetValue = CDbl(frmExporttoKMLOptions.txtOffsetManual.Text)
            m_dblZCoord = m_dblZCoord + m_dblOffsetValue
          End If
        Else
          m_dblZCoord = 0
        End If
        
        ' convert z value to meters
        m_dblZCoord = m_dblZCoord * m_sglUnitConversion
           
        ' write out X/Y/Z coordinates of each point
        m_strXCoord = CStr(pPoint.X)
        m_strYCoord = CStr(pPoint.Y)
        m_strXCoord = ReplaceNumericCommas(m_strXCoord)
        m_strYCoord = ReplaceNumericCommas(m_strYCoord)
        If m_boolIs3DShape = True Then
          m_dblZCoord = pPoint.z * m_sglUnitConversion
        End If
        m_strZCoord = ReplaceNumericCommas(CStr(m_dblZCoord))
        m_strNextKMLLine = "             " & m_strXCoord & "," & m_strYCoord & "," & m_strZCoord
        Print #1, m_strNextKMLLine
          
        ' write out KML footer for each point
        Print #1, "           </coordinates>"
        Print #1, "         </Point>"
        
        ' close out the geometry
        Print #1, "       </Placemark>"
        
        ' record the start and end times for each point
        If m_boolAddTimeStamps = True Then
          RecordTimeStampInformation m_strStartTime, m_strEndTime
        End If
        
        ' record label information for each polyline
        If m_boolLabelFeatures = True Then
          RecordLabelInformation pFeature, pPoint, m_strZCoord, m_strStyleName
        End If
        
        ' record the group name and number of features
        m_strPreviousGroupName = m_strGroupName
        m_lngFeatCount = m_lngFeatCount + 1
      End If
      
      ' get the next feature
      Set pFeature = pFeatureCursor.NextFeature
      m_pStatusBar.StepProgressBar
    Loop
    
  ' POLYLINE features ---------
  ElseIf pFeature.Shape.GeometryType = esriGeometryPolyline Then
    
    ' loop through polylines and write out KML tags
    Do While Not pFeature Is Nothing
    
      ' get the geometry from the feature (remove any true curves)
      Set pGeometry2 = DensifyTrueCurves(pFeature)
    
      ' manually shift the polylines (if necessary)
      If frmExporttoKMLOptions.txtXShift <> 0 Or frmExporttoKMLOptions.txtYShift <> 0 Then
        Set pTransform2D = pGeometry2  'QI
        pTransform2D.Move frmExporttoKMLOptions.txtXShift, frmExporttoKMLOptions.txtYShift
      End If
      
      ' reproject the geometry (if necessary)
      If m_boolSpRefEqual = False Then
        Set pGeometry2.SpatialReference = m_pSpRefInput
        If m_boolPerformGCSTransform = True Then
          pGeometry2.ProjectEx m_pSpRefOutput, esriTransformReverse, m_pOutputGeoTransformation, False, 0, 0
        Else
          pGeometry2.Project m_pSpRefOutput
        End If
      End If
      Set pGeomCollection = pGeometry2
      
      ' write out KML header for each group if the feature has geometry
      m_boolExporttheFeature = True
      If Not pGeometry2.IsEmpty = True Then
        boolNoGeometry = False
        WriteOutFeatures pFeature, m_lngFeatCount  'SUB
      Else
        m_boolExporttheFeature = False
      End If

      ' write out KML information for each segment
      If m_boolExporttheFeature = True Then
        For lngGeomNum = 0 To pGeomCollection.GeometryCount - 1
          Set pSegmentCollection = pGeomCollection.Geometry(lngGeomNum)
          
          ' write out KML header for each polyline
          Print #1, "       <Placemark>"
          Print #1, "         <name>" & CleanXMLString(m_strFeatureName, True) & "</name>"
          Print #1, "         <Snippet maxLines=""" & intSnippetLines & """>" & m_strFeatureSnippet & "</Snippet>"
          Print #1, "         <styleUrl>#" & CleanXMLString(m_strStyleName, False) & "</styleUrl>"
          If m_boolGoogleMapsCompatible = True Then
            Print #1, "         <description>" & m_strFeatureDescription & "</description>"
          Else
            If m_intSchemaFieldCount > 0 Then
              Print #1, "         <ExtendedData>"
              If m_boolUseUnTypedData = True Then
                For m_lngCount = 1 To UBound(m_strFeatureSchema)
                  Print #1, "           " & m_strFeatureSchema(m_lngCount)
                Next m_lngCount
              Else
                Print #1, "           <SchemaData schemaUrl=""#" & m_strKMLSchemaName & "_schema""" & ">"
                For m_lngCount = 1 To UBound(m_strFeatureSchema)
                  Print #1, "             " & m_strFeatureSchema(m_lngCount)
                Next m_lngCount
                Print #1, "           </SchemaData>"
              End If
              Print #1, "         </ExtendedData>"
            End If
          End If
          If m_boolAddTimeStamps = True Then
            Print #1, "         <TimeSpan>"
            Print #1, "           <begin>" & CleanXMLString(m_strStartTime, True) & "</begin>"
            Print #1, "           <end>" & CleanXMLString(m_strEndTime, True) & "</end>"
            Print #1, "         </TimeSpan>"
          End If
          Print #1, "           <LineString>"
          Print #1, "             <extrude>" & CStr(m_intExtrusion) & "</extrude>"
          Print #1, "             <tessellate>" & CStr(m_intTessellate) & "</tessellate>"
          Print #1, "             <altitudeMode>" & m_strAltitudeMode & "</altitudeMode>"
          Print #1, "             <coordinates>"
          
          ' write out KML tags for the vertices of each polyline segment
          WriteOutSegmentXYZs pFeature, pSegmentCollection, False, m_boolIs3DAttribute, m_boolIs3DShape 'sub
          
          ' get the label/info point location
          If m_boolLabelFeatures = True Or frmExporttoKMLOptions.chkCreateInfoPoints = vbChecked Then
            Set pLabelPoint = GetFeatureLabelPoint("POLYLINE", pGeomCollection.Geometry(lngGeomNum))
          End If
          
          ' record the start and end times for each polyline
          If m_boolAddTimeStamps = True Then
            RecordTimeStampInformation m_strStartTime, m_strEndTime
          End If

          ' record label information for each polyline
          If m_boolLabelFeatures = True Then
            RecordLabelInformation pFeature, pLabelPoint, m_strZCoord, m_strStyleName
          End If
          
          ' record information point description for each polyline
          If frmExporttoKMLOptions.chkCreateInfoPoints = vbChecked Then
            RecordInfoPointInformation pLabelPoint, m_strZCoord, m_strFeatureName, m_strFeatureSchema
          End If
            
          ' write out KML footer for each polyline
          Print #1, "             </coordinates>"
          Print #1, "           </LineString>"
          
          ' close out the geometry
          Print #1, "       </Placemark>"
        
        Next lngGeomNum
        
        ' get the next feature
        m_strPreviousGroupName = m_strGroupName
        m_lngFeatCount = m_lngFeatCount + 1
      End If
      
      ' get the next feature
      Set pFeature = pFeatureCursor.NextFeature
      m_pStatusBar.StepProgressBar
    Loop
    
  ' POLYGON features ---------
  ElseIf pFeature.Shape.GeometryType = esriGeometryPolygon Then
    
    ' loop through polygon features and write out KML tags
    Do While Not pFeature Is Nothing
      
      ' get the geometry from the feature (remove any true curves)
      Set pGeometry2 = DensifyTrueCurves(pFeature)

      ' manually shift the polygons (if necessary)
      If frmExporttoKMLOptions.txtXShift <> 0 Or frmExporttoKMLOptions.txtYShift <> 0 Then
        Set pTransform2D = pGeometry2  'QI
        pTransform2D.Move frmExporttoKMLOptions.txtXShift, frmExporttoKMLOptions.txtYShift
      End If
      
      ' reproject geometry (if necessary)
      If m_boolSpRefEqual = False Then
        Set pGeometry2.SpatialReference = m_pSpRefInput
        If m_boolPerformGCSTransform = True Then
          pGeometry2.ProjectEx m_pSpRefOutput, esriTransformForward, m_pOutputGeoTransformation, False, 0, 0
        Else
          pGeometry2.Project m_pSpRefOutput
        End If
      End If
      Set pGeomCollection = pGeometry2
      
      ' write out KML header for each group if the feature has geometry
      m_boolExporttheFeature = True
      If Not pGeometry2.IsEmpty = True Then
        boolNoGeometry = False
        WriteOutFeatures pFeature, m_lngFeatCount 'SUB
      Else
        m_boolExporttheFeature = False
      End If
      
      ' write out KML header for each polygon
      If m_boolExporttheFeature = True Then

        ' export polygon, dealing with any topology errors
        Set pPolygon = pGeometry2
        
        ' simplify the polygon geeometry to make it topographically correct
        pPolygon.SimplifyEx True, True, True
        
        ' check topology
        If pPolygon.ExteriorRingCount = 0 Then
          ' BAD topogology; export feature as a simple geometry collection
          For lngGeomNum = 0 To pGeomCollection.GeometryCount - 1
            Set pSegmentCollection = pGeomCollection.Geometry(lngGeomNum)
            
            ' write out the header for each polygon
            Print #1, "       <Placemark>"
            Print #1, "         <name>" & CleanXMLString(m_strFeatureName, True) & "</name>"
            Print #1, "         <Snippet maxLines=""" & intSnippetLines & """>" & m_strFeatureSnippet & "</Snippet>"
            Print #1, "         <styleUrl>#" & CleanXMLString(m_strStyleName, False) & "</styleUrl>"
            If m_boolGoogleMapsCompatible = True Then
              Print #1, "         <description>" & m_strFeatureDescription & "</description>"
            Else
              If m_intSchemaFieldCount > 0 Then
                Print #1, "         <ExtendedData>"
                If m_boolUseUnTypedData = True Then
                  For m_lngCount = 1 To UBound(m_strFeatureSchema)
                    Print #1, "           " & m_strFeatureSchema(m_lngCount)
                  Next m_lngCount
                Else
                  Print #1, "           <SchemaData schemaUrl=""#" & m_strKMLSchemaName & "_schema""" & ">"
                  For m_lngCount = 1 To UBound(m_strFeatureSchema)
                    Print #1, "             " & m_strFeatureSchema(m_lngCount)
                  Next m_lngCount
                  Print #1, "           </SchemaData>"
                End If
                Print #1, "         </ExtendedData>"
              End If
            End If
            If m_boolAddTimeStamps = True Then
              Print #1, "         <TimeSpan>"
              Print #1, "           <begin>" & CleanXMLString(m_strStartTime, True) & "</begin>"
              Print #1, "           <end>" & CleanXMLString(m_strEndTime, True) & "</end>"
              Print #1, "         </TimeSpan>"
            End If
            Print #1, "         <Polygon>"
            Print #1, "           <extrude>" & CStr(m_intExtrusion) & "</extrude>"
            Print #1, "           <altitudeMode>" & m_strAltitudeMode & "</altitudeMode>"
            Print #1, "           <outerBoundaryIs>"
            Print #1, "           <LinearRing>"
            Print #1, "             <coordinates>"
            
            ' write out KML tags for the vertices of each polyline segment
            WriteOutSegmentXYZs pFeature, pSegmentCollection, False, m_boolIs3DAttribute, m_boolIs3DShape 'sub
            
            ' record the start and end times for each polygon
            If m_boolAddTimeStamps = True Then
              RecordTimeStampInformation m_strStartTime, m_strEndTime
            End If

            ' get the label/info point location
            If m_boolLabelFeatures = True Or frmExporttoKMLOptions.chkCreateInfoPoints = vbChecked Then
              Set pLabelPoint = GetFeatureLabelPoint("POLYGON", pGeomCollection.Geometry(lngGeomNum))
            End If

            ' record label information for each polygon
            If m_boolLabelFeatures = True Then
              RecordLabelInformation pFeature, pLabelPoint, m_strZCoord, m_strStyleName
            End If
            
            ' record information point description for each polygon
            If frmExporttoKMLOptions.chkCreateInfoPoints = vbChecked Then
              RecordInfoPointInformation pLabelPoint, m_strZCoord, m_strFeatureName, m_strFeatureSchema
            End If
            
            ' write out KML footer for each polygon
            Print #1, "             </coordinates>"
            Print #1, "           </LinearRing>"
            Print #1, "           </outerBoundaryIs>"
            
            ' close the KML polygon
            Print #1, "         </Polygon>"
            
            ' close out the geometry
            Print #1, "       </Placemark>"
          
          Next lngGeomNum
          
        Else
          ' GOOD topology; export the inner and outer rings individually
          ' FIRST, process the outer rings
          ' get the geometry collection
          ReDim pExtRings(pPolygon.ExteriorRingCount - 1)
          pPolygon.QueryExteriorRingsEx pPolygon.ExteriorRingCount, pExtRings(0)
          For lngExtRing = 0 To pPolygon.ExteriorRingCount - 1
            
            ' write out KML header for the exterior ring
            Print #1, "       <Placemark>"
            Print #1, "         <name>" & CleanXMLString(m_strFeatureName, True) & "</name>"
            Print #1, "         <Snippet maxLines=""" & intSnippetLines & """>" & m_strFeatureSnippet & "</Snippet>"
            Print #1, "         <styleUrl>#" & CleanXMLString(m_strStyleName, False) & "</styleUrl>"
            If m_boolGoogleMapsCompatible = True Then
              Print #1, "         <description>" & m_strFeatureDescription & "</description>"
            Else
              If m_intSchemaFieldCount > 0 Then
                Print #1, "         <ExtendedData>"
                If m_boolUseUnTypedData = True Then
                  For m_lngCount = 1 To UBound(m_strFeatureSchema)
                    Print #1, "           " & m_strFeatureSchema(m_lngCount)
                  Next m_lngCount
                Else
                  Print #1, "           <SchemaData schemaUrl=""#" & m_strKMLSchemaName & "_schema""" & ">"
                  For m_lngCount = 1 To UBound(m_strFeatureSchema)
                    Print #1, "             " & m_strFeatureSchema(m_lngCount)
                  Next m_lngCount
                  Print #1, "           </SchemaData>"
                End If
                Print #1, "         </ExtendedData>"
              End If
            End If
            If m_boolAddTimeStamps = True Then
              Print #1, "         <TimeSpan>"
              Print #1, "           <begin>" & CleanXMLString(m_strStartTime, True) & "</begin>"
              Print #1, "           <end>" & CleanXMLString(m_strEndTime, True) & "</end>"
              Print #1, "         </TimeSpan>"
            End If
            Print #1, "         <Polygon>"
            Print #1, "           <extrude>" & CStr(m_intExtrusion) & "</extrude>"
            Print #1, "           <altitudeMode>" & m_strAltitudeMode & "</altitudeMode>"
            Print #1, "           <outerBoundaryIs>"
            Print #1, "           <LinearRing>"
            Print #1, "             <coordinates>"
            
            ' get the exterior ring's segments
            Set pSegmentCollection = pExtRings(lngExtRing)
            
            ' write out KML tags for the vertices of each exterior ring segment
            WriteOutSegmentXYZs pFeature, pSegmentCollection, True, m_boolIs3DAttribute, m_boolIs3DShape
            
            ' record the start and end times for each polygon
            If m_boolAddTimeStamps = True Then
              RecordTimeStampInformation m_strStartTime, m_strEndTime
            End If
            
            ' get the label/info point location
            If m_boolLabelFeatures = True Or frmExporttoKMLOptions.chkCreateInfoPoints = vbChecked Then
              Set pLabelPoint = GetFeatureLabelPoint("POLYGON", pExtRings(lngExtRing))
            End If
            
            ' record label information for each exterior ring
            If m_boolLabelFeatures = True Then
              RecordLabelInformation pFeature, pLabelPoint, m_strZCoord, m_strStyleName
            End If
            
            ' record information point description for each exterior ring
            If frmExporttoKMLOptions.chkCreateInfoPoints = vbChecked Then
              RecordInfoPointInformation pLabelPoint, m_strZCoord, m_strFeatureName, m_strFeatureSchema
            End If
            
            ' write out KML footer for each exterior ring
            Print #1, "             </coordinates>"
            Print #1, "           </LinearRing>"
            Print #1, "           </outerBoundaryIs>"
              
            ' NEXT, any inner rings
            If pPolygon.InteriorRingCount(pExtRings(lngExtRing)) > 0 Then
              ReDim pIntRings(pPolygon.InteriorRingCount(pExtRings(lngExtRing)) - 1)
              pPolygon.QueryInteriorRingsEx pExtRings(lngExtRing), pPolygon.InteriorRingCount(pExtRings(lngExtRing)), pIntRings(0)
              For lngIntRing = 0 To pPolygon.InteriorRingCount(pExtRings(lngExtRing)) - 1
    
                ' write out KML header for the inner ring
                Print #1, "           <innerBoundaryIs>"
                Print #1, "           <LinearRing>"
                Print #1, "             <coordinates>"
                
                ' get the inner ring's segments
                Set pSegmentCollection = pIntRings(lngIntRing)
                
                ' write out KML tags for the vertices of each interior ring segment
                WriteOutSegmentXYZs pFeature, pSegmentCollection, False, m_boolIs3DAttribute, m_boolIs3DShape
                
                ' write out KML footer for each inner ring
                Print #1, "             </coordinates>"
                Print #1, "           </LinearRing>"
                Print #1, "           </innerBoundaryIs>"
              Next lngIntRing
            End If
            
            ' close the KML polygon
            Print #1, "         </Polygon>"
            
            ' close out the geometry
            Print #1, "       </Placemark>"

          Next lngExtRing
        End If
         
        ' get the next feature
        m_strPreviousGroupName = m_strGroupName
        m_lngFeatCount = m_lngFeatCount + 1
      End If
      
      ' get the next feature
      Set pFeature = pFeatureCursor.NextFeature
      m_pStatusBar.StepProgressBar
    Loop
  End If
  
  ' close the folder of the final feature
  If boolNoGeometry = False Then
    If m_boolUseArcMapSymbology = True Then
      Print #1, "     </Folder>"
    End If
  Else
    MsgBox "Operation failed. " & UCase(pFLayer.Name) & " cannot be exported" _
    & " because is contains no valid geometry.", vbCritical, "Export to Google Earth KML"
    Close #1
    Kill txtOutputKML.Text
    m_pStatusBar.HideProgressBar
    Unload frmExporttoKMLOptions
    Unload frmExporttoKML
    Exit Sub
  End If
  
  ' close the feature folder
  Print #1, "  </Folder>"
  
  ' WRITE OUT FEATURE LABELS
  Dim strStartTime As String
  Dim strEndTime As String
  Dim lngFeatureCount As Long
  If m_boolLabelFeatures = True Then
    ' re-initialize progress bar
    m_pProgressBar.Position = 0
    m_pStatusBar.ShowProgressBar "Labeling " & CStr(lngNumbFeatures) & " features from " _
    & pFLayer.Name, 0, lngNumbFeatures, 1, True
    
    ' open the label folder
    Print #1, "  <Folder>"
    Print #1, "    <name>Feature Labels (" & CleanXMLString(cboLabelAttribute.Text, True) & ")</name>"
    Print #1, "    <open>0</open>"

    ' loop through features and generate labels
    For lngFeatureCount = 1 To UBound(m_strLabelNames)
      If m_boolAddTimeStamps = True Then
        strStartTime = m_strStartTimes(lngFeatureCount)
        strEndTime = m_strEndTimes(lngFeatureCount)
      Else
        strStartTime = ""
        strEndTime = ""
      End If
      WriteOutLabels m_strLabelNames(lngFeatureCount), strStartTime, strEndTime, m_strLabelStyleNames(lngFeatureCount), m_strLabelXYZs(lngFeatureCount)
      m_pStatusBar.StepProgressBar
    Next lngFeatureCount
    
    ' close the label folder
    Print #1, "  </Folder>"
  End If
  
  ' WRITE OUT "INFO" POINTS
  Dim strSchemaValues() As String
  Dim intAttributeCount As Integer
  If frmExporttoKMLOptions.chkCreateInfoPoints = vbChecked Then
    ReDim strSchemaValues(UBound(m_strFeatureSchemas, 1))

    ' re-initialize progress bar
    m_pProgressBar.Position = 0
    m_pStatusBar.ShowProgressBar "Creating Information points for " & CStr(lngNumbFeatures) & " features from " _
    & pFLayer.Name, 0, lngNumbFeatures, 1, True
    
    ' open the "info point" folder
    Print #1, "  <Folder>"
    Print #1, "    <name>Information Points</name>"
    Print #1, "    <open>0</open>"

    ' loop through features and generate info points
    For lngFeatureCount = 1 To UBound(m_strFeatureSchemas, 2)
      If m_boolAddTimeStamps = True Then
        strStartTime = m_strStartTimes(lngFeatureCount)
        strEndTime = m_strEndTimes(lngFeatureCount)
      Else
        strStartTime = ""
        strEndTime = ""
      End If
      For intAttributeCount = 1 To UBound(strSchemaValues)
        strSchemaValues(intAttributeCount) = m_strFeatureSchemas(intAttributeCount, lngFeatureCount)
      Next intAttributeCount
      WriteOutInfoPoints m_strFeatureNames(lngFeatureCount), strStartTime, strEndTime, strSchemaValues, m_strInfoPointXYZs(lngFeatureCount)
      m_pStatusBar.StepProgressBar
    Next lngFeatureCount
    
    ' close the "info point" folder
    Print #1, "  </Folder>"
  End If

  ' write  out remaining footer
  Print #1, "</Document>"
  Print #1, "</kml>"
  Close #1
  
  ' open KML file if specified
  If MsgBox("Would you like to open " & strKMLName & " in Google Earth?", vbYesNo, "Export to Google Earth KML") = vbYes Then
    ShellExecute hWnd, "open", txtOutputKML.Text, vbNull, vbNull, SW_SHOWNORMAL
  End If
  
  ' unload form
  m_pStatusBar.HideProgressBar
End Sub

Public Function GetUniqueFieldValues(aFeatureLayer As esricarto.IFeatureLayer, aFieldName As String) As esriSystem.IEnumVariantSimple
  ' get a list of unique values for the specified field
  Dim pCursor As esriGeoDatabase.ICursor
  Dim pDataStats As esriGeoDatabase.IDataStatistics
  Set pCursor = aFeatureLayer.Search(Nothing, False)
  Set pDataStats = New esriGeoDatabase.DataStatistics
  pDataStats.Field = g_pLayerSymbolField.Name
  Set pDataStats.Cursor = pCursor
  Set GetUniqueFieldValues = pDataStats.UniqueValues
End Function

Public Function GenerateRandomColor(theTransparency As String) As String
  ' generates a random hex color
  Dim intColor As Integer
  Dim strHexColor As String
  Dim strRGBHexColor
  Dim m_lngCount As Integer
  strRGBHexColor = theTransparency
  For m_lngCount = 1 To 3
    intColor = Int((255 * Rnd))
    strHexColor = CStr(Hex(intColor))
    If Len(strHexColor) < 2 Then
      strHexColor = "0" & strHexColor
    End If
    strRGBHexColor = strRGBHexColor & strHexColor
  Next m_lngCount
  GenerateRandomColor = strRGBHexColor
End Function

Public Sub WriteOutSegmentXYZs(aFeature As esriGeoDatabase.IFeature, aSegmentCollection As esriGeometry.ISegmentCollection, _
boolReverseOrder As Boolean, boolExtrudeAttribute As Boolean, boolZValues As Boolean)
  
  ' dimension variables
  Dim lngSegNum As Long
  Dim strXYZCoordinates() As String
  Dim lngPoint As Long
  ReDim strXYZCoordinates(aSegmentCollection.SegmentCount + 1)
  
  ' get the 3D extrusion value from the feature
  If m_boolIs3DAttribute = True Then
    If IsNull(GetFieldValue(aFeature, cboHeightAttribute.Text)) = False Then
      m_strZCoord = GetFieldValue(aFeature, cboHeightAttribute.Text)
      m_dblZCoord = CDbl(m_strZCoord)
    Else
      m_dblZCoord = 0
    End If
    
    ' add surface offsets if necessary
    If frmExporttoKMLOptions.cboOffsetAttribute.Text <> "<NONE>" Then
      If IsNull(GetFieldValue(aFeature, frmExporttoKMLOptions.cboOffsetAttribute.Text)) = False Then
        m_strOffsetValue = GetFieldValue(aFeature, frmExporttoKMLOptions.cboOffsetAttribute.Text)
        m_dblOffsetValue = CDbl(m_strOffsetValue)
        m_dblZCoord = m_dblZCoord + m_dblOffsetValue
      End If
    End If
    If CDbl(frmExporttoKMLOptions.txtOffsetManual.Text) <> 0 Then
      m_dblOffsetValue = CDbl(frmExporttoKMLOptions.txtOffsetManual.Text)
      m_dblZCoord = m_dblZCoord + m_dblOffsetValue
    End If
  Else
    m_dblZCoord = 0
  End If
  
  ' convert Z units to meters
  m_dblZCoord = m_dblZCoord * m_sglUnitConversion
    
  ' loop through segments and write out X/Y/Z values
  lngPoint = 1
  For lngSegNum = 0 To aSegmentCollection.SegmentCount - 1
     
    ' get X/Y/Z coordinates of each vertex
    If lngSegNum = 0 Then
      m_strXCoord = CStr(aSegmentCollection.Segment(lngSegNum).FromPoint.X)
      m_strYCoord = CStr(aSegmentCollection.Segment(lngSegNum).FromPoint.Y)
      m_strXCoord = ReplaceNumericCommas(m_strXCoord)
      m_strYCoord = ReplaceNumericCommas(m_strYCoord)
      If m_boolIs3DShape = True Then
        m_dblZCoord = aSegmentCollection.Segment(lngSegNum).FromPoint.z * m_sglUnitConversion
      End If
      m_strZCoord = ReplaceNumericCommas(CStr(m_dblZCoord))
      strXYZCoordinates(lngPoint) = m_strXCoord & "," & m_strYCoord & "," & m_strZCoord
      lngPoint = lngPoint + 1
    End If
    m_strXCoord = CStr(aSegmentCollection.Segment(lngSegNum).ToPoint.X)
    m_strYCoord = CStr(aSegmentCollection.Segment(lngSegNum).ToPoint.Y)
    m_strXCoord = ReplaceNumericCommas(m_strXCoord)
    m_strYCoord = ReplaceNumericCommas(m_strYCoord)
    If m_boolIs3DShape = True Then
      m_dblZCoord = aSegmentCollection.Segment(lngSegNum).ToPoint.z * m_sglUnitConversion
    End If
    m_strZCoord = ReplaceNumericCommas(CStr(m_dblZCoord))
    strXYZCoordinates(lngPoint) = m_strXCoord & "," & m_strYCoord & "," & m_strZCoord
    lngPoint = lngPoint + 1
  Next lngSegNum
  
  ' write out XYZ KML tags
  If boolReverseOrder = True Then
    For lngPoint = UBound(strXYZCoordinates) To 1 Step -1
      Print #1, "               " & strXYZCoordinates(lngPoint)
    Next lngPoint
  Else
    For lngPoint = 1 To UBound(strXYZCoordinates)
      Print #1, "               " & strXYZCoordinates(lngPoint)
    Next lngPoint
  End If
End Sub

Public Function ConvertRGBtoHex(aColor As esriDisplay.IColor, theTransparency As String) As String
  ' dimension variables
  Dim intColor As Integer
  Dim strHexColor As String
  Dim strBGRHexColor As String
    
  ' get the initial RGB and transparency string
  strBGRHexColor = theTransparency

  ' process blue
  intColor = aColor.RGB \ 65536 And 255
  strHexColor = CStr(Hex(intColor))
  If Len(strHexColor) < 2 Then
    strHexColor = "0" & strHexColor
  End If
  strBGRHexColor = strBGRHexColor & strHexColor
  
  ' process green
  intColor = aColor.RGB \ 256 And 255
  strHexColor = CStr(Hex(intColor))
  If Len(strHexColor) < 2 Then
    strHexColor = "0" & strHexColor
  End If
  strBGRHexColor = strBGRHexColor & strHexColor
  
  ' process red
  intColor = aColor.RGB And 255
  strHexColor = CStr(Hex(intColor))
  If Len(strHexColor) < 2 Then
    strHexColor = "0" & strHexColor
  End If
  strBGRHexColor = strBGRHexColor & strHexColor
  
  ' return hex color
  ConvertRGBtoHex = strBGRHexColor
  
End Function

Private Function CleanXMLString(aString As String, boolUseCDATA As Boolean) As String
  Dim strCleanString As String

  ' reformat <Null> values
  strCleanString = Replace(aString, "<Null>", "-NULL-")

  ' implement CDATA tag if the specified
  If boolUseCDATA = True Then
    strCleanString = "<![CDATA[" & aString & "]]>"
    
  ' otherwise, use entity attributes
  Else
    ' &
    strCleanString = Replace(strCleanString, "&", "&amp;")
    ' <
    strCleanString = Replace(strCleanString, "<", "&lt;")
    ' >
    strCleanString = Replace(strCleanString, ">", "&gt;")
    '
    strCleanString = Replace(strCleanString, "'", "&apos;")
    ' "
    strCleanString = Replace(strCleanString, Chr(34), "&quot;")
    ' #
    strCleanString = Replace(strCleanString, "#", "No.")
  End If
    
  CleanXMLString = Trim(strCleanString)
End Function

Private Function GetSymbolfromRenderer(aStyleArrayValue As String, anArrayIndex As Long) As esriDisplay.ISymbol
  Dim pSymbol As esriDisplay.ISymbol
  
  ' if using a unique value renderer
  If TypeOf m_pGFLayerRenderer Is esricarto.IUniqueValueRenderer Then
    If aStyleArrayValue = m_pUniqueValueRenderer.DefaultLabel Then
      Set pSymbol = m_pUniqueValueRenderer.DefaultSymbol
    Else
      Set pSymbol = m_pUniqueValueRenderer.Symbol(aStyleArrayValue)
    End If
    
  ' if using a class breaks renderer
  ElseIf TypeOf m_pGFLayerRenderer Is esricarto.IClassBreaksRenderer Then
    Set pSymbol = m_pClassBreaksRenderer.Symbol(anArrayIndex)
  
  ' get a color from the renderer if a simple renderer is being used
  ElseIf TypeOf m_pGFLayerRenderer Is esricarto.ISimpleRenderer Then
    Set pSymbol = m_pSimpleRenderer.Symbol
  End If
  
  Set GetSymbolfromRenderer = pSymbol
End Function

Private Sub WriteOutFeatures(aFeature As esriGeoDatabase.IFeature, aCount As Long)
  
  ' get the feature
  Dim pFeature As esriGeoDatabase.IFeature
  Set pFeature = aFeature
  
  ' determine if feature value is null
  If m_boolUseArcMapSymbology = True Then
    If IsNull(GetFieldValue(pFeature, g_pLayerSymbolField.AliasName)) = False Then
          
      ' get the feature value
      m_strFeatureValue = CStr(GetFieldValue(pFeature, g_pLayerSymbolField.AliasName))
      
      ' if using a unique values renderer
      If TypeOf m_pGFLayerRenderer Is esricarto.IUniqueValueRenderer Then
        m_boolGroupExists = False
        
        ' determine whether the feature is being symbolized by the renderer
        For m_lngCount = 0 To UBound(m_strKMLStyles)
          If m_strKMLStyles(m_lngCount) = m_strFeatureValue Then
            m_boolGroupExists = True
          End If
        Next m_lngCount
        
        ' get the group name from the renderer
        If m_boolGroupExists = True Then
          m_strStyleName = m_strFeatureValue
          m_strGroupName = m_pUniqueValueRenderer.Label(m_strFeatureValue)
        Else
          If m_pUniqueValueRenderer.UseDefaultSymbol = True Then
            m_strStyleName = m_pUniqueValueRenderer.DefaultLabel
            m_strGroupName = m_strStyleName
          Else
            m_boolExporttheFeature = False
          End If
        End If
      
      ' if using a class breaks renderer
      ElseIf TypeOf m_pGFLayerRenderer Is esricarto.IClassBreaksRenderer Then
        m_boolGroupExists = False
        m_intClassBreakIndex = -1
        
        ' get class break index depending on whther data in ascending or descending order
        If m_boolClassBreaksAscending = True Then
          ' tag values in the first class
          If CDbl(m_strFeatureValue) <= CDbl(CStr(m_pClassBreaksRenderer.Break(0))) And _
          CDbl(m_strFeatureValue) >= CDbl(CStr(m_pClassBreaksRenderer.MinimumBreak)) Then
            m_intClassBreakIndex = 0
          End If
          
          ' tag values in all other classes
          For m_lngCount = 1 To m_pClassBreaksRenderer.BreakCount - 1
            If CDbl(m_strFeatureValue) <= CDbl(CStr(m_pClassBreaksRenderer.Break(m_lngCount))) And _
            CDbl(m_strFeatureValue) > CDbl(CStr(m_pClassBreaksRenderer.Break(m_lngCount - 1))) Then
              m_intClassBreakIndex = m_lngCount
            End If
          Next m_lngCount
        Else
           ' tag values in the last class
          If CDbl(m_strFeatureValue) <= CDbl(CStr(m_pClassBreaksRenderer.Break(m_pClassBreaksRenderer.BreakCount - 1))) And _
          CDbl(m_strFeatureValue) >= CDbl(CStr(m_pClassBreaksRenderer.MinimumBreak)) Then
            m_intClassBreakIndex = m_pClassBreaksRenderer.BreakCount - 1
          End If
          
          ' tag values in all other classes
          For m_lngCount = 0 To m_pClassBreaksRenderer.BreakCount - 1
            If CDbl(m_strFeatureValue) <= CDbl(CStr(m_pClassBreaksRenderer.Break(m_lngCount))) And _
            CDbl(m_strFeatureValue) > CDbl(CStr(m_pClassBreaksRenderer.Break(m_lngCount + 1))) Then
              m_intClassBreakIndex = m_lngCount
            End If
          Next m_lngCount
        End If
        
        ' get the group name from the renderer
        If m_intClassBreakIndex >= 0 Then
          m_strStyleName = m_pClassBreaksRenderer.Break(m_intClassBreakIndex)
          m_strGroupName = m_pClassBreaksRenderer.Label(m_intClassBreakIndex)
        Else
          m_boolExporttheFeature = False
        End If
      End If
    Else
      m_strStyleName = "<Null>"
      m_strGroupName = "<Null>"
    End If
  Else
    m_strStyleName = "FEATURES"
    m_strGroupName = ""
  End If
  
  ' GET OTHER ATTRIBUTE-BASED INFO
  ' feature name
  m_strFeatureName = CStr(aCount)
  If Trim(frmExporttoKMLOptions.cboFeatureNameAttribute.Text) <> "<NONE>" Then
    If IsNull(GetFieldValue(pFeature, frmExporttoKMLOptions.cboFeatureNameAttribute.Text)) = False Then
      m_strFeatureName = Trim(CStr(GetFieldValue(pFeature, frmExporttoKMLOptions.cboFeatureNameAttribute.Text)))
      If m_strFeatureName = "" Then
        m_strFeatureName = "<Null>"
      End If
    Else
      m_strFeatureName = "<Null>"
    End If
  End If
  
  ' feature schema attribute information
  ReDim m_strFeatureSchema(0)
  Dim pFields As esriGeoDatabase.IFields2
  Dim pField As esriGeoDatabase.IField
  Dim intFieldIndex As Integer
  Set pFields = m_pDBFields
  ' export fields and values
  If m_intSchemaFieldCount > 0 Then
    For m_lngCount = 0 To m_intSchemaFieldCount - 1
      intFieldIndex = pFeature.Fields.FindFieldByAliasName(frmExporttoKMLOptions.lstTableAttributesExport.List(m_lngCount))
      ReDim Preserve m_strFeatureSchema(UBound(m_strFeatureSchema) + 1)
      Set pField = pFields.Field(intFieldIndex)
      If IsNull(GetFieldValue(pFeature, pField.AliasName)) = False Then
        If (pField.Type = esriFieldTypeString Or pField.Type = esriFieldTypeDate) _
        And Trim(CStr(GetFieldValue(pFeature, pField.AliasName))) <> "" Then
          If m_boolUseUnTypedData = True Then
            m_strFeatureSchema(UBound(m_strFeatureSchema)) = "<Data name=""" & pField.Name & """><value>" & CleanXMLString(Trim(CStr(GetFieldValue(pFeature, pField.AliasName))), True) & "</value></Data>"
          Else
            m_strFeatureSchema(UBound(m_strFeatureSchema)) = "<SimpleData name=""" & pField.Name & """>" & CleanXMLString(Trim(CStr(GetFieldValue(pFeature, pField.AliasName))), True) & "</SimpleData>"
          End If
        Else
          If m_boolUseUnTypedData = True Then
            m_strFeatureSchema(UBound(m_strFeatureSchema)) = "<Data name=""" & pField.Name & """><value>" & Trim(CStr(GetFieldValue(pFeature, pField.AliasName))) & "</value></Data>"
          Else
            m_strFeatureSchema(UBound(m_strFeatureSchema)) = "<SimpleData name=""" & pField.Name & """>" & Trim(CStr(GetFieldValue(pFeature, pField.AliasName))) & "</SimpleData>"
          End If
        End If
      Else
        If m_boolUseUnTypedData = True Then
          m_strFeatureSchema(UBound(m_strFeatureSchema)) = "<Data name=""" & pField.Name & """><value>" & "-NULL-" & "</value></Data>"
        Else
          m_strFeatureSchema(UBound(m_strFeatureSchema)) = "<SimpleData name=""" & pField.Name & """>" & "-NULL-" & "</SimpleData>"
        End If
      End If
    Next m_lngCount
  End If
  
  ' build the feature snippets and descriptions for Google Maps compatible KMLs
  If m_boolGoogleMapsCompatible = True Then
    ' feature snippet
    m_strFeatureSnippet = ""
    If Trim(frmExporttoKMLOptions.txtFeatureSnippet) <> "" Then
      m_strFeatureSnippet = frmExporttoKMLOptions.txtFeatureSnippet.Text
      For m_lngCount = 0 To m_pDBFields.FieldCount - 1
        If InStr(" " & m_strFeatureSnippet, "[" & m_pDBFields.Field(m_lngCount).AliasName & "]") > 0 Then
          If IsNull(pFeature.Value(m_lngCount)) = False Then
            m_strFeatureSnippet = Replace(m_strFeatureSnippet, "[" & m_pDBFields.Field(m_lngCount).AliasName & "]", _
              CStr(pFeature.Value(m_lngCount)))
          Else
            m_strFeatureSnippet = Replace(m_strFeatureSnippet, "[" & m_pDBFields.Field(m_lngCount).AliasName & "]", _
              "-NULL-")
          End If
        ElseIf InStr(" " & m_strFeatureSnippet, "[" & m_pDBFields.Field(m_lngCount).Name & "]") > 0 Then
          If IsNull(pFeature.Value(m_lngCount)) = False Then
            m_strFeatureSnippet = Replace(m_strFeatureSnippet, "[" & m_pDBFields.Field(m_lngCount).Name & "]", _
              CStr(pFeature.Value(m_lngCount)))
          Else
            m_strFeatureSnippet = Replace(m_strFeatureSnippet, "[" & m_pDBFields.Field(m_lngCount).Name & "]", _
              "-NULL-")
          End If
      End If
      Next m_lngCount
    End If
    m_strFeatureSnippet = Replace(m_strFeatureSnippet, vbNewLine, " ")
    m_strFeatureSnippet = CleanXMLString(m_strFeatureSnippet, True)
    
    ' feature description
    m_strFeatureDescription = ""
    If Trim(frmExporttoKMLOptions.txtFeatureDescription) <> "" Then
      m_strFeatureDescription = frmExporttoKMLOptions.txtFeatureDescription.Text
      For m_lngCount = 0 To m_pDBFields.FieldCount - 1
        If InStr(" " & m_strFeatureDescription, "[" & m_pDBFields.Field(m_lngCount).AliasName & "]") > 0 Then
          If IsNull(pFeature.Value(m_lngCount)) = False Then
            m_strFeatureDescription = Replace(m_strFeatureDescription, "[" & m_pDBFields.Field(m_lngCount).AliasName & "]", _
              CStr(pFeature.Value(m_lngCount)))
          Else
             m_strFeatureDescription = Replace(m_strFeatureDescription, "[" & m_pDBFields.Field(m_lngCount).AliasName & "]", _
               "-NULL-")
          End If
        ElseIf InStr(" " & m_strFeatureDescription, "[" & m_pDBFields.Field(m_lngCount).Name & "]") > 0 Then
          If IsNull(pFeature.Value(m_lngCount)) = False Then
            m_strFeatureDescription = Replace(m_strFeatureDescription, "[" & m_pDBFields.Field(m_lngCount).Name & "]", _
              CStr(pFeature.Value(m_lngCount)))
          Else
            m_strFeatureDescription = Replace(m_strFeatureDescription, "[" & m_pDBFields.Field(m_lngCount).Name & "]", _
              "-NULL-")
          End If
        End If
      Next m_lngCount
    End If
    m_strFeatureDescription = CleanXMLString(m_strFeatureDescription, True)
  End If

  ' time stamp information
  If m_boolAddTimeStamps = True Then
    ' start time
    If Trim(frmExporttoKMLOptions.cboStartTime.Text) = "<NONE>" Then
      m_strStartTime = ""
    Else
      If IsNull(GetFieldValue(pFeature, frmExporttoKMLOptions.cboStartTime.Text)) = False Then
        m_strStartTime = Trim(CStr(GetFieldValue(pFeature, frmExporttoKMLOptions.cboStartTime.Text)))
        If frmExporttoKMLOptions.chkFormatDateTime.Value = vbChecked Then
          m_strStartTime = FormatKMLDateTime(m_strStartTime)
        End If
      Else
        m_strStartTime = ""
      End If
    End If

    ' end time
    If Trim(frmExporttoKMLOptions.cboEndTime.Text) = "<NONE>" Then
      m_strEndTime = ""
    Else
      If IsNull(GetFieldValue(pFeature, frmExporttoKMLOptions.cboEndTime.Text)) = False Then
        m_strEndTime = Trim(CStr(GetFieldValue(pFeature, frmExporttoKMLOptions.cboEndTime.Text)))
        If frmExporttoKMLOptions.chkFormatDateTime.Value = vbChecked Then
          m_strEndTime = FormatKMLDateTime(m_strEndTime)
        End If
      Else
        m_strEndTime = ""
      End If
    End If
  End If
  
  ' write out folder tags for feature
  If m_boolExporttheFeature = True Then
    If m_strGroupName <> "" Then
      If m_strGroupName <> m_strPreviousGroupName Or m_lngFeatCount = 1 Then
        If m_lngFeatCount > 1 Then
          Print #1, "     </Folder>"
        End If
        Print #1, "     <Folder>"
        Print #1, "       <name>" & CleanXMLString(m_strGroupName, True) & "</name>"
      End If
    End If
  End If
End Sub

Private Sub WriteOutLabels(aLabelName As String, aStartTime As String, aEndTime As String, aLabelStyle As String, aXYZCoord As String)
  Print #1, "      <Placemark>"
  Print #1, "        <name>" & CleanXMLString(aLabelName, True) & "</name>"
  If m_boolAddTimeStamps = True Then
    Print #1, "         <TimeSpan>"
    Print #1, "           <begin>" & CleanXMLString(aStartTime, True) & "</begin>"
    Print #1, "           <end>" & CleanXMLString(aEndTime, True) & "</end>"
    Print #1, "         </TimeSpan>"
  End If
  If m_boolUseArcMapSymbology = True Then
    Print #1, "        <styleUrl>#" & CleanXMLString(aLabelStyle, False) & "</styleUrl>"
  Else
    Print #1, "        <styleUrl>#" & "FEATURES_LABELS" & "</styleUrl>"
  End If
  Print #1, "        <Point>"
  Print #1, "          <extrude>" & CStr(m_intLabelExtrusion) & "</extrude>"
  Print #1, "          <altitudeMode>" & m_strAltitudeModeLabels & "</altitudeMode>"
  Print #1, "          <coordinates>"
  Print #1, aXYZCoord
  Print #1, "          </coordinates>"
  Print #1, "        </Point>"
  Print #1, "      </Placemark>"
End Sub

Private Sub WriteOutLabelStyles(aLabelStyleName As String, aLabelColor As String)
  Print #1, "  <Style id=" & Chr(34) & CleanXMLString(aLabelStyleName, False) & Chr(34) & ">"
  Print #1, "    <IconStyle>"
  Print #1, "      <color>00000000</color>"
  Print #1, "      <Icon>"
  Print #1, "        <href>http://maps.google.com/mapfiles/kml/shapes/placemark_circle.png</href>"
  Print #1, "      </Icon>"
  Print #1, "    </IconStyle>"
  Print #1, "    <LabelStyle>"
  Print #1, "      <color>" & aLabelColor & "</color>"
  Print #1, "    </LabelStyle>"
  Print #1, "  </Style>"
End Sub

Private Sub WriteOutInfoPoints(anInfoPointName As String, aStartTime As String, aEndTime As String, anInfoPointSchema() As String, aXYZCoord As String)
  Print #1, "      <Placemark>"
  Print #1, "        <name>" & CleanXMLString(anInfoPointName, True) & "</name>"
  Print #1, "        <Snippet maxLines=""0""></Snippet>"
  Print #1, "        <styleUrl>#" & "INFO_POINTS" & "</styleUrl>"
  Print #1, "         <ExtendedData>"
  If m_boolUseUnTypedData = True Then
    For m_lngCount = 1 To UBound(anInfoPointSchema)
      Print #1, "            " & anInfoPointSchema(m_lngCount)
    Next m_lngCount
  Else
    Print #1, "           <SchemaData schemaUrl=""#" & m_strKMLSchemaName & "_schema""" & ">"
    For m_lngCount = 1 To UBound(anInfoPointSchema)
      Print #1, "            " & anInfoPointSchema(m_lngCount)
    Next m_lngCount
    Print #1, "           </SchemaData>"
  End If
  Print #1, "         </ExtendedData>"
  If m_boolAddTimeStamps = True Then
    Print #1, "         <TimeSpan>"
    Print #1, "           <begin>" & CleanXMLString(aStartTime, True) & "</begin>"
    Print #1, "           <end>" & CleanXMLString(aEndTime, True) & "</end>"
    Print #1, "         </TimeSpan>"
  End If
  Print #1, "        <Point>"
  Print #1, "          <extrude>" & CStr(m_intInfoPtExtrusion) & "</extrude>"
  Print #1, "          <altitudeMode>" & m_strAltitudeModeInfoPts & "</altitudeMode>"
  Print #1, "          <coordinates>"
  Print #1, aXYZCoord
  Print #1, "          </coordinates>"
  Print #1, "        </Point>"
  Print #1, "      </Placemark>"
End Sub

Private Sub WriteOutInfoPointStyles()
  Dim strInfoPointTrans As String
  strInfoPointTrans = "25"
  strInfoPointTrans = CStr(Hex(((100 - CSng(strInfoPointTrans)) / 100) * 255))
  Print #1, "  <Style id=" & Chr(34) & "INFO_POINTS" & Chr(34) & ">"
  Print #1, "    <IconStyle>"
  Print #1, "      <color>" & strInfoPointTrans & "FFFFFF</color>"
  Print #1, "      <scale>0.5</scale>"
  Print #1, "      <Icon>"
  Print #1, "        <href>http://maps.google.com/mapfiles/kml/shapes/info.png</href>"
  Print #1, "      </Icon>"
  Print #1, "      <hotSpot x=" & Chr(34) & "0.5" & Chr(34) & " y=" & Chr(34) & "0.5" & Chr(34) & " xunits=" & Chr(34) & "fraction" & Chr(34) & " yunits=" & Chr(34) & "fraction" & Chr(34) & "/>"
  Print #1, "    </IconStyle>"
  Print #1, "    <LabelStyle>"
  Print #1, "      <color>" & "00000000" & "</color>"
  Print #1, "    </LabelStyle>"
  If m_boolGoogleMapsCompatible = False Then
    Print #1, "    <BalloonStyle>"
    Print #1, "      <text>" & CleanXMLString(m_strFeatureDescription, True) & "</text>"
    Print #1, "    </BalloonStyle>"
  End If
  Print #1, "  </Style>"
End Sub

Public Sub WriteoutFeatureStyles(aFeatureType As String)
  
  ' dimension variables for storing renderer symbols
  Dim pSymbol As esriDisplay.ISymbol
  Dim pMarkerSymbol As esriDisplay.IMarkerSymbol
  Dim pLineSymbol As esriDisplay.ILineSymbol
  Dim pFillSymbol As esriDisplay.IFillSymbol
  
  ' dimension variables for storing style element info
  Dim strHexColor As String
  Dim strHexLabelColor As String
  Dim strHexLineColor As String
  Dim strLineWidth As String
  Dim strMarkerSize As String
  Dim strMarkerScale As String
  Dim boolNoFill As Boolean
  Dim boolNoOutline As Boolean
  
  ' set default style variables
  strHexLabelColor = "FFFFFFFF"
  strMarkerSize = "32"
  strMarkerScale = "1"
  strLineWidth = "1"
  strHexLineColor = "FF000000"
  
  ' loop through styles and get symbol information
  For m_lngGroupCount = 0 To UBound(m_strKMLStyles)
  
    ' get the group name
    m_strStyleName = m_strKMLStyles(m_lngGroupCount)

    ' point styles -------
    If aFeatureType = "POINT" Then
    
      ' get the marker symbol
      If chkUseLayerSymbology.Value = vbChecked Then
        Set pMarkerSymbol = GetSymbolfromRenderer(m_strStyleName, m_lngGroupCount) 'QI
      Else
        Set pMarkerSymbol = Nothing
      End If
      
      ' get the symbol color
      If Not pMarkerSymbol Is Nothing Then
        strHexColor = ConvertRGBtoHex(pMarkerSymbol.Color, m_strTransparency)
        strMarkerScale = CStr(pMarkerSymbol.Size / 12)  ' 12 points is the estimate default GE marker size
      Else
        strHexColor = GenerateRandomColor(m_strTransparency)
      End If
      
      ' write out the KML style for each group
      Print #1, "  <Style id=" & Chr(34) & CleanXMLString(m_strStyleName, False) & Chr(34) & ">"
      Print #1, "    <IconStyle>"
      Print #1, "      <color>" & strHexColor & "</color>"
      Print #1, "      <scale>" & strMarkerScale & "</scale>"
      Print #1, "      <Icon>"
      Print #1, "        <href>root://icons/palette-4.png</href>"
      Print #1, "        <x>32</x>"
      Print #1, "        <y>128</y>"
      Print #1, "        <w>" & strMarkerSize & "</w>"
      Print #1, "        <h>" & strMarkerSize & "</h>"
      Print #1, "      </Icon>"
      Print #1, "    </IconStyle>"
      Print #1, "    <LabelStyle>"
      If m_boolLabelFeatures = True Then
        If frmExporttoKMLOptions.chkExportSeparateLabels = vbChecked Then
          Print #1, "      <color>" & "00FFFFFF" & "</color>"
        Else
          Print #1, "      <color>" & strHexLabelColor & "</color>"
        End If
      Else
        Print #1, "      <color>" & "00FFFFFF" & "</color>"
      End If
      Print #1, "    </LabelStyle>"
      If m_boolGoogleMapsCompatible = False Then
        Print #1, "    <BalloonStyle>"
        Print #1, "      <text>"
        If Trim(m_strFeatureDescription) <> "" Then
          Print #1, CleanXMLString(m_strFeatureDescription, True)
        End If
        Print #1, "      </text>"
        Print #1, "    </BalloonStyle>"
      End If
      Print #1, "  </Style>"
      
    ' polyline syles -------
    ElseIf aFeatureType = "POLYLINE" Then
      
      ' get the group name
      m_strStyleName = m_strKMLStyles(m_lngGroupCount)

      ' get the line symbol
      If chkUseLayerSymbology.Value = vbChecked Then
        Set pLineSymbol = GetSymbolfromRenderer(m_strStyleName, m_lngGroupCount) 'QI
      Else
        Set pLineSymbol = Nothing
      End If
      
      ' get the symbol color
      If Not pLineSymbol Is Nothing Then
        strHexColor = ConvertRGBtoHex(pLineSymbol.Color, m_strTransparency)
        strLineWidth = CStr(pLineSymbol.Width)
      Else
        strHexColor = GenerateRandomColor(m_strTransparency)
      End If
    
      ' write out the KML style for each group
      Print #1, "  <Style id=" & Chr(34) & CleanXMLString(m_strStyleName, False) & Chr(34) & ">"
      Print #1, "    <LineStyle>"
      Print #1, "      <color>" & strHexColor & "</color>"
      Print #1, "      <width>" & strLineWidth & "</width>"
      Print #1, "    </LineStyle>"
      If m_boolGoogleMapsCompatible = False Then
        Print #1, "    <BalloonStyle>"
        Print #1, "      <text>"
        Print #1, CleanXMLString(m_strFeatureDescription, True)
        Print #1, "      </text>"
        Print #1, "    </BalloonStyle>"
      End If
      Print #1, "  </Style>"
    
    ' polygon styles  -------
    ElseIf aFeatureType = "POLYGON" Then
      
      ' get the group name
      m_strStyleName = m_strKMLStyles(m_lngGroupCount)

      ' get the fill symbol
      If chkUseLayerSymbology.Value = vbChecked Then
        Set pFillSymbol = GetSymbolfromRenderer(m_strStyleName, m_lngGroupCount) 'QI
      Else
        Set pFillSymbol = Nothing
      End If
      
      ' determine whether to display fill/outline
      If Not pFillSymbol Is Nothing Then
        boolNoFill = False
        boolNoOutline = False
        If pFillSymbol.Color.NullColor = True Then
          boolNoFill = True
        End If
        If pFillSymbol.Outline.Color.NullColor = True Or pFillSymbol.Outline.Width = 0 Then
          boolNoOutline = True
        End If
    
        ' get the symbol colors
        strHexColor = ConvertRGBtoHex(pFillSymbol.Color, m_strTransparency)
        strHexLineColor = ConvertRGBtoHex(pFillSymbol.Outline.Color, m_strTransparency)
        strLineWidth = CStr(pFillSymbol.Outline.Width)
      Else
        strHexColor = GenerateRandomColor(m_strTransparency)
      End If
      
      ' write out the KML style for each group
      Print #1, "  <Style id=" & Chr(34) & CleanXMLString(m_strStyleName, False) & Chr(34) & ">"
      Print #1, "    <LineStyle>"
      Print #1, "      <color>" & strHexLineColor & "</color>"
      Print #1, "      <width>" & strLineWidth & "</width>"
      Print #1, "    </LineStyle>"
      Print #1, "    <PolyStyle>"
      If boolNoOutline = True Then
        Print #1, "      <outline>0</outline>"
      Else
        Print #1, "      <outline>1</outline>"
      End If
      If boolNoFill = True Then
        Print #1, "      <fill>0</fill>"
      Else
        Print #1, "      <fill>1</fill>"
        Print #1, "      <color>" & strHexColor & "</color>"
      End If
      Print #1, "    </PolyStyle>"
      If m_boolGoogleMapsCompatible = False Then
        Print #1, "    <BalloonStyle>"
        Print #1, "      <text>"
        Print #1, CleanXMLString(m_strFeatureDescription, True)
        Print #1, "      </text>"
        Print #1, "    </BalloonStyle>"
      End If
      Print #1, "  </Style>"
      
    ' handle non-supported shape types
    Else
      MsgBox "The specified layer does not contain POINT, POLYLINE, or POLYGON features." _
      & "You can not export this layer.", vbCritical, "Export to Google Earth KML"
      m_pStatusBar.HideProgressBar
      Unload frmExporttoKMLOptions
      Unload frmExporttoKML
      Exit Sub
    End If
    
    ' write out the KML label style for each group
    If m_boolLabelFeatures = True Then
      m_strLabelStyleName = m_strStyleName & "_LABELS"
      If frmExporttoKMLOptions.chkColorLabels = vbChecked Then
        strHexLabelColor = strHexColor
      End If
      WriteOutLabelStyles m_strLabelStyleName, strHexLabelColor
    End If
  Next m_lngGroupCount
  
  ' write out info points style
  If Not aFeatureType = "POINT" Then
    If frmExporttoKMLOptions.chkCreateInfoPoints = vbChecked Then
      WriteOutInfoPointStyles
    End If
  End If
End Sub

Public Function ReplaceNumericCommas(aNumericString As String) As String
  ReplaceNumericCommas = Replace(aNumericString, ",", ".")
End Function

Public Sub RecordInfoPointInformation(aInfoPoint As esriGeometry.IPoint, aZCoord As String, aFeatureName As String, aFeatureSchema() As String)

  ' get the feature layer
  Dim pFLayer As esricarto.IFeatureLayer2
  Set pFLayer = g_pInputLayer  'QI

  ' add info point offset if necessary
  Dim dblInfoPtZCoord As Double
  If CDbl(frmExporttoKMLOptions.txtInfoPtOffsetManual.Text) > 0 Then
    dblInfoPtZCoord = aZCoord + (CDbl(frmExporttoKMLOptions.txtInfoPtOffsetManual.Text) * m_sglUnitConversion)
  Else
    dblInfoPtZCoord = aZCoord
  End If
   
  ' record the X/Y/Z coordinates of each information point
  m_strXCoord = CStr(aInfoPoint.X)
  m_strYCoord = CStr(aInfoPoint.Y)
  m_strXCoord = ReplaceNumericCommas(m_strXCoord)
  m_strYCoord = ReplaceNumericCommas(m_strYCoord)
  ReDim Preserve m_strInfoPointXYZs(UBound(m_strInfoPointXYZs) + 1)
  m_strInfoPointXYZs(UBound(m_strInfoPointXYZs)) = "            " & m_strXCoord & "," & m_strYCoord & "," & dblInfoPtZCoord
  
  ' record the info point name and description
  ReDim Preserve m_strFeatureNames(UBound(m_strFeatureNames) + 1)
  m_strFeatureNames(UBound(m_strFeatureNames)) = aFeatureName
  ReDim Preserve m_strFeatureSchemas(UBound(aFeatureSchema), (UBound(m_strFeatureSchemas, 2) + 1))
  For m_lngCount = 1 To UBound(aFeatureSchema)
    m_strFeatureSchemas(m_lngCount, UBound(m_strFeatureSchemas, 2)) = aFeatureSchema(m_lngCount)
  Next m_lngCount
End Sub

Public Sub RecordLabelInformation(aFeature As esriGeoDatabase.IFeature, aLabelPoint As _
esriGeometry.IPoint, aZCoord As String, aStyleName As String)

   ' set label style name
   ReDim Preserve m_strLabelStyleNames(UBound(m_strLabelStyleNames) + 1)
   m_strLabelStyleNames(UBound(m_strLabelStyleNames)) = aStyleName & "_LABELS"
  
   ' record the label feature name
   If IsNull(GetFieldValue(aFeature, cboLabelAttribute.Text)) = False Then
     m_strFeatureName = Trim(CStr(GetFieldValue(aFeature, cboLabelAttribute.Text)))
     If m_strFeatureName = "" Then
       If frmExporttoKMLOptions.chkLabelNullValues = vbChecked Then
         m_strFeatureName = "<Null>"
       Else
         m_strFeatureName = ""
       End If
     End If
   Else
     If frmExporttoKMLOptions.chkLabelNullValues = vbChecked Then
       m_strFeatureName = "<Null>"
     Else
       m_strFeatureName = ""
     End If
   End If
   ReDim Preserve m_strLabelNames(UBound(m_strLabelNames) + 1)
   m_strLabelNames(UBound(m_strLabelNames)) = m_strFeatureName
   
   ' add label offset if necessary
   Dim dblLabelZCoord As Double
   If CDbl(frmExporttoKMLOptions.txtLabelOffsetManual.Text) > 0 Then
     dblLabelZCoord = aZCoord + (CDbl(frmExporttoKMLOptions.txtLabelOffsetManual.Text) * m_sglUnitConversion)
   Else
     dblLabelZCoord = aZCoord
   End If
    
   ' record the X/Y/Z coordinates of each label point
   m_strXCoord = CStr(aLabelPoint.X)
   m_strYCoord = CStr(aLabelPoint.Y)
   m_strXCoord = ReplaceNumericCommas(m_strXCoord)
   m_strYCoord = ReplaceNumericCommas(m_strYCoord)
   ReDim Preserve m_strLabelXYZs(UBound(m_strLabelXYZs) + 1)
   m_strLabelXYZs(UBound(m_strLabelXYZs)) = "            " & m_strXCoord & "," & m_strYCoord & "," & dblLabelZCoord
End Sub

'Private Sub UserForm_Activate() 'VBA
Private Sub Form_Activate() 'VB
  Set m_pMxDocument = m_pApplication.Document
  Set m_pMap = m_pMxDocument.FocusMap
End Sub

Public Function DensifyTrueCurves(aFeature As esriGeoDatabase.IFeature) As esriGeometry.IGeometry4
  ' dimension variables
  Dim pGeometry2 As esriGeometry.IGeometry4
  Dim pGeomCollection As esriGeometry.IGeometryCollection
  Dim pSegment As esriGeometry.ISegment
  Dim pSegmentCollection As esriGeometry.ISegmentCollection
  Dim pTempPolyline As esriGeometry.IPolyline4
  Dim pTempSegment As esriGeometry.ISegment
  Dim pTempSegmentCollection As esriGeometry.ISegmentCollection
  Dim pFinalPolyline As esriGeometry.IPolyline4
  Dim pFinalPolygon As esriGeometry.IPolygon4
  Dim pFinalSegmentCollection As esriGeometry.ISegmentCollection
  Dim lngGeomNum As Long
  Dim lngSegNum As Long
  Dim lngDensSegNum As Long
  Dim boolGeometryDensified As Boolean
  
  ' get the geometry collection
  boolGeometryDensified = False
  Set pGeometry2 = aFeature.Shape
  Set pGeomCollection = pGeometry2  'QI
  
  ' create objects for storing the final geometry
  If pGeometry2.GeometryType = esriGeometryPolygon Then
    Set pFinalPolygon = New esriGeometry.Polygon
    Set pFinalSegmentCollection = pFinalPolygon
  Else
    Set pFinalPolyline = New esriGeometry.Polyline
    Set pFinalSegmentCollection = pFinalPolyline
  End If
  
  ' loop through geometry and get segment collections
  For lngGeomNum = 0 To pGeomCollection.GeometryCount - 1
    Set pSegmentCollection = pGeomCollection.Geometry(lngGeomNum)
    
    ' loop through segment collections and get segments
    For lngSegNum = 0 To pSegmentCollection.SegmentCount - 1
      Set pSegment = pSegmentCollection.Segment(lngSegNum)
      
      ' check for non-line segment geometries
      If pSegment.GeometryType <> esriGeometryLine Then
        Set pTempPolyline = New esriGeometry.Polyline
        Set pTempSegmentCollection = pTempPolyline
        pTempSegmentCollection.AddSegment pSegment
        pTempPolyline.Densify pSegment.Length / 100, 0
        For lngDensSegNum = 0 To pTempSegmentCollection.SegmentCount - 1
          Set pTempSegment = pTempSegmentCollection.Segment(lngDensSegNum)
          pFinalSegmentCollection.AddSegment pTempSegment
        Next lngDensSegNum
        boolGeometryDensified = True
      Else
        pFinalSegmentCollection.AddSegment pSegment
      End If
    Next lngSegNum
  Next lngGeomNum
  
  ' return the geometry to call
  If boolGeometryDensified = True Then
    If pGeometry2.GeometryType = esriGeometryPolygon Then
      Set DensifyTrueCurves = pFinalPolygon
    Else
      Set DensifyTrueCurves = pFinalPolyline
    End If
  Else
    Set DensifyTrueCurves = aFeature.Shape
  End If
End Function

Public Function BrowsetoFile(strFileType As String, strFileTypeDescription As String, boolOpenFile As Boolean) As String
  ' specify output location & filename
  Dim pGxDialog As esriCatalogUI.IGxDialog
  Set pGxDialog = New esriCatalogUI.GxDialog
  
  ' set up a custom file type
  Dim pFileFilter As esricatalog.IGxFileFilter
  Dim pCat As esricatalog.IGxCatalog
  Set pCat = pGxDialog.InternalCatalog
  Set pFileFilter = pCat.FileFilter
  If (pCat.FileFilter.FindFileType(strFileType) = -1) Then
    pFileFilter.AddFileType strFileType, strFileTypeDescription, ""
  End If
   
  ' apply a file object filter
  Dim pObjectFilter As clsCustomGXFilter  ' custom IGXObjectFilter
  Set pObjectFilter = New clsCustomGXFilter
  pObjectFilter.FileTypeExtension = strFileType
  pObjectFilter.FileTypeDescription = strFileTypeDescription
  Set pGxDialog.ObjectFilter = pObjectFilter
    
  ' get a file using the GX dialog
  Dim pGxObj As esricatalog.IGxObject
  Dim pGxFile As esricatalog.IGxFile
  Dim pEnumGx As esricatalog.IEnumGxObject
  If boolOpenFile = True Then
    pGxDialog.Title = "Open " & strFileTypeDescription & " file..."
    If Not pGxDialog.DoModalOpen(Me.hWnd, pEnumGx) = True Then
      Exit Function
    End If
    BrowsetoFile = pEnumGx.Next.FullName
  Else
    pGxDialog.Title = "Save " & strFileTypeDescription & " as..."
    If Not pGxDialog.DoModalSave(Me.hWnd) = True Then
      Exit Function
    End If
    Set pGxObj = pGxDialog.FinalLocation
    Set pGxFile = pGxObj
    
    ' get information from GX object
    Dim strOutFileName As String
    Dim strOutWorkspacePath As String
    strOutFileName = pGxDialog.Name
    strOutWorkspacePath = pGxFile.Path
    
    ' make sure output is a file of the specified type
    If Not InStr(VBA.UCase(strOutFileName), "." & VBA.UCase(strFileType)) > 0 Then
      strOutFileName = strOutFileName & "." & VBA.LCase(strFileType)
    End If
    
    ' populate text box
    If VBA.Right(strOutWorkspacePath, 1) <> "\" Then
      BrowsetoFile = strOutWorkspacePath & "\" & strOutFileName
    Else
      BrowsetoFile = strOutWorkspacePath & strOutFileName
    End If
  End If
  
  ' clean up all variables
  Set pGxDialog = Nothing
  Set pFileFilter = Nothing
  Set pCat = Nothing
  Set pGxObj = Nothing
  Set pGxFile = Nothing
End Function

'Private Sub UserForm_Terminate() 'VBA
Private Sub Form_Unload(Cancel As Integer) 'VB
  ' clean up object variables
  Set g_pInputLayer = Nothing
  Set g_pLayerSymbolField = Nothing
  Set m_pApplication = Nothing
  Set m_pMxDocument = Nothing
  Set m_pMap = Nothing
  Set m_pStatusBar = Nothing
  Set m_pProgressBar = Nothing
  Set m_pSpRefInput = Nothing
  Set m_pSpRefOutput = Nothing
  Set m_pOutputGeoTransformation = Nothing
  Set m_pGFLayerRenderer = Nothing
  Set m_pUniqueValueRenderer = Nothing
  Set m_pClassBreaksRenderer = Nothing
  Set m_pSimpleRenderer = Nothing
  Set m_pDBFields = Nothing
  Set m_pMouseCursor = Nothing
  
  ' clean up arrays
  Erase m_strLabelNames
  Erase m_strFeatureNames
  Erase m_strFeatureSchema
  Erase m_strFeatureSchemas
  Erase m_strKMLStyles
  Erase m_strLabelStyleNames
  Erase m_strLabelXYZs
  Erase m_strInfoPointXYZs
  Erase m_strStartTimes
  Erase m_strEndTimes
  
  ' clean up other variables
  g_boolFeatureNameAttributeManuallySet = False
  g_boolExportSeparateLabels = False
  g_strGCSTransformation = ""
  m_strNextKMLLine = ""
  m_boolSpRefEqual = False
  m_boolPerformGCSTransform = False
  m_strTransparency = ""
  m_boolUseArcMapSymbology = False
  m_strLayerRendererHeading = ""
  m_boolClassBreaksAscending = False
  m_intClassBreakIndex = 0
  m_strFeatureValue = ""
  m_lngFeatCount = 0
  m_boolExporttheFeature = False
  m_strStyleName = ""
  m_strLabelStyleName = ""
  m_strGroupName = ""
  m_strPreviousGroupName = ""
  m_lngGroupCount = 0
  m_boolGroupExists = False
  m_boolLabelFeatures = False
  m_strFeatureSnippet = ""
  m_strFeatureDescription = ""
  m_intSchemaFieldCount = 0
  m_strFeatureName = ""
  m_strKMLSchemaName = ""
  m_intExtrusion = 0
  m_intTessellate = 0
  m_strAltitudeMode = ""
  m_intLabelExtrusion = 0
  m_intInfoPtExtrusion = 0
  m_strXCoord = ""
  m_strYCoord = ""
  m_strZCoord = ""
  m_dblZCoord = 0
  m_dblOffsetValue = 0
  m_strOffsetValue = ""
  m_sglUnitConversion = 0
  m_boolIs3DShape = False
  m_boolIs3DAttribute = False
  m_lngCount = 0
  m_boolAddTimeStamps = False
  m_strStartTime = ""
  m_strEndTime = ""
End Sub

Public Function FormatKMLDateTime(strDateTime As String) As String
  Dim strDate As String
  Dim strTime As String
  Dim strMonth As String
  Dim strDay As String
  Dim strYear As String
  Dim strHour As String
  Dim strMinSec As String
  
  ' extract the separate date and time from the attribute string
  If VBA.InStr(strDateTime, " ") > 0 Then
    strDate = VBA.Left(strDateTime, (VBA.InStr(strDateTime, " ") - 1))
    strTime = VBA.Replace(strDateTime, strDate & " ", "")
  ElseIf VBA.InStr(strDateTime, "T") > 0 Then
    strDate = VBA.Left(strDateTime, (VBA.InStr(strDateTime, "T") - 1))
    strTime = VBA.Replace(strDateTime, strDate & "T", "")
  Else
    strDate = strDateTime
    strTime = ""
  End If
  
  ' format delineators
  strDate = VBA.Replace(strDate, "/", "-")
  strDate = VBA.Replace(strDate, ".", "-")
  If strDate <> strDateTime Then
    strDate = VBA.Replace(strDate, ":", "-")
  End If
  
  ' format the date if entered in MM-DD-YYYY format
  If strDate Like "##-*#-####" Or strDate Like "#-*#-####" Then
    strYear = VBA.Right(strDate, 4)
    strMonth = VBA.Left(strDate, (VBA.InStr(strDate, "-") - 1))
    strDay = VBA.Mid(strDate, (VBA.Len(strMonth) + 2))
    strDay = VBA.Left(strDay, (VBA.InStr(strDay, "-") - 1))
    If VBA.Len(strMonth) = 1 Then
      strMonth = "0" & strMonth
    End If
    If VBA.Len(strDay) = 1 Then
      strDay = "0" & strDay
    End If
    strDate = strYear & "-" & strMonth & "-" & strDay
  ElseIf strDate Like "##-*#-##" Or strDate Like "#-*#-##" Then
    strYear = VBA.Right(strDate, 2)
    strMonth = VBA.Left(strDate, (VBA.InStr(strDate, "-") - 1))
    strDay = VBA.Mid(strDate, (VBA.Len(strMonth) + 2))
    strDay = VBA.Left(strDay, (VBA.InStr(strDay, "-") - 1))
    strYear = VBA.CStr(2000 + VBA.CInt(strYear))
    If VBA.CInt(strYear) > (VBA.Year(VBA.Date) + 50) Then
      strYear = VBA.CStr(CInt(strYear) - 100)
    End If
    If VBA.Len(strMonth) = 1 Then
      strMonth = "0" & strMonth
    End If
    If VBA.Len(strDay) = 1 Then
      strDay = "0" & strDay
    End If
    strDate = strYear & "-" & strMonth & "-" & strDay
  ElseIf strDate Like "##-####" Or strDate Like "#-####" Then
    strYear = VBA.Right(strDate, 4)
    strMonth = VBA.Left(strDate, (VBA.InStr(strDate, "-") - 1))
    If VBA.Len(strMonth) = 1 Then
      strMonth = "0" & strMonth
    End If
    strDate = strYear & "-" & strMonth
  ElseIf strDate Like "##-##" Or strDate Like "#-##" Then
    strYear = VBA.Right(strDate, 2)
    strMonth = VBA.Left(strDate, (VBA.InStr(strDate, "-") - 1))
    strYear = VBA.CStr(2000 + CInt(strYear))
    If VBA.CInt(strYear) > (VBA.Year(VBA.Date) + 50) Then
      strYear = VBA.CStr(CInt(strYear) - 100)
    End If
    If VBA.Len(strMonth) = 1 Then
      strMonth = "0" & strMonth
    End If
    strDate = strYear & "-" & strMonth
  ElseIf strDate Like "*:*" Then
    strTime = strDate
    strDate = ""
  End If
  
  ' format the date if entered in YYYY-MM-DD format
  If strDate Like "####-#-##" Or strDate Like "####-##-#" Or strDate Like "####-#-#" Then
    strYear = VBA.Left(strDate, 4)
    strDay = VBA.Right(strDate, VBA.Len(strDate) - VBA.InStrRev(strDate, "-"))
    strMonth = VBA.Mid(strDate, (VBA.Len(strYear) + 2))
    strMonth = VBA.Left(strMonth, (VBA.InStr(strMonth, "-") - 1))
    If VBA.Len(strMonth) = 1 Then
      strMonth = "0" & strMonth
    End If
    If VBA.Len(strDay) = 1 Then
      strDay = "0" & strDay
    End If
    strDate = strYear & "-" & strMonth & "-" & strDay
  ElseIf strDate Like "####-#" Then
    strYear = VBA.Left(strDate, 4)
    strMonth = VBA.Right(strDate, VBA.Len(strDate) - VBA.InStrRev(strDate, "-"))
    strMonth = "0" & strMonth
    strDate = strYear & "-" & strMonth
  End If
  
  ' format the time
  If strTime <> "" Then
    If VBA.InStr(strTime, ":") > 0 Then
      strHour = VBA.Left(strTime, (VBA.InStr(strTime, ":") - 1))
      strMinSec = Mid(strTime, (VBA.Len(strHour) + 2))
      strMinSec = VBA.Replace(strMinSec, "PM", "")
      strMinSec = VBA.Replace(strMinSec, "AM", "")
      strMinSec = VBA.Replace(strMinSec, " ", "")
      If VBA.InStr(strMinSec, ":") = 0 Then
        strMinSec = strMinSec & ":00"
      End If
      If strTime Like "*PM" Then
        strHour = VBA.CStr(VBA.CInt(strHour) + 12)
      End If
      If VBA.Len(strHour) < 2 Then
        strHour = "0" & strHour
      End If
      strTime = "T" & strHour & ":" & strMinSec & "Z"
    Else
      strTime = ""
    End If
  End If
  
  ' combine the formatted date and time
  FormatKMLDateTime = strDate & strTime
End Function

Public Function GetFeatureLabelPoint(strFeatureType As String, aGeometry As esriGeometry.IGeometry) As esriGeometry.IPoint
    ' get the point/midpoint/centroid based on the layer geometry
    Dim pCurve As esriGeometry.ICurve
    Dim pArea As esriGeometry.IArea
    Dim pPoint As esriGeometry.IPoint
    Set pPoint = New esriGeometry.Point
    If strFeatureType = "POINT" Then
      Set pPoint = aGeometry
    ElseIf strFeatureType = "POLYLINE" Then
      Set pCurve = aGeometry  'QI
      pCurve.QueryPoint esriNoExtension, 0.5, True, pPoint
    ElseIf strFeatureType = "POLYGON" Then
      Set pArea = aGeometry  'QI
      If frmExporttoKMLOptions.chkForcePointsInside.Value = vbChecked Then
        On Error Resume Next 'handles errors caused by IArea interface
        pArea.QueryLabelPoint pPoint
        If pPoint.IsEmpty = True Then
          Set pPoint = pArea.Centroid
        End If
      Else
        Set pPoint = pArea.Centroid
      End If
    End If
    Set GetFeatureLabelPoint = pPoint
End Function

Public Sub RecordTimeStampInformation(strStartTime As String, strEndTime As String)
  ReDim Preserve m_strStartTimes(UBound(m_strStartTimes) + 1)
  m_strStartTimes(UBound(m_strStartTimes)) = strStartTime
  ReDim Preserve m_strEndTimes(UBound(m_strEndTimes) + 1)
  m_strEndTimes(UBound(m_strEndTimes)) = strEndTime
End Sub

Private Sub AddItemtoExportSchema(strAttribute As String)
  ' verifies attribute is included in exported schema
  Dim intCurrent As Integer
  Dim boolDuplicate As Boolean
  boolDuplicate = False
  frmExporttoKMLOptions.chkExportSchema.Value = vbChecked
  frmExporttoKMLOptions.chkExportSchema.Enabled = True
      
  ' makes sure item is not already in list
  If frmExporttoKMLOptions.lstTableAttributesExport.ListCount > 0 Then
    For intCurrent = 0 To frmExporttoKMLOptions.lstTableAttributesExport.ListCount - 1
      If frmExporttoKMLOptions.lstTableAttributesExport.List(intCurrent) = strAttribute Then
        boolDuplicate = True
      End If
    Next intCurrent
  End If
    
  ' adds item if item is not duplicated
  If boolDuplicate = False Then
    frmExporttoKMLOptions.lstTableAttributesExport.AddItem strAttribute
  End If
End Sub

Public Function GetGCTransformations(pSRFrom As esriGeometry.ISpatialReference, pSRTo As esriGeometry.ISpatialReference) As Collection
  ' dimension variables
  Dim pSRFact2 As esriGeometry.ISpatialReferenceFactory2
  Dim pGTSet As esriSystem.ISet
  Dim pProjectedCoordSys As esriGeometry.IProjectedCoordinateSystem
  Dim pGeoTransformation As esriGeometry.IGeoTransformation
  Dim pGTSRFrom As esriGeometry.ISpatialReference
  Dim pGTSRTo As esriGeometry.ISpatialReference
  Dim lngFromFactoryCode As Long
  Dim lngToFactoryCode As Long
  Dim lngCount As Long
  Set pSRFact2 = New esriGeometry.SpatialReferenceEnvironment
  Set pGTSet = pSRFact2.CreatePredefinedGeographicTransformations
  Set GetGCTransformations = New Collection
  pGTSet.Reset
  
  ' check if the "from" coordinate system is projected
  If TypeOf pSRFrom Is esriGeometry.IProjectedCoordinateSystem Then
    Set pProjectedCoordSys = pSRFrom
    lngFromFactoryCode = pProjectedCoordSys.GeographicCoordinateSystem.FactoryCode
  Else
    lngFromFactoryCode = pSRFrom.FactoryCode
  End If
  
  ' check if the "to" coordinate system is projected
  If TypeOf pSRTo Is esriGeometry.IProjectedCoordinateSystem Then
    Set pProjectedCoordSys = pSRTo
    lngToFactoryCode = pProjectedCoordSys.GeographicCoordinateSystem.FactoryCode
  Else
    lngToFactoryCode = pSRTo.FactoryCode
  End If
  
  ' build the collection of potential transformations from the master ESRI list
  For lngCount = 0 To pGTSet.Count - 1
    Set pGeoTransformation = pGTSet.Next
    pGeoTransformation.GetSpatialReferences pGTSRFrom, pGTSRTo
    If pGTSRFrom.FactoryCode = lngFromFactoryCode And pGTSRTo.FactoryCode = lngToFactoryCode Then
      GetGCTransformations.Add pGeoTransformation
    End If
  Next lngCount
End Function

' "BUSY" MOUSE CURSOR
' 5/16/2005
' Description: temporarily changes the mouse cursor to an hourglass
' Procedure Type: Sub
' Called by: ThisDocument
' Calls: None

Public Sub BusyMouse(bolBusy As Boolean)
  If m_pMouseCursor Is Nothing Then
    Set m_pMouseCursor = New MouseCursor
  End If
  If bolBusy Then
    m_pMouseCursor.SetCursor 2
  Else
    m_pMouseCursor.SetCursor 0
  End If
End Sub

Private Function GetFieldValue(aFeature As esriGeoDatabase.IFeature, aFieldAliasName As String) As Variant
    Dim pField As esriGeoDatabase.IField
    Dim pDomain As esriGeoDatabase.IDomain
    Dim pCodedDomain As esriGeoDatabase.ICodedValueDomain
    Dim intFieldIndex As Integer
    Dim intCount As Integer
    intFieldIndex = m_pDBFields.FindFieldByAliasName(aFieldAliasName)
    Set pField = m_pDBFields.Field(intFieldIndex)
    Set pDomain = pField.Domain
    If Not pDomain Is Nothing Then
      If TypeOf pDomain Is ICodedValueDomain Then
        Set pCodedDomain = pDomain  'QI
        For intCount = 0 To pCodedDomain.CodeCount - 1
          If aFeature.Value(intFieldIndex) = pCodedDomain.Value(intCount) Then
            GetFieldValue = pCodedDomain.Name(intCount)
          End If
        Next intCount
      End If
    Else
      GetFieldValue = aFeature.Value(intFieldIndex)
    End If
End Function

