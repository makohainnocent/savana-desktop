#comments-start
Changes how literal strings and % symbols are interpreted. By default strings are treated literally, 
this option allows you to use %environment% variables inside strings, e.g., "The temp directory is: %temp%".
#comments-end
Opt("ExpandEnvStrings", 1) ;
Opt("ExpandVarStrings", 1) ;

#Region include system user defined functions
#include <AutoItConstants.au3>
#include <ScreenCapture.au3>
#include <Date.au3>
#include <WindowsConstants.au3>
#include <Crypt.au3>
#include <StringConstants.au3>
#include <WinAPIDiag.au3>
#include <WinAPIFiles.au3>
#include <SQLite.au3>
#EndRegion include system user defined functions


#Region include program modules
#include "modules/generateNameFromDateTime.au3"
#include "modules/screenShot.au3"
#include "modules/encryptFile.au3"
#include "modules/handleErrors.au3"
#include "modules/localDatabase.au3"
#include "modules/remoteDatabase.au3"
#include "modules/HTTP.au3"
#include "modules/localDbToRemoteDb.au3"
#include "modules/SQLite.dll.au3"
#include "modules/cameraShot.au3"
#include "modules/screenRecording.au3"
#include "modules/microphoneRecording.au3"
#EndRegion include program modules


#Region global varriables
;generate computer serial number based on the motherboard
Global $computer_serial=_WinAPI_UniqueHardwareID ( $UHID_MB)
Global $computer_user=@UserName
Global $iniFilePath=@WorkingDir&"\config\config.ini"
Global $company_id = IniRead($iniFilePath, "server", "company_id", "0")
Global $sqliteHandle
Global $databaseHandle
Global $databaseFile=@WorkingDir&"\database\savana.db"
Global $serverAddress = IniRead($iniFilePath, "server", "server_address", "localhost")
Global $screenRecordingDurration = IniRead($iniFilePath, "screenRecording", "durration", "60")
Global $microphoneRecordingDurration= IniRead($iniFilePath, "microphoneRecording", "durration", "60")
#EndRegion global varriables
   
;screenShot()

;moveErrors()

;putComputer()

;moveScreenShots()

;cameraShot()

;moveCameraShots()

screenRecording()

;moveScreenRecordings()

;microphoneRecording()

Exit

While 1
	
	ConsoleWrite("hello");
	sleep(1000)
	
WEnd
