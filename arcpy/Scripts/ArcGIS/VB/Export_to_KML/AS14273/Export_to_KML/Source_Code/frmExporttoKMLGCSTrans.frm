VERSION 5.00
Begin VB.Form frmExporttoKMLGCSTrans 
   Caption         =   "Coordinate System Transformation"
   ClientHeight    =   3015
   ClientLeft      =   9990
   ClientTop       =   3120
   ClientWidth     =   7320
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   ScaleHeight     =   3015
   ScaleWidth      =   7320
   Begin VB.CommandButton cmdGCSTransformation 
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
      Left            =   4920
      TabIndex        =   8
      Top             =   2400
      Width           =   855
   End
   Begin VB.CommandButton cmdGCSHelp 
      Caption         =   "More Info"
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
      Left            =   6000
      TabIndex        =   7
      Top             =   2400
      Width           =   1215
   End
   Begin VB.ComboBox cboGCSTransformation 
      Height          =   315
      Left            =   2280
      Sorted          =   -1  'True
      Style           =   2  'Dropdown List
      TabIndex        =   6
      Top             =   1920
      Width           =   4935
   End
   Begin VB.TextBox txtToSR 
      Enabled         =   0   'False
      Height          =   315
      Left            =   2280
      TabIndex        =   4
      Text            =   "txtToSR"
      Top             =   1440
      Width           =   4935
   End
   Begin VB.TextBox txtFromSR 
      Enabled         =   0   'False
      Height          =   315
      Left            =   2280
      TabIndex        =   2
      Text            =   "txtFromSR"
      Top             =   960
      Width           =   4935
   End
   Begin VB.Label lbGCSTransformation 
      Alignment       =   1  'Right Justify
      Caption         =   "Transformation method:"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   1950
      Width           =   2055
   End
   Begin VB.Label lblToSR 
      Alignment       =   1  'Right Justify
      Caption         =   "Output coordinate system:"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   1470
      Width           =   2055
   End
   Begin VB.Label lblFromSR 
      Alignment       =   1  'Right Justify
      Caption         =   "Input coordinate system:"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   990
      Width           =   2055
   End
   Begin VB.Label lblGCSTransformationInfo 
      Caption         =   $"frmExporttoKMLGCSTrans.frx":0000
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   6975
   End
End
Attribute VB_Name = "frmExporttoKMLGCSTrans"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' ---------------------------------------------
' frmExporttoKMLGCSTrans
' 6/10/2008
'
' Kevin Martin
' City of Portland/Bureau of Planning
' kmartin@ci.portland.or.us
'
' Description: Allows user to specifiy a geographic
'              transformation to use when reprojecting
'              features
'
' Object Type: FORM
' Language: VB
'
' ---------------------------------------------

Option Explicit

Private Sub cmdGCSHelp_Click()
  ShellExecute hWnd, "open", "http://webhelp.esri.com/arcgisdesktop/9.2/index.cfm?TopicName=Geographic_transformation_methods", vbNull, vbNull, SW_SHOWNORMAL
End Sub

Private Sub cmdGCSTransformation_Click()
  If cboGCSTransformation.ListIndex > 0 Then
    frmExporttoKML.g_strGCSTransformation = cboGCSTransformation.Text
  End If
  frmExporttoKMLGCSTrans.Hide
End Sub

