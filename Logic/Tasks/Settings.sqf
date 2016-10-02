dzn_tasks_taskInitDelay = 8;
dzn_tasks_taskCreateDelay = 18;

dzn_tasks_seizeTime = "par_capturetimer" call BIS_fnc_getParamValue;

dzn_tasks_TaskTitle = "Capture and Hold";
dzn_tasks_TaskDesc = format ["Capture marked and area and hold it for %1 seconds.", dzn_tasks_seizeTime];

dzn_tasks_hostileFaction = 	[
						"usarmy" 	/*"US Army"*/
						,"usmc" 	/*"USMC"*/
						,"ruvv" 	/*"RU VV"*/
						,"rebels" 	/*"Rebels"*/
						,"pmc" 	/*"PMC"*/
					] select ("par_hostileFaction" call BIS_fnc_getParamValue);

dzn_tasks_hostileArmor = [ "no", "car", "apc", "icv", "mbt" ] select ("par_hostileArmor" call BIS_fnc_getParamValue);