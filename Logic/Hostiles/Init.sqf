if !(isServer || isDedicated) exitWith {};

call compile preprocessFileLineNumbers "Logic\Tasks\Settings.sqf";
call compile preprocessFileLineNumbers "Logic\Tasks\Functions.sqf";

waitUntil { time > dzn_tasks_taskInitDelay };
waitUntil { !isNil "Task_DynaiZone_Main" && !isNil "Task_DynaiZone_Reinforcement" };

call dzn_fnc_hostiles_addLocationsMain;
call dzn_fnc_hostiles_addLocationsReinforcement;

dzn_hostiles_LocatonsSet = true;

waitUntil { !isNil "dzn_dynai_initialized" && { dzn_dynai_initialized } };

