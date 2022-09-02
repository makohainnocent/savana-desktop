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
		
		return "sqlite3 error"
		
		
	Else
		
		sqliteStop()
		
		return "ok"
		
	EndIf
	
EndFunc




