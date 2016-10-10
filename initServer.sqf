("par_weather" call BIS_fnc_getParamValue) spawn dzn_fnc_setWeather;

if !(hasInterface) then {
	[] execVM "Logic\Roles\Init.sqf";
	[] execVM "Logic\Tasks\Init.sqf";	
};

// [] execVM "Logic\Hostiles\Init.sqf";

EndGameTimerLimit = ("par_endgametimer" call BIS_fnc_getParamValue)*60;
EndGameTimer = EndGameTimerLimit;

[] spawn {
	for "_i" from 0 to EndGameTimerLimit do {
		sleep 1;
		EndGameTimer = EndGameTimer - 1;	
	};
};

