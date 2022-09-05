
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



Func generateDurrationFromSeconds($seonds)
	
	 local $nr_sec,$sec2time_hour,$sec2time_min, $sec2time_sec
	
	 $nr_sec=$seonds
	
	 $sec2time_hour = Int($nr_sec / 3600)
	
     $sec2time_min = Int(($nr_sec - $sec2time_hour * 3600) / 60)
   
     $sec2time_sec = $nr_sec - $sec2time_hour * 3600 - $sec2time_min * 60
   
     Return StringFormat('%02d:%02d:%02d', $sec2time_hour, $sec2time_min, $sec2time_sec)
	
EndFunc
	
