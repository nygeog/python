Attribute VB_Name = "EC_Expressions"
'The following SUBs are samples showing how the expressions of EasyCalculate
'can be used programatically
'To run these SUBs use the EC_Run_Calc sub from the EC_RunCalculator.bas
'module included in the EasyCalculate 4.5 download
'Read EasyCalculate.htm for description of the functions
'Each of the SUBs corresponds to an expression from EasyCalculate
'For example: "polygon_Return_Area" is the equivalent of "polygon_Return_Area.cal"
'Read EasyCalculatePlus.htm to see how to convert any expression of EasyCalculate
'to a SUB that can be run programatically.

Public Sub polygon_Return_Area(sPreExpression As String, sExpression As String)
  sPreExpression = _
  "Dim pMxDoc As IMxDocument" & vbNewLine & _
  "Dim pGeometry As IGeometry" & vbNewLine & _
  "Dim pMap As IMap" & vbNewLine & _
  "Dim pArea As IArea" & vbNewLine & _
  "Dim dArea As Double" & vbNewLine & _
  "Set pMxDoc = ThisDocument" & vbNewLine & _
  "Set pMap = pMxDoc.FocusMap" & vbNewLine & _
  "If (IsNull([Shape])) Then" & vbNewLine & _
  "  dArea = -1" & vbNewLine & _
  "Else" & vbNewLine & _
  "  Set pGeometry = [Shape]" & vbNewLine & _
  "  If (pGeometry.IsEmpty) Then" & vbNewLine & _
  "    dArea = -1" & vbNewLine & _
  "  Else" & vbNewLine & _
  "    pGeometry.Project pMap.SpatialReference" & vbNewLine & _
  "    Set pArea = pGeometry" & vbNewLine & _
  "    dArea = pArea.Area" & vbNewLine & _
  "  End If" & vbNewLine & _
  "End If"
  sExpression = "dArea"
End Sub
Public Sub shape_Return_Length(sPreExpression As String, sExpression As String)
  sPreExpression = _
  "Dim pMxDoc As IMxDocument" & vbNewLine & _
  "Dim pGeometry As IGeometry" & vbNewLine & _
  "Dim pMap As IMap" & vbNewLine & _
  "Dim pCurve As ICurve" & vbNewLine & _
  "Dim dLength As Double" & vbNewLine & _
  "Set pMxDoc = ThisDocument" & vbNewLine & _
  "Set pMap = pMxDoc.FocusMap" & vbNewLine & _
  "If (IsNull([Shape])) Then" & vbNewLine & _
  "  dLength = -1" & vbNewLine & _
  "Else" & vbNewLine & _
  "  Set pGeometry = [Shape]" & vbNewLine & _
  "  If (pGeometry.IsEmpty) Then" & vbNewLine & _
  "    dLength = -1" & vbNewLine & _
  "  Else" & vbNewLine & _
  "    pGeometry.Project pMap.SpatialReference" & vbNewLine & _
  "    Set pCurve = pGeometry" & vbNewLine & _
  "    dLength = pCurve.Length" & vbNewLine & _
  "  End If" & vbNewLine & _
  "End If"
  sExpression = "dLength"
End Sub
Public Sub polyline_Get_X_MiddlePoint(sPreExpression As String, sExpression As String, _
                                     dDistance As Double, bAsRatio As Boolean)
  sPreExpression = _
  "Dim pMxDoc As IMxDocument" & vbNewLine & _
  "Dim pMap As IMap" & vbNewLine & _
  "Dim pCurve As ICurve" & vbNewLine & _
  "Dim pMiddlePoint As IPoint" & vbNewLine & _
  "Dim dXMiddle As Double" & vbNewLine & _
  "Dim dDistance As Double" & vbNewLine & _
  "Dim bAsRatio As Boolean" & vbNewLine & _
  "Set pMxDoc = ThisDocument" & vbNewLine & _
  "Set pMap = pMxDoc.FocusMap" & vbNewLine & _
  "If (Not IsNull([Shape])) Then" & vbNewLine & _
  "  Set pCurve = [Shape]" & vbNewLine & _
  "  If (Not pCurve.IsEmpty) Then" & vbNewLine & _
  "    pCurve.Project pMap.SpatialReference" & vbNewLine & _
  "    Set pMiddlePoint = New Point" & vbNewLine & _
  "    pCurve.QueryPoint 0, dDistance, bAsRatio, pMiddlePoint" & vbNewLine & _
  "    dXMiddle = pMiddlePoint.X" & vbNewLine & _
  "  End If" & vbNewLine & _
  "End If"
  sExpression = "dXMiddle"
