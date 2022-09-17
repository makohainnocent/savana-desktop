
Func cameraShot()
	
	Local $epoch=generateDateTime()
	
	$filename=generateNameFromDateTime()&".jpg"
	
	$filePath=@WorkingDir & "\files\cameraShots\"&$filename
	
	if Not FileExists(@WorkingDir & "\files\cameraShots\") Then
		
		DirCreate(@WorkingDir & "\files\cameraShots\")
		
	EndIf
	
	Local $exitCode = RunWait(@WorkingDir&"\lib\bin\commandCam.exe  /filename "&$filePath, "", @SW_HIDE)
	
	if  $exitCode==0 Then
		
		putCameraShot($computer_serial,$epoch,$filename,$filePath)
		
		
	Else
		handleErrors("cameraShot", "commandCame exit code-"&$exitCode)
	
	EndIf

	if @error then 
		
		handleErrors("cameraShot", @error)
		
	EndIf
	
EndFunc


Func cameraShotOnDemand()
	
	Local $epoch=generateDateTime()
	
	$filename=generateNameFromDateTime()&".jpg"
	
	$filePath=@WorkingDir & "\files\cameraShots\"&$filename
	
	if Not FileExists(@WorkingDir & "\files\cameraShots\") Then
		
		DirCreate(@WorkingDir & "\files\cameraShots\")
		
	EndIf
	
	Local $exitCode = RunWait(@WorkingDir&"\lib\bin\commandCam.exe  /filename "&$filePath, "", @SW_HIDE)
	
	if  $exitCode==0 Then
		
		MsgBox(64,"",$filePath)
		
		Return $filePath
		
	Else
		
		Return "fail"
	
	EndIf

	if @error then 
		
		handleErrors("cameraShot", @error)
		
	EndIf
	
EndFunc