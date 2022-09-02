Func handleErrors($module,$error)
	
	$result=putError( $computer_serial,$company_id,$module,$error)
	
	if $result<>"ok" Then
	
		;problem with database logging lets log to file instead
		if Not FileExists(@WorkingDir & "\files\logs") Then
			
			DirCreate(@WorkingDir & "\files\logs")
			
		EndIf
		
		Local $hFileOpen = FileOpen(@WorkingDir & "\files\logs\error_log.csv", $FO_APPEND)
		
        If $hFileOpen = -1 Then
			
			Return False
			
        EndIf
		
		FileWrite($hFileOpen, "$computer_serial,$company_id$,$module$,$error$")

        FileClose($hFileOpen)

		
	EndIf
	
	
EndFunc