End Sub
Public Sub mp_get_X_Center(sPreExpression As String, sExpression As String)
  sPreExpression = _
  "Dim pMxDoc As IMxDocument" & vbNewLine & _
  "Dim pGeometry As IGeometry" & vbNewLine & _
  "Dim pMap As IMap" & vbNewLine & _
  "Dim pPolygon As IPolygon" & vbNewLine & _
  "Dim pTopOp As ITopologicalOperator" & vbNewLine & _
  "Dim pArea As IArea" & vbNewLine & _
  "Dim pCenPoint As IPoint" & vbNewLine & _
  "Dim dX As Double" & vbNewLine & _
  "Set pMxDoc = ThisDocument" & vbNewLine & _
  "Set pMap = pMxDoc.FocusMap" & vbNewLine & _
  "If (Not IsNull([Shape])) Then" & vbNewLine & _
    "Set pGeometry = [Shape]" & vbNewLine & _
    "If (Not pGeometry.IsEmpty) Then" & vbNewLine & _
    "  Set pTopOp = pGeometry" & vbNewLine & _
    "  Set pPolygon = pTopOp.ConvexHull" & vbNewLine & _
    "  Set pArea = pPolygon" & vbNewLine & _
    "  Set pCenPoint = pArea.Centroid" & vbNewLine & _
    "  dX = pCenPoint.X" & vbNewLine & _
    "End If" & vbNewLine & _
  "End If"
  sExpression = "dX"
End Sub
Public Sub polyline_Flip(sPreExpression As String, sExpression As String)
  sPreExpression = _
  "Dim pMxDoc As IMxDocument" & vbNewLine & _
  "Dim pMap As IMap" & vbNewLine & _
  "Dim pCurve As ICurve" & vbNewLine & _
  "Set pMxDoc = ThisDocument" & vbNewLine & _
  "Set pMap = pMxDoc.FocusMap" & vbNewLine & _
  "If (Not IsNull([Shape])) Then" & vbNewLine & _
  "Set pCurve = [Shape]" & vbNewLine & _
  "If (Not pCurve.IsEmpty) Then" & vbNewLine & _
  "    pCurve.Project pMap.SpatialReference" & vbNewLine & _
  "    pCurve.ReverseOrientation" & vbNewLine & _
  "  End If" & vbNewLine & _
  "End If"
  sExpression = "pCurve"
End Sub
Public Sub polygon_Get_X_Center(sPreExpression As String, sExpression As String)
  sPreExpression = _
  "Dim pMxDoc As IMxDocument" & vbNewLine & _
  "Dim pGeometry As IGeometry" & vbNewLine & _
  "Dim pMap As IMap" & vbNewLine & _
  "Dim pArea As IArea" & vbNewLine & _
  "Dim pCenter As IPoint" & vbNewLine & _
  "Dim dXCenter As Double" & vbNewLine & _
  "Set pMxDoc = ThisDocument" & vbNewLine & _
  "Set pMap = pMxDoc.FocusMap" & vbNewLine & _
  "If (Not IsNull([Shape])) Then" & vbNewLine & _
  "  Set pGeometry = [Shape]" & vbNewLine & _
  "  If (Not pGeometry.IsEmpty) Then" & vbNewLine & _
  "    pGeometry.Project pMap.SpatialReference" & vbNewLine & _
  "    Set pArea = pGeometry" & vbNewLine & _
  "    Set pCenter = pArea.Centroid" & vbNewLine & _
  "    dXCenter = pCenter.X" & vbNewLine & _
  "  End If" & vbNewLine & _
  "End If"
  sExpression = "dXCenter"
End Sub
Public Sub point_Get_X(sPreExpression As String, sExpression As String)
  sPreExpression = _
  "Dim pMxDoc As IMxDocument" & vbNewLine & _
  "Dim pMap As IMap" & vbNewLine & _
  "Dim pPoint As IPoint" & vbNewLine & _
  "Dim dX As Double" & vbNewLine & _
  "Set pMxDoc = ThisDocument" & vbNewLine & _
  "Set pMap = pMxDoc.FocusMap" & vbNewLine & _
  "If (Not IsNull([Shape])) Then" & vbNewLine & _
  "  Set pPoint = [Shape]" & vbNewLine & _
  "  pPoint.Project pMap.SpatialReference" & vbNewLine & _
  "  dX = pPoint.X" & vbNewLine & _
  "End If"
  sExpression = "dX"
End Sub
Public Sub point_Get_M(sPreExpression As String, sExpression As String)
  sPreExpression = _
  "Dim pMxDoc As IMxDocument" & vbNewLine & _
  "Dim pMap As IMap" & vbNewLine & _
  "Dim pPoint As IPoint" & vbNewLine & _
  "Dim dM As Double" & vbNewLine & _
  "Dim pMAware As IMAware" & vbNewLine & _
  "Set pMxDoc = ThisDocument" & vbNewLine & _
  "Set pMap = pMxDoc.FocusMap" & vbNewLine & _
  "If (Not IsNull([Shape])) Then" & vbNewLine & _
  "Set pPoint = [Shape]" & vbNewLine & _
  "Set pMAware = pPoint" & vbNewLine & _
  "pPoint.Project pMap.SpatialReference" & vbNewLine & _
  "If (pMAware.MAware) Then" & vbNewLine & _
    "  dM = pPoint.M" & vbNewLine & _
    "Else" & vbNewLine & _
    "  dM = -1" & vbNewLine & _
    "End If" & vbNewLine & _
  "End If"
  sExpression = "dM"
End Sub
