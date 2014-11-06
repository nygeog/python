VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Begin VB.Form frmExporttoKMLOptions 
   Caption         =   "Export to KML (OPTIONS)"
   ClientHeight    =   10800
   ClientLeft      =   4020
   ClientTop       =   1050
   ClientWidth     =   6720
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmExporttoKMLOptions.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   10800
   ScaleWidth      =   6720
   Begin TabDlg.SSTab tabExportOptions 
      Height          =   9855
      Left            =   120
      TabIndex        =   23
      Top             =   120
      Width           =   6405
      _ExtentX        =   11298
      _ExtentY        =   17383
      _Version        =   393216
      Tabs            =   6
      TabsPerRow      =   2
      TabHeight       =   529
      TabMaxWidth     =   5292
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "Export Options"
      TabPicture(0)   =   "frmExporttoKMLOptions.frx":628A
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "lblPercent"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "lblOutputTransparency"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "lblKMLLayerName"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "lblXYShift"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "lblXShift"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).Control(5)=   "lblYShift"
      Tab(0).Control(5).Enabled=   0   'False
      Tab(0).Control(6)=   "lbShiftUnits"
      Tab(0).Control(6).Enabled=   0   'False
      Tab(0).Control(7)=   "lblKMLLayerSnippet"
      Tab(0).Control(7).Enabled=   0   'False
      Tab(0).Control(8)=   "txtOutputTransparency"
      Tab(0).Control(8).Enabled=   0   'False
      Tab(0).Control(9)=   "txtKMLLayerName"
      Tab(0).Control(9).Enabled=   0   'False
      Tab(0).Control(10)=   "chkExportSelected"
      Tab(0).Control(10).Enabled=   0   'False
      Tab(0).Control(11)=   "fraLayerDescription"
      Tab(0).Control(11).Enabled=   0   'False
      Tab(0).Control(12)=   "txtXShift"
      Tab(0).Control(12).Enabled=   0   'False
      Tab(0).Control(13)=   "txtYShift"
      Tab(0).Control(13).Enabled=   0   'False
      Tab(0).Control(14)=   "chkIncludeLayerNameInDesc"
      Tab(0).Control(14).Enabled=   0   'False
      Tab(0).Control(15)=   "txtKMLLayerSnippet"
      Tab(0).Control(15).Enabled=   0   'False
      Tab(0).Control(16)=   "chkGoogleMapsKML"
      Tab(0).Control(16).Enabled=   0   'False
      Tab(0).ControlCount=   17
      TabCaption(1)   =   "Labeling and Description Options"
      TabPicture(1)   =   "frmExporttoKMLOptions.frx":62A6
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "linDescription"
      Tab(1).Control(1)=   "lblDescription"
      Tab(1).Control(2)=   "lblDescriptionAttributes"
      Tab(1).Control(3)=   "lblFeatureNameAttribute"
      Tab(1).Control(4)=   "lblFeatureSnippet"
      Tab(1).Control(5)=   "lblSnippetAttributes"
      Tab(1).Control(6)=   "chkLabelNullValues"
      Tab(1).Control(7)=   "cmdAddAllAttributes"
      Tab(1).Control(8)=   "chkCreateInfoPoints"
      Tab(1).Control(9)=   "lstDescriptionAttributes"
      Tab(1).Control(10)=   "chkColorLabels"
      Tab(1).Control(11)=   "cboFeatureNameAttribute"
      Tab(1).Control(12)=   "chkExportSeparateLabels"
      Tab(1).Control(13)=   "fraFeatureDescription"
      Tab(1).Control(14)=   "chkForcePointsInside"
      Tab(1).Control(15)=   "lstSnippetAttributes"
      Tab(1).Control(16)=   "fraFeatureSnippet"
      Tab(1).ControlCount=   17
      TabCaption(2)   =   "3D Options"
      TabPicture(2)   =   "frmExporttoKMLOptions.frx":62C2
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "txtInfoPtOffsetManual"
      Tab(2).Control(1)=   "txtLabelOffsetManual"
      Tab(2).Control(2)=   "txtOffsetManual"
      Tab(2).Control(3)=   "optAMClamped"
      Tab(2).Control(4)=   "cboOffsetAttribute"
      Tab(2).Control(5)=   "optAMRelative"
      Tab(2).Control(6)=   "optAMAbsolute"
      Tab(2).Control(7)=   "lblInfoPtOffsetManual"
      Tab(2).Control(8)=   "lblLabelOffsetManual"
      Tab(2).Control(9)=   "lblOffsetManual"
      Tab(2).Control(10)=   "lblOffsetAttribute"
      Tab(2).Control(11)=   "lblAltitudeMode"
      Tab(2).ControlCount=   12
      TabCaption(3)   =   "Time Options"
      TabPicture(3)   =   "frmExporttoKMLOptions.frx":62DE
      Tab(3).ControlEnabled=   0   'False
      Tab(3).Control(0)=   "chkFormatDateTime"
      Tab(3).Control(1)=   "cboEndTime"
      Tab(3).Control(2)=   "cboStartTime"
      Tab(3).Control(3)=   "lblEndTime"
      Tab(3).Control(4)=   "lblStartTime"
      Tab(3).Control(5)=   "lblTimeStampInfo"
      Tab(3).ControlCount=   6
      TabCaption(4)   =   "Database Schema Options"
      TabPicture(4)   =   "frmExporttoKMLOptions.frx":62FA
      Tab(4).ControlEnabled=   0   'False
      Tab(4).Control(0)=   "chkUseUnTypedData"
      Tab(4).Control(1)=   "chkExportSchema"
      Tab(4).Control(2)=   "lstTableAttributesMaster"
      Tab(4).Control(3)=   "lstTableAttributesExport"
      Tab(4).Control(4)=   "cmdAdd"
      Tab(4).Control(5)=   "cmdRemove"
      Tab(4).Control(6)=   "cmdUp"
      Tab(4).Control(7)=   "cmdDown"
      Tab(4).Control(8)=   "lblSchemaInfo"
      Tab(4).Control(9)=   "lblTableAttributesMaster"
      Tab(4).Control(10)=   "lblTableAttributesExport"
      Tab(4).Control(11)=   "lblNoteAboutDescription"
      Tab(4).ControlCount=   12
      TabCaption(5)   =   "About ""Export to KML"""
      TabPicture(5)   =   "frmExporttoKMLOptions.frx":6316
      Tab(5).ControlEnabled=   0   'False
      Tab(5).Control(0)=   "cmdCheckforUpdates"
      Tab(5).Control(1)=   "lblDisclaimer2"
      Tab(5).Control(2)=   "lblDisclaimer"
      Tab(5).Control(3)=   "imgExporttoKML"
      Tab(5).Control(4)=   "Line1"
      Tab(5).Control(5)=   "Line2"
      Tab(5).ControlCount=   6
      Begin VB.CheckBox chkGoogleMapsKML 
         Caption         =   $"frmExporttoKMLOptions.frx":6332
         Height          =   615
         Left            =   240
         TabIndex        =   74
         Top             =   1320
         Width           =   5535
      End
      Begin VB.TextBox txtKMLLayerSnippet 
         Height          =   555
         Left            =   2040
         MultiLine       =   -1  'True
         TabIndex        =   72
         Top             =   2520
         Width           =   3615
      End
      Begin VB.Frame fraFeatureSnippet 
         Caption         =   "Feature Snippet Expression (no HTML allowed)"
         Height          =   855
         Left            =   -74760
         TabIndex        =   69
         Top             =   3960
         Width           =   5535
         Begin VB.TextBox txtFeatureSnippet 
            Height          =   525
            Left            =   120
            MultiLine       =   -1  'True
            ScrollBars      =   2  'Vertical
            TabIndex        =   70
            Top             =   240
            Width           =   5295
         End
      End
      Begin VB.ListBox lstSnippetAttributes 
         Height          =   645
         Left            =   -74760
         TabIndex        =   68
         Top             =   3240
         Width           =   2295
      End
      Begin VB.CheckBox chkUseUnTypedData 
         Caption         =   "Use ""untyped"" database data elements (simple format compatible with ArcExplorer)"
         Height          =   375
         Left            =   -74760
         TabIndex        =   66
         Top             =   2400
         Width           =   5535
      End
      Begin VB.CheckBox chkIncludeLayerNameInDesc 
         Caption         =   "Use the layer name above as the title of the KML layer description"
         Height          =   255
         Left            =   240
         TabIndex        =   65
         TabStop         =   0   'False
         Top             =   3240
         Value           =   1  'Checked
         Width           =   5415
      End
      Begin VB.CheckBox chkForcePointsInside 
         Caption         =   "Force all label and information points to fall inside polygons (slows export)"
         Height          =   255
         Left            =   -74760
         TabIndex        =   64
         Top             =   1920
         Width           =   5655
      End
      Begin VB.CheckBox chkFormatDateTime 
         Caption         =   "Format all dates and times to the Google Earth XML standard"
         Height          =   375
         Left            =   -74640
         TabIndex        =   63
         Top             =   3720
         Width           =   5415
      End
      Begin VB.ComboBox cboEndTime 
         Height          =   315
         Left            =   -74640
         Style           =   2  'Dropdown List
         TabIndex        =   61
         Top             =   3240
         Width           =   5415
      End
      Begin VB.ComboBox cboStartTime 
         Height          =   315
         Left            =   -74640
         Style           =   2  'Dropdown List
         TabIndex        =   59
         Top             =   2520
         Width           =   5415
      End
      Begin VB.CheckBox chkExportSchema 
         Caption         =   "Use ""typed"" data elements (a formal schema that you can create or add to below)"
         Height          =   375
         Left            =   -74760
         TabIndex        =   53
         Top             =   2880
         Width           =   5415
      End
      Begin VB.ListBox lstTableAttributesMaster 
         Enabled         =   0   'False
         Height          =   2790
         Left            =   -74640
         MultiSelect     =   2  'Extended
         TabIndex        =   52
         Top             =   3720
         Width           =   2295
      End
      Begin VB.ListBox lstTableAttributesExport 
         Enabled         =   0   'False
         Height          =   2790
         Left            =   -71520
         MultiSelect     =   2  'Extended
         TabIndex        =   51
         Top             =   3720
         Width           =   2295
      End
      Begin VB.CommandButton cmdAdd 
         Caption         =   ">>"
         Enabled         =   0   'False
         Height          =   495
         Left            =   -72240
         TabIndex        =   50
         ToolTipText     =   "move selected attributes to export list"
         Top             =   3960
         Width           =   615
      End
      Begin VB.CommandButton cmdRemove 
         Caption         =   "<<"
         Enabled         =   0   'False
         Height          =   495
         Left            =   -72240
         TabIndex        =   49
         ToolTipText     =   "remove selected attributes from export list"
         Top             =   4560
         Width           =   615
      End
      Begin VB.CommandButton cmdUp 
         Caption         =   "move up"
         Enabled         =   0   'False
         Height          =   495
         Left            =   -72240
         TabIndex        =   48
         ToolTipText     =   "move selected attributes up"
         Top             =   5160
         Width           =   615
      End
      Begin VB.CommandButton cmdDown 
         Caption         =   "move down"
         Enabled         =   0   'False
         Height          =   495
         Left            =   -72240
         TabIndex        =   47
         ToolTipText     =   "move selected attributes down"
         Top             =   5760
         Width           =   615
      End
      Begin VB.CommandButton cmdCheckforUpdates 
         Caption         =   "Check for updates"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   -71040
         TabIndex        =   44
         ToolTipText     =   "Check for an updated version of Export to KML"
         Top             =   7080
         Width           =   1815
      End
      Begin VB.TextBox txtYShift 
         Alignment       =   1  'Right Justify
         Height          =   315
         Left            =   4080
         TabIndex        =   42
         Text            =   "0"
         Top             =   8370
         Width           =   855
      End
      Begin VB.TextBox txtXShift 
         Alignment       =   1  'Right Justify
         Height          =   315
         Left            =   3000
         TabIndex        =   41
         Text            =   "0"
         Top             =   8370
         Width           =   855
      End
      Begin VB.Frame fraFeatureDescription 
         Caption         =   "Feature description expression (HTML)"
         Height          =   2895
         Left            =   -74760
         TabIndex        =   37
         Top             =   6240
         Width           =   5535
         Begin VB.CommandButton cmdSaveFeatureDescription 
            Caption         =   "Save"
            Height          =   375
            Left            =   3840
            TabIndex        =   12
            ToolTipText     =   "Save the feature description to a KFD file"
            Top             =   2400
            Width           =   735
         End
         Begin VB.CommandButton cmdImportFeatureDescription 
            Caption         =   "Import"
            Height          =   375
            Left            =   4680
            TabIndex        =   13
            ToolTipText     =   "Import the feature description from a KFD file"
            Top             =   2400
            Width           =   735
         End
         Begin VB.TextBox txtFeatureDescription 
            Height          =   1935
            Left            =   120
            MultiLine       =   -1  'True
            ScrollBars      =   2  'Vertical
            TabIndex        =   11
            Top             =   360
            Width           =   5295
         End
      End
      Begin VB.Frame fraLayerDescription 
         Caption         =   "KML Layer Description (HTML)"
         Height          =   3855
         Left            =   200
         TabIndex        =   36
         Top             =   4080
         Width           =   5655
         Begin VB.CommandButton cmdSaveLayerDescription 
            Caption         =   "Save"
            Height          =   375
            Left            =   3960
            TabIndex        =   3
            ToolTipText     =   "Save the layer description to a KLD file"
            Top             =   3360
            Width           =   735
         End
         Begin VB.CommandButton cmdImportLayerDescription 
            Caption         =   "Import"
            Height          =   375
            Left            =   4800
            TabIndex        =   4
            ToolTipText     =   "Import the layer description from a KLD file"
            Top             =   3360
            Width           =   735
         End
         Begin VB.TextBox txtKMLLayerDescription 
            Height          =   2895
            Left            =   120
            MultiLine       =   -1  'True
            ScrollBars      =   2  'Vertical
            TabIndex        =   2
            Top             =   360
            Width           =   5415
         End
      End
      Begin VB.TextBox txtInfoPtOffsetManual 
         Alignment       =   2  'Center
         Enabled         =   0   'False
         Height          =   315
         Left            =   -70080
         TabIndex        =   21
         Text            =   "0"
         Top             =   3360
         Width           =   735
      End
      Begin VB.TextBox txtLabelOffsetManual 
         Alignment       =   2  'Center
         Enabled         =   0   'False
         Height          =   315
         Left            =   -70080
         TabIndex        =   20
         Text            =   "0"
         Top             =   3000
         Width           =   735
      End
      Begin VB.TextBox txtOffsetManual 
         Alignment       =   2  'Center
         Height          =   315
         Left            =   -70080
         TabIndex        =   19
         Text            =   "0"
         Top             =   2640
         Width           =   735
      End
      Begin VB.OptionButton optAMClamped 
         Caption         =   "Clamped to ground"
         Height          =   255
         Left            =   -70920
         TabIndex        =   17
         Top             =   1320
         Width           =   1815
      End
      Begin VB.CheckBox chkExportSeparateLabels 
         Caption         =   "Export labels as a separate KML layer (optional for point features only)"
         Height          =   255
         Left            =   -74760
         TabIndex        =   7
         Top             =   1620
         Width           =   5655
      End
      Begin VB.ComboBox cboFeatureNameAttribute 
         Height          =   315
         Left            =   -74760
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   2580
         Width           =   5415
      End
      Begin VB.CheckBox chkExportSelected 
         Caption         =   "Export only the selected features"
         Height          =   255
         Left            =   240
         TabIndex        =   28
         TabStop         =   0   'False
         Top             =   1080
         Width           =   4335
      End
      Begin VB.TextBox txtKMLLayerName 
         Height          =   315
         Left            =   2040
         TabIndex        =   0
         Top             =   2130
         Width           =   3615
      End
      Begin VB.TextBox txtOutputTransparency 
         Alignment       =   1  'Right Justify
         Height          =   315
         Left            =   2160
         TabIndex        =   1
         Text            =   "0"
         Top             =   3615
         Width           =   375
      End
      Begin VB.CheckBox chkColorLabels 
         Caption         =   "Apply feature colors to labels (the default label color is white)"
         Height          =   255
         Left            =   -74760
         TabIndex        =   5
         Top             =   1020
         Width           =   5535
      End
      Begin VB.ListBox lstDescriptionAttributes 
         Height          =   840
         Left            =   -74760
         TabIndex        =   9
         Top             =   5220
         Width           =   2295
      End
      Begin VB.CheckBox chkCreateInfoPoints 
         Caption         =   $"frmExporttoKMLOptions.frx":63C3
         Height          =   375
         Left            =   -74760
         TabIndex        =   14
         Top             =   9240
         Width           =   5655
      End
      Begin VB.CommandButton cmdAddAllAttributes 
         Caption         =   "Add ALL Attributes"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   -70560
         TabIndex        =   10
         ToolTipText     =   "Add all attributes to the feature description"
         Top             =   5460
         Width           =   1095
      End
      Begin VB.CheckBox chkLabelNullValues 
         Caption         =   "Label features with empty or <Null> values"
         Height          =   255
         Left            =   -74760
         TabIndex        =   6
         Top             =   1320
         Width           =   4575
      End
      Begin VB.ComboBox cboOffsetAttribute 
         Height          =   315
         Left            =   -74760
         Style           =   2  'Dropdown List
         TabIndex        =   18
         Top             =   2100
         Width           =   5415
      End
      Begin VB.OptionButton optAMRelative 
         Caption         =   "Relative to ground"
         Height          =   255
         Left            =   -73800
         TabIndex        =   15
         Top             =   1320
         Value           =   -1  'True
         Width           =   1815
      End
      Begin VB.OptionButton optAMAbsolute 
         Caption         =   "Absolute"
         Height          =   255
         Left            =   -72000
         TabIndex        =   16
         Top             =   1320
         Width           =   1095
      End
      Begin VB.Label lblKMLLayerSnippet 
         Alignment       =   1  'Right Justify
         Caption         =   "Output  KML layer ""snippet"":"
         Height          =   375
         Left            =   120
         TabIndex        =   73
         Top             =   2600
         Width           =   1815
      End
      Begin VB.Label lblSnippetAttributes 
         Caption         =   "Layer Attributes (double-click to add to feature snippet)"
         Height          =   615
         Left            =   -72360
         TabIndex        =   71
         Top             =   3240
         Width           =   1695
      End
      Begin VB.Label lblFeatureSnippet 
         Caption         =   "Feature Snippet:"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   -74760
         TabIndex        =   67
         Top             =   3000
         Width           =   2055
      End
      Begin VB.Label lblEndTime 
         Caption         =   "Select an attribute that represents the ""end time"" of each feature:"
         Height          =   255
         Left            =   -74640
         TabIndex        =   62
         Top             =   3000
         Width           =   5415
      End
      Begin VB.Label lblStartTime 
         Caption         =   "Select an attribute that represents the ""start time"" of each feature:"
         Height          =   255
         Left            =   -74640
         TabIndex        =   60
         Top             =   2280
         Width           =   5415
      End
      Begin VB.Label lblTimeStampInfo 
         Caption         =   $"frmExporttoKMLOptions.frx":6459
         Height          =   855
         Left            =   -74640
         TabIndex        =   58
         Top             =   1320
         Width           =   5415
      End
      Begin VB.Label lblSchemaInfo 
         Caption         =   $"frmExporttoKMLOptions.frx":656B
         Height          =   975
         Left            =   -74760
         TabIndex        =   57
         Top             =   1200
         Width           =   5535
      End
      Begin VB.Label lblTableAttributesMaster 
         Caption         =   "GIS Data Attributes:"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   -74640
         TabIndex        =   56
         Top             =   3480
         Width           =   1935
      End
      Begin VB.Label lblTableAttributesExport 
         Caption         =   "Exported Attributes:"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   -71520
         TabIndex        =   55
         Top             =   3480
         Width           =   1935
      End
      Begin VB.Label lblNoteAboutDescription 
         Caption         =   $"frmExporttoKMLOptions.frx":66C3
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   -74760
         TabIndex        =   54
         Top             =   6720
         Width           =   5535
      End
      Begin VB.Label lblDisclaimer2 
         Alignment       =   2  'Center
         Caption         =   "As always with ArcGIS, SAVE OFTEN..."
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   -74760
         TabIndex        =   46
         Top             =   6120
         Width           =   5535
      End
      Begin VB.Label lblDisclaimer 
         Alignment       =   2  'Center
         Caption         =   $"frmExporttoKMLOptions.frx":675F
         Height          =   2055
         Left            =   -74760
         TabIndex        =   45
         Top             =   3600
         Width           =   5535
      End
      Begin VB.Image imgExporttoKML 
         Height          =   1455
         Left            =   -74280
         Picture         =   "frmExporttoKMLOptions.frx":6A47
         Top             =   1680
         Width           =   4500
      End
      Begin VB.Line Line1 
         X1              =   -74640
         X2              =   -69360
         Y1              =   1320
         Y2              =   1320
      End
      Begin VB.Line Line2 
         X1              =   -74640
         X2              =   -69360
         Y1              =   6600
         Y2              =   6600
      End
      Begin VB.Label lbShiftUnits 
         Caption         =   "units"
         Height          =   255
         Left            =   5040
         TabIndex        =   43
         Top             =   8400
         Width           =   855
      End
      Begin VB.Label lblYShift 
         Alignment       =   2  'Center
         Caption         =   "Y Shift"
         Height          =   255
         Left            =   4140
         TabIndex        =   40
         Top             =   8160
         Width           =   735
      End
      Begin VB.Label lblXShift 
         Alignment       =   2  'Center
         Caption         =   "X Shift"
         Height          =   255
         Left            =   3060
         TabIndex        =   39
         Top             =   8160
         Width           =   735
      End
      Begin VB.Label lblXYShift 
         Caption         =   "Apply horizontal shift to all features:"
         Height          =   255
         Left            =   240
         TabIndex        =   38
         Top             =   8400
         Width           =   2655
      End
      Begin VB.Label lblInfoPtOffsetManual 
         Alignment       =   1  'Right Justify
         Caption         =   "Surface offset constant value for INFORMATION POINTS:"
         Enabled         =   0   'False
         Height          =   255
         Left            =   -74760
         TabIndex        =   35
         Top             =   3390
         Width           =   4455
      End
      Begin VB.Label lblLabelOffsetManual 
         Alignment       =   1  'Right Justify
         Caption         =   "Surface offset constant value for LABELS:"
         Enabled         =   0   'False
         Height          =   255
         Left            =   -73440
         TabIndex        =   34
         Top             =   3030
         Width           =   3135
      End
      Begin VB.Label lblOffsetManual 
         Alignment       =   1  'Right Justify
         Caption         =   "Surface offset constant value for FEATURES:"
         Height          =   255
         Left            =   -74640
         TabIndex        =   33
         Top             =   2670
         Width           =   4335
      End
      Begin VB.Label lblFeatureNameAttribute 
         Caption         =   "Select an attribute for naming each feature:"
         Height          =   255
         Left            =   -74760
         TabIndex        =   32
         Top             =   2340
         Width           =   4095
      End
      Begin VB.Label lblKMLLayerName 
         Alignment       =   1  'Right Justify
         Caption         =   "Output KML layer name:"
         Height          =   255
         Left            =   120
         TabIndex        =   31
         Top             =   2160
         Width           =   1815
      End
      Begin VB.Label lblOutputTransparency 
         Caption         =   "KML layer transparency:"
         Height          =   255
         Left            =   240
         TabIndex        =   30
         Top             =   3660
         Width           =   1785
      End
      Begin VB.Label lblPercent 
         Caption         =   "%"
         Height          =   255
         Left            =   2595
         TabIndex        =   29
         Top             =   3660
         Width           =   255
      End
      Begin VB.Label lblDescriptionAttributes 
         Caption         =   "Layer Attributes (double-click to add to feature description)"
         Height          =   615
         Left            =   -72360
         TabIndex        =   27
         Top             =   5400
         Width           =   1695
      End
      Begin VB.Label lblDescription 
         Caption         =   "Feature Description:"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   -74760
         TabIndex        =   26
         Top             =   4980
         Width           =   2055
      End
      Begin VB.Line linDescription 
         X1              =   -74760
         X2              =   -69360
         Y1              =   2220
         Y2              =   2220
      End
      Begin VB.Label lblOffsetAttribute 
         Caption         =   "Select an attribute that represents the surface offset (Optional):"
         Height          =   255
         Left            =   -74760
         TabIndex        =   25
         Top             =   1860
         Width           =   4695
      End
      Begin VB.Label lblAltitudeMode 
         Alignment       =   1  'Right Justify
         Caption         =   "Altitude mode:"
         Height          =   375
         Left            =   -74760
         TabIndex        =   24
         Top             =   1260
         Width           =   735
      End
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
      Left            =   5760
      TabIndex        =   22
      ToolTipText     =   "Save options and close form"
      Top             =   10200
      Width           =   855
   End
