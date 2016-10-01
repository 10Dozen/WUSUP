
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


dzn_fnc_notif_showNotification = {
	params[["_showTime", true],["_showHold",false], ["_loopTime", 10]];
	
	if (!isNil "Task_SeizeArea_Counter") then {
		_showHold = true;
	};	
	
	private _compileAndShow = {
		private _notif = "";
		{
			_notif = format ["%1%3%2", _notif,  _x, if (_forEachIndex > 0) then { "<br />" } else { "" }];
		} forEach _this;	
		
		LINE = _notif;
		
		hintSilent parseText _notif;	
	};
	
	for "_i" from 0 to _loopTime do {
		
		private _lines = [];
		if (_showTime) then {
			_lines pushBack (
				format [
					dzn_notif_timeLeftLine					
					, _i call dzn_fnc_notif_getTimelabel
					, dzn_notif_defaultColor
				]
			);
		};
		
		if (_showHold) then {
			_lines pushBack (
				format [
					dzn_notif_holdLeftLine					
					, _i call dzn_fnc_notif_getTimelabel
					, dzn_notif_defaultColor
				]
			);
		};
		
		_lines call _compileAndShow;
		sleep 1;
	};
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
			, "<font color='#B0E84F'><execute expression='[] spawn dzn_fnc_notif_showNotification'>Show Time left</execute></font>"
		]
	];
};