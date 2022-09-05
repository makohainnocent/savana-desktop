;the sqlite3.dll only loads when you use "SQLite.dll.au3" downloaded from https://www.autoitscript.com/autoit3/pkgmgr/sqlite/
;sqlite3.dll must be placed in working directory and not in subfolder

Func sqliteStart()
	
	 _SQLite_Startup()
	 
	$databaseHandle=_SQLite_Open($databaseFile)
	
EndFunc

Func sqliteStop()
	
	_SQLite_Close()
	
	_SQLite_Shutdown()
	
EndFunc

Func putErrorLocal($computer_serial,$company_id,$module,$error)
	
	sqliteStart()
	
	 _SQLite_Exec($databaseHandle, "INSERT INTO application_errors(id,module,company_id,error,computer_serial) VALUES (Null,'$module$','$company_id$','$error$','$computer_serial$');") 
	
    if @error Then
		
		sqliteStop()
		
		local $error_=_SQLite_ErrMsg ($databaseHandle)
		
		return $error_
		
		
	Else
		
		sqliteStop()
		
		return "ok"
		
	EndIf
	
EndFunc


Func PutScreenShotLocal($computer_serial,$epoch,$filename,$filePath) 
	
	sqliteStart()
	
	 _SQLite_Exec($databaseHandle, "INSERT INTO screen_shots(id,file,computer_serial,epoch) VALUES (Null,'$filePath$','$computer_serial$','$epoch$');") 
	
    if @error Then
		
		sqliteStop()
		
		local $error_=_SQLite_ErrMsg ($databaseHandle)
		
		return $error_
		
		
	Else
		
		sqliteStop()
		
		return "ok"
		
	EndIf
	
EndFunc

Func PutCameraShotLocal($computer_serial,$epoch,$filename,$filePath) 
	
	sqliteStart()
	
	 _SQLite_Exec($databaseHandle, "INSERT INTO camera_shots(id,file,computer_serial,epoch) VALUES (Null,'$filePath$','$computer_serial$','$epoch$');") 
	
    if @error Then
		
		sqliteStop()
		
		local $error_=_SQLite_ErrMsg ($databaseHandle)
		
		return $error_
		
		
	Else
		
		sqliteStop()
		
		return "ok"
		
	EndIf
	
EndFunc