End
Attribute VB_Name = "frmExporttoKMLOptions"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' ---------------------------------------------
' frmExportToKMLOptions
' 12/7/2005
'
' Kevin Martin
' City of Portland/Bureau of Planning
' kmartin@ci.portland.or.us
'
' Description: Sets additional options for exporting
'              KML features
'
' Object Type: FORM
' Language: VB
'
' ---------------------------------------------

Option Explicit

' GLOBAL VARIABLES
' << none >>

' MODULE-LEVEL VARIABLES
Private m_lngCount As Long

Private Sub cboFeatureNameAttribute_Enter()
  frmExporttoKML.g_boolFeatureNameAttributeManuallySet = True
End Sub

Private Sub chkCreateInfoPoints_Click()
  If chkCreateInfoPoints.Value = vbChecked Then
    lblInfoPtOffsetManual.Enabled = True
    txtInfoPtOffsetManual.Enabled = True
  Else
    lblInfoPtOffsetManual.Enabled = False
    txtInfoPtOffsetManual.Enabled = False
    txtInfoPtOffsetManual.Text = "0"
  End If
End Sub

Private Sub chkExportseparateLabels_Click()
  If chkExportSeparateLabels.Value = vbChecked Then
    frmExporttoKML.g_boolExportSeparateLabels = True
    lblFeatureNameAttribute.Enabled = True
    cboFeatureNameAttribute.Enabled = True
    If cboFeatureNameAttribute.Text = "<NONE>" And Not frmExporttoKML.g_pLayerSymbolField Is Nothing Then
      For m_lngCount = 0 To cboFeatureNameAttribute.ListCount - 1
        If cboFeatureNameAttribute.List(m_lngCount) = frmExporttoKML.g_pLayerSymbolField.AliasName Then
          cboFeatureNameAttribute.ListIndex = m_lngCount
        End If
      Next m_lngCount
    End If
  Else
    frmExporttoKML.g_boolExportSeparateLabels = False
    lblFeatureNameAttribute.Enabled = False
    cboFeatureNameAttribute.Enabled = False
    frmExporttoKML.g_boolFeatureNameAttributeManuallySet = False
    For m_lngCount = 0 To cboFeatureNameAttribute.ListCount - 1
      If cboFeatureNameAttribute.List(m_lngCount) = frmExporttoKML.cboLabelAttribute.Text Then
        cboFeatureNameAttribute.ListIndex = m_lngCount
      End If
    Next m_lngCount
  End If
