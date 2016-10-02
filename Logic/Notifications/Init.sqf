call compile preprocessFileLineNumbers "Logic\Notifications\Settings.sqf";
call compile preprocessFileLineNumbers "Logic\Notifications\Functions.sqf";

if !(hasInterface) exitWith {};

waitUntil { time > 0 };

call dzn_fnc_notif_addORBATTopic;
call dzn_fnc_notif_addTimeTopics;

[] spawn dzn_fnc_notif_runTimeNotifHandler;
[] spawn dzn_fnc_notif_runCaptureNotifHandler;