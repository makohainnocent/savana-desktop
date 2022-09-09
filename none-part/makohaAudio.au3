#pragma compile(Console, True)

#include "modules/Media.au3"

Local $parameters=$CmdLine[0]


if $parameters<=1 Then
	
	ConsoleWrite(@CRLF&@CRLF&"WELCOME TO MAKOHA AUDIO RECORDER"&@CRLF)
	
	ConsoleWrite("--------------------------------------------------------"&@CRLF)
	
	ConsoleWrite(@CRLF&@CRLF&"parameter 1 is the  time in seconds  and  parameter 2 is the output file")
	
Else
	
	Local $param1=$CmdLine[1] 

	Local $param2=$CmdLine[2] 

	$Media=_MediaCreate(6)
	
	_MediaRecord($Media)
	
	ConsoleWrite("recording...............")
	
	sleep(($param1)*1000)
	
	_MediaStop($Media)
	
	If @error Then
		
		_MediaClose($Media)
	
	EndIf

    
         _MediaSave($Media,$param2)
	
	
	_MediaClose($Media)
	
EndIf