End Sub

Private Sub chkExportSchema_Click()
  If chkExportSchema.Value = vbChecked Then
    lblTableAttributesMaster.Enabled = True
    lstTableAttributesMaster.Enabled = True
    cmdAdd.Enabled = True
    cmdRemove.Enabled = True
    cmdUp.Enabled = True
    cmdDown.Enabled = True
    lblTableAttributesExport.Enabled = True
    lstTableAttributesExport.Enabled = True
  Else
    lblTableAttributesMaster.Enabled = False
    lstTableAttributesMaster.Enabled = False
    cmdAdd.Enabled = False
    cmdRemove.Enabled = False
    cmdUp.Enabled = False
    cmdDown.Enabled = False
    lblTableAttributesExport.Enabled = False
    lstTableAttributesExport.Enabled = False
    lstTableAttributesExport.Clear
  End If
End Sub

Private Sub chkGoogleMapsKML_Click()
  Dim pFLayer As esricarto.IFeatureLayer2
  Set pFLayer = frmExporttoKML.g_pInputLayer  'QI
  If chkGoogleMapsKML.Value = vbChecked Then
    chkCreateInfoPoints.Value = vbUnchecked
    chkCreateInfoPoints.Enabled = False
    chkUseUnTypedData.Value = vbUnchecked
    chkUseUnTypedData.Enabled = False
    chkExportSchema.Value = vbUnchecked
    chkExportSchema.Enabled = False
    lblTableAttributesMaster.Enabled = False
    lstTableAttributesMaster.Enabled = False
    cmdAdd.Enabled = False
    cmdRemove.Enabled = False
    cmdUp.Enabled = False
    cmdDown.Enabled = False
    lblTableAttributesExport.Enabled = False
    lstTableAttributesExport.Enabled = False
    lstTableAttributesExport.Clear
  Else
    If pFLayer.FeatureClass.ShapeType <> esriGeometryPoint Then
      chkCreateInfoPoints.Enabled = True
    End If
    chkUseUnTypedData.Enabled = True
    chkExportSchema.Enabled = True
  End If
