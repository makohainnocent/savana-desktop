
Func putError($computer_serial,$company_id,$module,$error)
	
	Local $address=$serverAddress&"/putError/computer_serial/"&$computer_serial&"/company_id/"&$company_id&"/module/"&$module&"/error/"&$error
	
	Local $result= _HTTP_Get($address)
	
	MsgBox(64, "" ,$address)
	
	if $result<>"ok"  Then
		
		;there is a problem with the remote database lets store in the local one
		Local $result=putErrorLocal($computer_serial,$company_id,$module,$error)
		
		Return $result
		
	EndIf
	
	
	if @error Then
		
		Return False
		
	EndIf
		
	
EndFunc