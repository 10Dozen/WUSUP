
dzn_fnc_notif_getTimelabel = {
	private _time = _this;
	
	private _hour = 0;
	private _sec = _time % 60;
	private _min = floor (_time / 60);
	if (_min > 60) then {
		_hour = floor(_min / 60);
		_min = _min - _hour*60;
	};
	
	#define ADD_PREFIX_ZERO(X)	if (X >= 10) then { X } else { "0" + str(X) }
	format [
		"%1:%2:%3"
		, ADD_PREFIX_ZERO(_hour) 
		, ADD_PREFIX_ZERO(_min)
		, ADD_PREFIX_ZERO(_sec)
	];	
};

dzn_fnc_showHoldNotification = {
	/* format ["<t color='#aaff00' size='0.75' font='PuristaLight'>HOLD POSITION<br /> 00:00:0%1</t>",_i]

		"<t font='PuristaLight' size='0.75'><t color='#AAFF00' align='left'>HOLD!</t><br /><t color='%2' >%1</t></t>";
	*/
	
	private _compileAndShow = {	
		[_this,-1,-0.2,dzn_tasks_seizeTime,0,0,789] spawn BIS_fnc_dynamicText;	
	};
	
	private _hide = {
		["",-1,-0.2	,4 ,0 ,0 ,789] spawn BIS_fnc_dynamicText; 	
	};
	
	
	private _line = "";

	for "_i" from 1 to dzn_tasks_seizeTime do {
		if (isNil "Task_SeizeArea_Counter") exitWith { call _hide; };
		
		_line = format [
			dzn_notif_holdLeftLine
			, ((dzn_tasks_seizeTime - Task_SeizeArea_Counter) max 0) call dzn_fnc_notif_getTimelabel
			, if (dzn_tasks_seizeTime - Task_SeizeArea_Counter < dzn_notif_holdLeftCritical) then {
				dzn_notif_holdLeftCritical_Color
			} else {
				dzn_notif_defaultColor
			}
		];		
		
		_line call _compileAndShow;
		sleep 1;
	};
	
	call _hide;
};

dzn_fnc_notif_showTimeNotification = {
	#define EXIT_ORBAT_DRAWN	if (!isNil "dzn_roles_OrbatDrawn" && { dzn_roles_OrbatDrawn }) exitWith {}
	
	private _compileAndShow = {
		hintSilent parseText _this;
	};
	private _hide = { hintSilent ""; };
	private _line = "";
	
	for "_i" from 1 to 15 do {
		EXIT_ORBAT_DRAWN;
		
		_line = format [
			dzn_notif_timeLeftLine
			, (EndGameTimer max 0) call dzn_fnc_notif_getTimelabel
			, if (EndGameTimer < dzn_notif_timeLeftCritical) then {
				dzn_notif_timeLeftCritical_Color
			} else {
				dzn_notif_defaultColor
			}
		];
	
	
		_line call _compileAndShow;
		sleep 1;
	};

	EXIT_ORBAT_DRAWN;
	call _hide;
};

dzn_fnc_notif_runTimeNotifHandler = {
	waitUntil { sleep 1; EndGameTimer < dzn_notif_timeLeftCritical*2 };
	[] spawn dzn_fnc_notif_showTimeNotification;
};

dzn_fnc_notif_runCaptureNotifHandler = {
	waitUntil {!isNil "dzn_tasks_seizeTime"};
	dzn_notif_canCheckHold = true;
	dzn_fnc_notif_waitAndCheckHold = {dzn_notif_canCheckHold=false;sleep 1;dzn_notif_canCheckHold=true;};
	
	["dzn_notif_captureHandler", "onEachFrame", {
		if !(dzn_notif_canCheckHold) exitWith {};
		[] spawn dzn_fnc_notif_waitAndCheckHold;
		
		if (!isNil "Task_SeizeArea_Counter") then {
			[] spawn dzn_fnc_showHoldNotification;		
		};	
	}] call BIS_fnc_addStackedEventHandler;

};


/*
	ORBAT Topic
*/
dzn_fnc_notif_addORBATTopic = {
	player createDiarySubject ["orbatTopic","ORBAT"];
	player createDiaryRecord [
		"orbatTopic"
		, [
			"ORBAT"
			, "<font color='#B0E84F'><execute expression='call dzn_fnc_roles_showORBAT'>Show ORBAT</execute></font>"
		]
	];
};

dzn_fnc_notif_addTimeTopics = {
	player createDiarySubject ["timeTopic","Game Timer"];
	player createDiaryRecord [
		"timeTopic"
		, [
			"Game Timer"
			, "<font color='#B0E84F'><execute expression='[] spawn dzn_fnc_notif_showTimeNotification'>Show Time left</execute></font>"
		]
	];
};

/*
[] spawn { for "_i" from 0 to 2 do { 
 
["<t font='PuristaLight'><t color='#AAFF00' align='left'>HOLD!</t><t color='%2' align='right'>%1</t></t>" 
,-1.,-0.2 
,4 
,0 
,0 
,789] spawn BIS_fnc_dynamicText; 
sleep 1; 
}; }




"<t color='#aaff00' size='0.75' font='PuristaLight'>HOLD POSITION<br /> 00:00:01</t>" call BIS_fnc_titleText


*/