End Sub

Private Sub chkUseUnTypedData_Click()
  If chkUseUnTypedData.Value = vbChecked Then
    chkExportSchema.Value = vbUnchecked
    chkExportSchema.Enabled = False
    lblTableAttributesMaster.Enabled = False
    lstTableAttributesMaster.Enabled = False
    cmdAdd.Enabled = False
    cmdRemove.Enabled = False
    cmdUp.Enabled = False
    cmdDown.Enabled = False
    lblTableAttributesExport.Enabled = False
    lstTableAttributesExport.Enabled = False
    lstTableAttributesExport.Clear
  Else
    chkExportSchema.Enabled = True
    lblTableAttributesMaster.Enabled = True
    lstTableAttributesMaster.Enabled = True
    cmdAdd.Enabled = True
    cmdRemove.Enabled = True
    cmdUp.Enabled = True
    cmdDown.Enabled = True
    lblTableAttributesExport.Enabled = True
    lstTableAttributesExport.Enabled = True
  End If
End Sub

Private Sub cmdAdd_Click()
  ' move selected items into "export" schema list
  Dim intIndex As Integer
  Dim intCurrent As Integer
  Dim boolDuplicate As Boolean
  boolDuplicate = False
  For intIndex = 0 To lstTableAttributesMaster.ListCount - 1
    If lstTableAttributesMaster.Selected(intIndex) = True Then
    
      ' makes sure item is not already in list
      If lstTableAttributesExport.ListCount > 0 Then
        For intCurrent = 0 To lstTableAttributesExport.ListCount - 1
          If lstTableAttributesExport.List(intCurrent) = lstTableAttributesMaster.List(intIndex) Then
            boolDuplicate = True
          End If
        Next intCurrent
      End If
        
      ' adds item if item is not duplicated
      If boolDuplicate = False Then
        lstTableAttributesExport.AddItem lstTableAttributesMaster.List(intIndex)
      End If
    End If
    boolDuplicate = False
  Next intIndex
