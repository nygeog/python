dim filesys, newfolder

set filesys=CreateObject("Scripting.FileSystemObject")
If Not filesys.FolderExists("c:\program files\arcgis\custom\") Then
   newfolder = filesys.CreateFolder ("c:\program files\arcgis\custom\")
   msgbox "A new folder '" & newfolder & "' has been created"
End If

If filesys.FileExists("RedirectDataSources.dll") Then
   filesys.CopyFile "RedirectDataSources.dll", "c:\program files\arcgis\custom\"
End If