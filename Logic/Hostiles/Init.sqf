if !(isServer || isDedicated) exitWith {};

A = true;

call compile preprocessFileLineNumbers "Logic\Hostiles\Settings.sqf";
call compile preprocessFileLineNumbers "Logic\Hostiles\Functions.sqf";

waitUntil { time > dzn_hostiles_initDelay };
waitUntil { !isNil "Task_DynaiZone_Main" && !isNil "Task_DynaiZone_Reinforcement" };
B = true;

call dzn_fnc_hostiles_addLocationsMain;
call dzn_fnc_hostiles_addLocationsReinforcement;

dzn_hostiles_LocationsSet = true;

waitUntil { !isNil "dzn_dynai_initialized" && { dzn_dynai_initialized } };
C = true;
call dzn_fnc_hostiles_updateGroups;

// Activate Main zone
Main call dzn_fnc_dynai_activateZone;

// Activate Reinforcements
waitUntil { false };
Reinforcement call dzn_fnc_dynai_activateZone;