End Sub

Private Sub cmdAddAllAttributes_Click()
  Dim intCount As Integer
  Dim strAttributeInfo As String
  For intCount = 0 To lstDescriptionAttributes.ListCount - 1
    strAttributeInfo = lstDescriptionAttributes.List(intCount) & " = [" & lstDescriptionAttributes.List(intCount) & "]" & "<br />"
    If Trim(txtFeatureDescription.Text) = "" Then
      txtFeatureDescription.Text = strAttributeInfo
    Else
      txtFeatureDescription.Text = txtFeatureDescription.Text & vbCrLf & strAttributeInfo
    End If
  Next intCount
  txtFeatureDescription.Text = txtFeatureDescription.Text & vbCrLf
  cmdAddAllAttributes.Enabled = False
End Sub

Private Sub cmdCheckforUpdates_Click()
  ShellExecute hWnd, "open", "http://arcscripts.esri.com/details.asp?dbid=14273", vbNull, vbNull, SW_SHOWNORMAL
End Sub

Private Sub cmdDown_Click()
  ' move current selections down in the current list
  If lstTableAttributesExport.ListCount > 0 Then
    ' check to see if items can be moved
    If CanMoveUpDown(lstTableAttributesExport, "DOWN") = True Then
    
      ' get the position of the first selected item
      Dim intFirstPosition As Integer
      Dim boolFoundFirst As Boolean
      intFirstPosition = lstTableAttributesExport.ListCount - 1
      boolFoundFirst = False
      Do While boolFoundFirst = False
        If lstTableAttributesExport.Selected(intFirstPosition) = True Then
          boolFoundFirst = True
        Else
          intFirstPosition = intFirstPosition - 1
        End If
      Loop
      
      ' move selected items to the specified position
      Dim intIndex As Integer
      Dim strText As String
      Dim intTargetIndex As Integer
      intTargetIndex = intFirstPosition + 1
      For intIndex = lstTableAttributesExport.ListCount - 1 To 0 Step -1
        If lstTableAttributesExport.Selected(intIndex) = True Then
          strText = lstTableAttributesExport.List(intIndex)
          lstTableAttributesExport.RemoveItem intIndex
          lstTableAttributesExport.AddItem strText, intTargetIndex
          lstTableAttributesExport.Selected(intIndex) = False
          lstTableAttributesExport.Selected(intTargetIndex) = True
          intTargetIndex = intTargetIndex - 1
        End If
      Next intIndex
    End If
  End If
