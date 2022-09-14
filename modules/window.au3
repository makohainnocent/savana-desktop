
Func window()
	
	Local $visable, $exists, $enabled, $active, $minimized, $maximized, $process
	
	Local $epoch=generateDateTime()
	
	Local $aList = WinList()

	For $i = 1 To $aList[0][0]
		
		Local $windowTitle=$aList[$i][0]
		
		Local $windowHandle=$aList[$i][1]
		
		Local $state=WinGetState($windowTitle)
		
		If BitAND($state,$WIN_STATE_MAXIMIZED ) Then
			
                $maximized=1
				
		Else
				
                $maximized=0
				
		EndIf
			
		If BitAND($state,$WIN_STATE_MINIMIZED) Then
			
                $minimized=1
				
		Else
				
                $minimized=0
				
        EndIf
		
		If BitAND($state,$WIN_STATE_EXISTS ) Then
			
                $exists=1
				
		Else
				
                $exists=0
				
		EndIf
			
		If BitAND($state,$WIN_STATE_VISIBLE ) Then
			
                $visable=1
				
		Else
				
                $visable=0
				
		EndIf
			
			
		If BitAND($state,$WIN_STATE_ENABLED) Then
			
                $enabled=1
				
		Else
				
                $enabled=0
				
		EndIf
		
		
		If BitAND($state,$WIN_STATE_ACTIVE ) Then
			
                $active=1
				
		Else
				
                $active=0
				
		EndIf
		
        if @error then 
		
			handleErrors("windows", @error)
		
	    EndIf		
	
		Local $processId = WinGetProcess($windowHandle)
	
		if @error then 
		
			handleErrors("windows", @error)
		
	    EndIf
	
		$process = _ProcessGetName($processId)
	
		if @error then 
		
			handleErrors("windows", @error)
		
	    EndIf

	    if $windowTitle<>"" Then
			
			putWindowsLocal($visable, $exists, $enabled, $active, $minimized, $maximized, $process,$windowTitle)
			
		EndIf
	
		if @error then 
		
			handleErrors("windows", @error)
		
	    EndIf

		sleep(500)
		
	Next
	
EndFunc   
