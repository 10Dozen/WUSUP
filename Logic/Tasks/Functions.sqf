#define	CSELECT(X,Y)	([X, Y] call BIS_fnc_conditionalSelect) select 0
dzn_fnc_tasks_getRandomTask = {
	selectRandom (synchronizedObjects tasksCore)
};

dzn_fnc_tasks_activateTask = {	
	private _syncObjs = synchronizedObjects _this;

	/*
		Start position
	*/
	private _startPosCore = CSELECT(_syncObjs, { typeof _x == "LocationArea_F" });
	Task_StartPos = getPosASL ( 
		selectRandom ( 
			[
				synchronizedObjects _startPosCore
				, { typeof _x == "LocationArea_F" }
			] call BIS_fnc_conditionalSelect
		)
	);

	/*
		Seize Area
	*/
	Task_SeizeArea = CSELECT(_syncObjs, { _x isKindOf "EmptyDetector" });

	/* 
		Dynai Zones
	*/
	private _dynaiZonesCore = CSELECT(_syncObjs, { typeof _x == "LocationCamp_F" });
	Task_DynaiZone_Main = CSELECT(synchronizedObjects _dynaiZonesCore, { typeof _x == "LocationBase_F" });
	Task_DynaiZone_Reinforcement = CSELECT(synchronizedObjects _dynaiZonesCore, { typeof _x == "LocationOutpost_F" });
	
	/*
		Publish
	*/
	
	waitUntil { time > dzn_tasks_taskCreateDelay };
	call dzn_fnc_tasks_createSimpleTask;	
	call dzn_fnc_tasks_runSeizeAreaHandler;
	
	publicVariable "Task_StartPos";
	publicVariable "Task_SeizeArea";
	publicVariable "Task_DynaiZone_Main";
	publicVariable "Task_DynaiZone_Reinforcement";	
};

dzn_fnc_tasks_createSimpleTask = {	
	// Set marker
	"mrk_task" setMarkerPos (getPosASL Task_SeizeArea);
	"mrk_task" setMarkerAlpha 1;

	// Create BIS simple task
	[
		west
		, ["task_1"]
		, [dzn_tasks_TaskDesc, dzn_tasks_TaskTitle, "mrk_task"]
		, objNull
		, 1
		, 8
		,true
		, ""
		, true
	] call BIS_fnc_taskCreate;
};

dzn_fnc_tasks_runSeizeAreaHandler = {	
	dzn_tasks_canCheckSeize = true;
	dzn_tasks_waitAndCheckSeize = {
		dzn_tasks_canCheckSeize = false;
		sleep 1;
		dzn_tasks_canCheckSeize = true;
	};	
	
	["dzn_task_seizeChecker", "onEachFrame", {
		if (!dzn_tasks_canCheckSeize || !(isNil "Task_SeizeArea_Done")) exitWith {};
		[] spawn dzn_tasks_waitAndCheckSeize;
		
		// If no players in area or there are enemy troops in the area -- nil the counter
		if (
			!([Task_SeizeArea, "bool"] call dzn_fnc_isPlayerInArea)
			|| { { (side _x == east) && {_x inArea Task_SeizeArea} } count allUnits > 0 }
		) exitWith { Task_SeizeArea_Counter = nil; };
		
		// If players persist -- add +1 sec to counter
		Task_SeizeArea_Counter = if (isNil "Task_SeizeArea_Counter") then { 0 } else { Task_SeizeArea_Counter + 1 };
		
		// If counter ends -- Done this stuff
		if (Task_SeizeArea_Counter > dzn_tasks_seizeTime) then {
			Task_SeizeArea_Done = true;
			publicVariable "Task_SeizeArea_Done";
		};
	}] call BIS_fnc_addStackedEventHandler;
};

dzn_fnc_tasks_client_movePlayerToStartPos = {	
	"mrk_start" setMarkerPos Task_StartPos;
	"mrk_start" setMarkerAlpha 1;
	
	player setPosASL Task_StartPos;
};