End Sub

Private Sub cmdImportFeatureDescription_Click()
  Dim strKFDFile As String
  strKFDFile = frmExporttoKML.BrowsetoFile("html", "Google Earth KML feature description", True)
  If VBA.Trim(strKFDFile) <> "" Then
    txtFeatureDescription.Text = ReadTextFile(strKFDFile)
  End If
End Sub

Private Sub cmdImportLayerDescription_Click()
  Dim strKLDFile As String
  strKLDFile = frmExporttoKML.BrowsetoFile("html", "Google Earth KML layer description", True)
  If VBA.Trim(strKLDFile) <> "" Then
    txtKMLLayerDescription.Text = ReadTextFile(strKLDFile)
  End If
End Sub

Private Sub cmdOK_Click()
  frmExporttoKMLOptions.Hide
End Sub

Private Sub cmdRemove_Click()
  ' removes selected items from the current list
  Dim intIndex As Integer
  For intIndex = lstTableAttributesExport.ListCount - 1 To 0 Step -1
    If lstTableAttributesExport.Selected(intIndex) = True Then
      lstTableAttributesExport.RemoveItem intIndex
    End If
  Next intIndex
  
  ' disable commands if list is empty
  If lstTableAttributesExport.ListCount < 2 Then
    If lstTableAttributesExport.ListCount = 0 Then
      cmdRemove.Enabled = False
    End If
  End If
