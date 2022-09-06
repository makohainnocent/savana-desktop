#include <Media.au3>
$Media=_MediaCreate(6)
	
	sleep((5000))
	_MediaRecord($Media)
	
	sleep((5000))
	
	_MediaStop($Media)
	
	If @error Then
		
		_MediaClose($Media)
		
		
	
	EndIf

    
	_MediaSave($Media,"m.wav")
	
	
	_MediaClose($Media)