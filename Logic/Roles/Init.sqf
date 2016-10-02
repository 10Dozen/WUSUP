call compile preprocessFileLineNumbers "Logic\Roles\Settings.sqf";
call compile preprocessFileLineNumbers "Logic\Roles\Functions.sqf";

if (hasInterface) then {
	[] spawn {
		waitUntil {!isNull player && time > 0};		
		cutText ["","BLACK OUT"]; 
		
		waitUntil {player getVariable ["dzn_roles_assigned", false]};		
		player call dzn_fnc_roles_assignPlayersRole;
		
		call dzn_fnc_roles_showMyRole;
		
		sleep dzn_roles_playerRoleScreenShowTime;		
		waitUntil { !isNil "dzn_roles_allAssigned" && { dzn_roles_allAssigned }};
		call dzn_fnc_roles_showORBAT;
		
		sleep 4;
		cutText ["","BLACK IN"];
	};
	
	
};

if !(isServer || isDedicated) exitWith {};

dzn_roles_assignmentTable = [];
dzn_roles_groups = [];
dzn_roles_pl = objNull;

dzn_roles_canCheckAssignment = true;
dzn_roles_waitAndCheckAssignment = {
	dzn_roles_canCheckAssignment = false;
	sleep 15;
	dzn_roles_canCheckAssignment = true;
};

waitUntil { time > dzn_roles_assignmentDelay };

call dzn_fnc_roles_createGroups;

["dzn_roles_assignment", "onEachFrame", {
	if !(dzn_roles_canCheckAssignment) exitWith {};
	[] spawn dzn_roles_waitAndCheckAssignment;
	
	[] spawn dzn_fnc_roles_processAssignments;	
}] call BIS_fnc_addStackedEventHandler;