End Sub

Private Sub cmdSaveFeatureDescription_Click()
  Dim strKFDFile As String
  If Trim(txtFeatureDescription.Text) = "" Then
    MsgBox "There is no KML feature description to save.", vbOKOnly, "Save KML feature description"
    Exit Sub
  End If
  strKFDFile = frmExporttoKML.BrowsetoFile("html", "Google Earth KML feature description", False)
  If VBA.Trim(strKFDFile) <> "" Then
    Open strKFDFile For Output As #1
    Print #1, txtFeatureDescription.Text
    Close #1
  End If
End Sub

Private Sub cmdSaveLayerDescription_Click()
  Dim strKLDFile As String
  If Trim(txtKMLLayerDescription.Text) = "" Then
    MsgBox "There is no KML layer description to save.", vbOKOnly, "Save KML layer description"
    Exit Sub
  End If
  strKLDFile = frmExporttoKML.BrowsetoFile("html", "Google Earth KML layer description", False)
  If VBA.Trim(strKLDFile) <> "" Then
    Open strKLDFile For Output As #1
    Print #1, txtKMLLayerDescription.Text
    Close #1
  End If
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
  If UnloadMode = vbFormControlMenu Then
    Cancel = 1
    frmExporttoKMLOptions.Hide
  Else
    Cancel = 0
  End If
End Sub

Private Sub cmdUp_Click()
  ' move current selections up in the current list
  If lstTableAttributesExport.ListCount > 0 Then
    ' check to see that text can be moved
    If CanMoveUpDown(lstTableAttributesExport, "UP") = True Then
  
      ' get the position of the first selected item
      Dim intFirstPosition As Integer
      Dim boolFoundFirst As Boolean
      intFirstPosition = 0
      boolFoundFirst = False
      Do While boolFoundFirst = False
        If lstTableAttributesExport.Selected(intFirstPosition) = True Then
          boolFoundFirst = True
        Else
          intFirstPosition = intFirstPosition + 1
        End If
      Loop
      
      ' move selected items to the specified position
      Dim intIndex As Integer
      Dim strText As String
      Dim intTargetIndex As Integer
      intTargetIndex = intFirstPosition - 1
      For intIndex = 0 To lstTableAttributesExport.ListCount - 1
        If lstTableAttributesExport.Selected(intIndex) = True Then
          strText = lstTableAttributesExport.List(intIndex)
          lstTableAttributesExport.RemoveItem intIndex
          lstTableAttributesExport.AddItem strText, intTargetIndex
          lstTableAttributesExport.Selected(intIndex) = False
          lstTableAttributesExport.Selected(intTargetIndex) = True
          intTargetIndex = intTargetIndex + 1
        End If
      Next intIndex
    End If
  End If
End Sub

'Private Sub lstDescriptionAttributes_DblClick(ByVal Cancel As MSForms.ReturnBoolean) 'VBA
Private Sub lstDescriptionAttributes_DblClick() 'VB
  txtFeatureDescription.SelText = "[" & lstDescriptionAttributes.Text & "]"
  If chkCreateInfoPoints.Value = vbUnchecked Then
    If chkCreateInfoPoints.Enabled = True Then
      chkCreateInfoPoints.Value = vbChecked
    End If
  End If
End Sub

Private Sub txtOffsetManual_Validate(Cancel As Boolean)
  If VBA.IsNumeric(txtOffsetManual.Text) = False Then
    txtOffsetManual.Text = "0"
  End If
