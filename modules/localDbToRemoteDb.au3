
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



