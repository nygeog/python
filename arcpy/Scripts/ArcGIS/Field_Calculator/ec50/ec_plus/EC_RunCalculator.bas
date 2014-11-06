Attribute VB_Name = "EC_RunCalculator"
'Uses the selected (highlighted) layer in the TOC
'The SUBs in the EC_Expressions.bas module are used
'The parameters sPreExpression & sExpression are required for all SUBs
'Some of the SUBs require additional parameters
'example1 - no additional parameters required
'Call EC_Expressions.polygon_Return_Area(sPreExpression, sExpression)
'example2 - two additional parameters required:
'Call EC_Expressions.polyline_Get_X_MiddlePoint(sPreExpression, sExpression, 0.5, True)

Private Sub EC_Run_Calc()
  Dim pMxDoc As IMxDocument
  Dim pLayer As IUnknown
  Dim pFLayer As IFeatureLayer
  Dim pFeatureClass As IFeatureClass
  Dim pCalc As ICalculator
  Dim pCursor As ICursor
  Dim sPreExpression As String
  Dim sExpression As String
  Dim sFieldName As String
  On Error GoTo EH
  'The following is for VBA, in VB different approach should
  'be used to get the document
  Set pMxDoc = ThisDocument
  Set pLayer = pMxDoc.SelectedItem
  '
  If Not TypeOf pLayer Is IFeatureLayer Then
    MsgBox "The selected item is not a feature layer"
    Exit Sub
  End If
  Set pFLayer = pLayer
  Set pFeatureClass = pFLayer.FeatureClass
  'Set the name of the field to be calculated
  sFieldName = "Area"
  'Check whether the field exists
  If (pFeatureClass.FindField(sFieldName) = -1) Then
    MsgBox "Field not found"
    Exit Sub
  End If
  'call the appropriate SUB to get the PreExpression and Expression required
  Call EC_Expressions.polygon_Return_Area(sPreExpression, sExpression)
  'perform the calculations
  Set pCalc = New Calculator
  Set pCursor = pFeatureClass.Update(Nothing, True)
  With pCalc
     Set .Cursor = pCursor
     .PreExpression = sPreExpression
     .Expression = sExpression
     .Field = sFieldName
  End With
  pCalc.Calculate
  Set pMxDoc = Nothing
  Set pLayer = Nothing
  Set pFeatureClass = Nothing
  Set pCalc = Nothing
  Set pCursor = Nothing
  Exit Sub
EH:
  MsgBox Err.Description
  Set pMxDoc = Nothing
  Set pLayer = Nothing
  Set pFeatureClass = Nothing
  Set pCalc = Nothing
  Set pCursor = Nothing
End Sub