End Sub

Private Sub txtLabelOffsetManual_Validate(Cancel As Boolean)
  If VBA.IsNumeric(txtLabelOffsetManual.Text) = False Then
    txtLabelOffsetManual.Text = "0"
  End If
End Sub

Private Sub txtInfoPtOffsetManual_Validate(Cancel As Boolean)
  If VBA.IsNumeric(txtInfoPtOffsetManual.Text) = False Then
    txtInfoPtOffsetManual.Text = "0"
  End If
End Sub

'Private Sub lstSnippetAttributes_DblClick(ByVal Cancel As MSForms.ReturnBoolean) ' VBA
Private Sub lstSnippetAttributes_DblClick() 'VB
  txtFeatureSnippet.SelText = "[" & lstSnippetAttributes.Text & "]"
End Sub

'Private Sub UserForm_Activate() 'VBA
Private Sub Form_Activate() 'VB
  
  ' reset transparency if necessary
  If IsNumeric(txtOutputTransparency.Text) = False Then
    txtOutputTransparency.Text = "0"
  Else
    If CSng(txtOutputTransparency.Text) < 0 Then
      txtOutputTransparency.Text = "0"
    ElseIf CSng(txtOutputTransparency.Text) > 100 Then
      txtOutputTransparency.Text = "100"
    End If
  End If

  ' enable/disable labeling options
  Dim pFLayer As esricarto.IFeatureLayer2
  Dim boolGeneric As Boolean
  ' disable info info points option if input layer contains points
  Set pFLayer = frmExporttoKML.g_pInputLayer  'QI
  If pFLayer.FeatureClass.ShapeType = esriGeometryPoint Then
    chkCreateInfoPoints.Enabled = False
  Else
    If chkGoogleMapsKML.Value <> vbChecked Then
      chkCreateInfoPoints.Enabled = True
    End If
    chkExportSeparateLabels.Enabled = False
  End If
  If pFLayer.FeatureClass.ShapeType = esriGeometryPolygon Then
    chkForcePointsInside.Enabled = True
  Else
    chkForcePointsInside.Enabled = False
    chkForcePointsInside.Value = vbUnchecked
  End If
  
  ' enable/disable separate labeling
  If frmExporttoKML.cboLabelAttribute <> "<NONE>" Then
    If pFLayer.FeatureClass.ShapeType = esriGeometryPoint Then
      chkExportSeparateLabels.Enabled = True
      If frmExporttoKML.g_boolExportSeparateLabels = True Then
        chkExportSeparateLabels.Value = vbChecked
      Else
        chkExportSeparateLabels.Value = vbUnchecked
      End If
    Else
      chkExportSeparateLabels.Enabled = False
      chkExportSeparateLabels.Value = vbChecked
    End If
  Else
    boolGeneric = chkExportSeparateLabels.Value
    chkExportSeparateLabels.Enabled = False
    chkExportSeparateLabels.Value = vbUnchecked
    frmExporttoKML.g_boolExportSeparateLabels = boolGeneric
  End If
  
  ' enable/disable labeling options
  If frmExporttoKML.cboLabelAttribute.Text <> "<NONE>" Then
    chkColorLabels.Enabled = True
    chkLabelNullValues.Enabled = True
  Else
    chkColorLabels.Value = vbUnchecked
    chkColorLabels.Enabled = False
    chkLabelNullValues.Value = vbUnchecked
    chkLabelNullValues.Enabled = False
  End If
  
  ' enable all description options
  If chkExportSeparateLabels.Enabled = True And chkExportSeparateLabels.Value <> vbChecked Then
    lblFeatureNameAttribute.Enabled = False
    cboFeatureNameAttribute.Enabled = False
  Else
    lblFeatureNameAttribute.Enabled = True
    cboFeatureNameAttribute.Enabled = True
  End If
End Sub

Private Sub txtOutputTransparency_Validate(Cancel As Boolean)
  If VBA.IsNumeric(txtOutputTransparency.Text) = False Then
    txtOutputTransparency.Text = "0"
  End If
End Sub

Private Function CanMoveUpDown(aList As ListBox, strDirection As String) As Boolean
   ' disables/enables up/down commands as necessary
   If strDirection = "UP" Then
    If aList.Selected(0) = True Then
      CanMoveUpDown = False
    Else
      CanMoveUpDown = True
    End If
   ElseIf strDirection = "DOWN" Then
    If aList.Selected(aList.ListCount - 1) = True Then
      CanMoveUpDown = False
    Else
      CanMoveUpDown = True
    End If
   End If
End Function

Public Function ReadTextFile(strTextFilePath As String)
  ' gets the disclaimer text from the text file
  Dim vFSOBject As Object
  Set vFSOBject = CreateObject("Scripting.FileSystemObject")
  If vFSOBject.FileExists(strTextFilePath) = True Then
    Const ForReading = 1
    Dim vTextStream As Object
    Dim strText As String
    Set vTextStream = vFSOBject.OpenTextFile(strTextFilePath, ForReading, 0)
    strText = vTextStream.ReadAll
    vTextStream.Close
    ReadTextFile = strText
  Else
    ReadTextFile = ""
  End If
End Function

Private Sub txtXShift_Validate(Cancel As Boolean)
  If VBA.IsNumeric(txtXShift.Text) = False Then
    txtXShift.Text = "0"
  End If
End Sub

Private Sub txtYShift_Validate(Cancel As Boolean)
  If VBA.IsNumeric(txtYShift.Text) = False Then
    txtYShift.Text = "0"
  End If
End Sub


