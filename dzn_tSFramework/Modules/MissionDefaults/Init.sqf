call compile preProcessFileLineNumbers "dzn_tSFramework\Modules\MissionDefaults\Settings.sqf";

// ********************
// INITIALIZATION
// ********************
enableSaving [false,false];
player addRating 1000000;

if (hasInterface && tSF_MissionDefaults_DisableInputOnStart) then {
	[] spawn {
		waitUntil { time > 0 };

		player enableSimulation false;
		disableUserInput true;

		hintSilent parseText (format ["<t color='#AAAAAA' font='PuristaLight' size='0.8'>%1</t>", tSF_MissionDefaults_SubtitleText]);

		player enableSimulation true;
		disableUserInput false;
	};

	[] spawn {
		if !(tSF_MissionDefaults_PutEarplugsOn) exitWith {};
		waitUntil {!isNull player};
		player call ace_hearing_fnc_putInEarplugs;
	};

	[] spawn {
		if !(tSF_MissionDefaults_PutWeaponSafe) exitWith {};
		waitUntil {!isNull player && time > 1};		
		[ACE_player, currentWeapon ACE_player, currentMuzzle ACE_player] call ace_safemode_fnc_lockSafety;
		
		private _curWp = currentWeapon player;
		sleep 6;
		
		if (_curWp != currentWeapon player) then {
			[ACE_player, currentWeapon ACE_player, currentMuzzle ACE_player] call ace_safemode_fnc_lockSafety;		
		};
	};
};
