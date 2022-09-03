
Func generateNameFromDateTime()
	
	;get system date time expressed in utc
	Local $tCur = _Date_Time_GetSystemTime()
	
	$tCur=_Date_Time_SystemTimeToDateTimeStr($tCur)
	
	;remove special characters from filename
	local  $filename=StringReplace($tCur,"/","_")
	
	;remove special characters from filename
	$filename=StringReplace($filename,"\","_")
	
	;remove special characters from filename
	$filename=StringReplace($filename,":","_")
	
	;remove carriage return from filename
	$filename=StringStripCR($filename)
	
	;remove white space from filename
	$filename=StringStripWS($filename,$STR_STRIPALL)
	
	Return $filename
	
EndFunc 


Func generateDateTime()
	
	;get system date time expressed in utc
	Local $tCur = _Date_Time_GetSystemTime()
	
	;yyyy/mm/dd hh:mm:ss 
	$tCur=_Date_Time_SystemTimeToDateTimeStr($tCur,1)
	
	Return $tCur
	
EndFunc
	
