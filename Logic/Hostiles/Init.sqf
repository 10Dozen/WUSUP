if !(isServer || isDedicated) exitWith {};

call compile preprocessFileLineNumbers "Logic\Hostiles\Settings.sqf";
call compile preprocessFileLineNumbers "Logic\Hostiles\Functions.sqf";

waitUntil { time > dzn_hostiles_initDelay };
waitUntil { !isNil "Task_DynaiZone_Main" && !isNil "Task_DynaiZone_Reinforcement" };

// Set Tasks areas to DynAI zones
call dzn_fnc_hostiles_addLocationsMain;
call dzn_fnc_hostiles_addLocationsReinforcement;

dzn_hostiles_LocationsSet = true;

waitUntil { !isNil "dzn_dynai_initialized" && { dzn_dynai_initialized } };

// Update groups and activate Main
call dzn_fnc_hostiles_updateGroups;
Main call dzn_fnc_dynai_activateZone;

// Reinforcements
[] spawn dzn_fnc_hostiles_runReinfocementCaller;

waitUntil { !isNil "dzn_hostiles_reinforcementsCalled" };
Reinforcement call dzn_fnc_dynai_activateZone;
[
	Reinforcement
	, call dzn_fnc_hostiles_getReinforcementRandomPositions
	, "PATROL"
] call dzn_fnc_dynai_moveGroups;