// #define DEBUG			true
#define DEBUG		false

dzn_fnc_dynai_initValidate = {
	if (isNil "dzn_dynai_core") exitWith { 
		["dzn_dynai :: There is no 'dzn_dynai_core' placed on the map!"] call BIS_fnc_error; 
		false
	};
	
	if ((synchronizedObjects dzn_dynai_core) isEqualTo []) exitWith { 
		["dzn_dynai :: There is no DynAI zones synchronized with 'dzn_dynai_core' object!"] call BIS_fnc_error;
		false
	};
	
	true
};

dzn_fnc_dynai_getSkillFromParameters = {
	#define GET_SKILL(X)    ((X call BIS_fnc_getParamValue) / 100)
	switch ("par_dynai_overrideSkill" call BIS_fnc_getParamValue) do {
		case 1: {
			dzn_dynai_complexSkill = [false, GET_SKILL("par_dynai_skillGeneral")];
		};
		case 2: {
			dzn_dynai_complexSkill = [
				true
				, dzn_dynai_complexSkillLevel + [
					["general", GET_SKILL("par_dynai_skillGeneral")]
					, ["aimingAccuracy", GET_SKILL("par_dynai_skillAccuracy")]
					, ["aimingSpeed", GET_SKILL("par_dynai_skillAimSpeed")]
				]
			];
		};
	};
};


dzn_fnc_dynai_getMultiplier = {
	if (isNil "dzn_dynai_amountMultiplier") then {
		dzn_dynai_amountMultiplier = switch ("par_dynai_amountMultiplier" call BIS_fnc_getParamValue) do {
			case 0: { 1.00 };
			case 1: { 0.25 };
			case 2: { 0.50 };
			case 3: { 0.75 };
			case 4: { 1.00 };
			case 5: { 1.25 };
			case 6: { 1.50 };
			case 7: { 1.75 };
			case 8: { 2.00 };
			case 9: { selectRandom [1.00, 1.25, 1.50] };
			case 10: { selectRandom [1.00, 1.25, 1.50, 1.75, 2.00] };
		};
	};
	
	dzn_dynai_amountMultiplier
};

dzn_fnc_dynai_initZoneKeypoints = {
	// @Keypoints = @Zone call dzn_fnc_dynai_initZoneKeypoints;	
	private _keypoints = [];
	{
		if (_x isKindOf "LocationArea_F") then {
			private _pos = getPosASL _x;
			_keypoints pushBack [_pos select 0, _pos select 1, 0];
		};
	} forEach (synchronizedObjects _x);
	
	_keypoints
};

dzn_fnc_dynai_initZones = {
	/*
		Initialize zones and start their's create sequence
		INPUT: 		NULL
		OUTPUT: 	NULL
	*/
	if !(call dzn_fnc_dynai_initValidate) exitWith {};
	
	private ["_modules", "_zone", "_properties","_syncObj", "_locations","_synced", "_wps", "_keypoints","_locationBuildings","_locBuildings","_locPos"];

	call dzn_fnc_dynai_getSkillFromParameters;
	_modules = synchronizedObjects dzn_dynai_core;
	
	{
		_zone = _x;
		
		_zone setVariable ["dzn_dynai_initialized", false];
		_zoneBuildings = [];
		_properties = [];
		{
			if ( (_x select 0) == str (_zone) ) then {
				_properties = _x;
			};
		} forEach dzn_dynai_zoneProperties;
		if (_properties isEqualTo []) exitWith { ["dzn_dynai :: There is no properties for DynAI zone '%1'", str(_x)] call BIS_fnc_error; };

		_locations = [];
		
		// Get triggers and convert them into locations
		_syncObj = synchronizedObjects _x;
		{
			if (_x isKindOf "EmptyDetector") then {
				_loc = [_x, true] call dzn_fnc_convertTriggerToLocation;
				_locations pushBack _loc;
			
				_locBuildings = [[_loc]] call dzn_fnc_getLocationBuildings;
				{ _zoneBuildings pushBack _x; } forEach _locBuildings;
			};		
		} forEach _syncObj;
		
		if (_locations isEqualTo []) exitWith { ["dzn_dynai :: There is no triggers synchronized with DynAI zone '%1'", str(_x)] call BIS_fnc_error; };
		
		// Get area average position and size
		#define GET_AVERAGE(PAR1,PAR2)		((PAR1) + (PAR2))/2
		_locPos = [];
		{
			_locPos = if (_locPos isEqualTo []) then {
				locationPosition _x
			} else {
				[
					GET_AVERAGE(_locPos select 0, (locationPosition _x) select 0), 
					GET_AVERAGE(_locPos select 1, (locationPosition _x) select 1), 
					GET_AVERAGE(_locPos select 2, (locationPosition _x) select 2)
				]
			};
		} forEach _locations;

		// Keypoints
		_keypoints = _x call dzn_fnc_dynai_initZoneKeypoints;
		if (_keypoints isEqualTo []) then {			
			_keypoints = "randomize";
		};
				
		sleep 1;
		
		_zone setPosASL _locPos;
		
		_properties set [3, _locations];
		_properties set [4, _keypoints];
		_properties = _properties + [_zoneBuildings];
		
		[_zone, [ 
			["dzn_dynai_area", _locations]
			, ["dzn_dynai_keypoints", _keypoints]
			, ["dzn_dynai_isActive", _properties select 2]
			, ["dzn_dynai_properties", _properties]
			, ["dzn_dynai_groups", []]
			, ["dzn_dynai_initialized", true]				
		], true] call dzn_fnc_setVars;
		
	} forEach _modules;
};

dzn_fnc_dynai_getZoneVar = {
	
	/*
	 * @Property = [@Zone, @PropertyName] call dzn_fnc_dynai_getZoneVar
	 * Returns value of the given property.
	 *      Properties are:
	 *      "list" - (array) list of all available properties;
	 *      "area" - (array) list of zone's locations;
	 *      "kp"/"points"/"keypoints" - (array) list of zone's keypoints (Pos3ds);
	 *      "isactive" - (boolean) is zone was activated;
	 *      "prop"/"properties" - (array) list of zone's basic properties (that were set up with DynAI tool);
	 *      "init"/"initialized" - (boolean) is zone initialized;
	 *      "groups" - (array) list of zone's groups
	 * 
	 * INPUT:
	 * 0: OBJECT - Zone's GameLogic
	 * 1: STRING - Property name (e.g. "isactive", "groups")
	 * OUTPUT: @Property value (can be any format)
	 * 
	 * EXAMPLES:
	 *      
	 */
	private["_r","_z"];
	_z = _this select 0;
	_r = switch toLower(_this select 1) do {	
		case "list": { ["area", ["keypoints","kp","points"], "isActive", ["properties","prop"], ["init","initialized"], "groups"]};
		case "area": { _z getVariable ["dzn_dynai_area", nil] };
		case "kp";case "points";case "keypoints": { _z getVariable ["dzn_dynai_keypoints", nil] };
		case "isactive": { _z getVariable ["dzn_dynai_isActive", nil] };
		case "prop";case "properties": { _z getVariable ["dzn_dynai_properties", nil] };
		case "init";case "initialized": { _z getVariable ["dzn_dynai_initialized", nil] };
		case "groups": { _z getVariable ["dzn_dynai_groups", []]; };
		default { nil };
	};

	_r
};

dzn_fnc_dynai_getGroupVar = {
	
	/*
	 * @Property = [@Group, @PropertyName] call dzn_fnc_dynai_getGroupVar
	 * Returns value of the given property.
	 *      Properties are:
	 *      "list" - (array) list of all available properties;
	 *      "home" - (object) home zone's game logic;
	 *      "units" - (array) list of group's units;
	 *      "vehicles" - (array) list of group's vehicles;
	 *      "wpset" - (boolean) is group already has waypoints
	 *      
	 *      
	 * 
	 * INPUT:
	 * 0: GROUP - Zone's group
	 * 1: STRING - Property name (e.g. "wpSet", "units")
	 * OUTPUT: @Property value (can be any format)
	 * 
	 * EXAMPLES:
	 *      
	 */
	private["_r","_g"];
	_g = _this select 0;
	_r = switch toLower(_this select 1) do {
		case "list": { ["home", "units", "vehicles", "wpSet"] };
		case "wpset": { _g getVariable "dzn_dynai_wpSet" };
		case "home": { _g getVariable "dzn_dynai_homeZone" };
		case "units": { _g getVariable "dzn_dynai_units" };
		case "vehicles": { _g getVariable "dzn_dynai_vehicles" };
		default { nil };
	};
	
	_r
};

#define GET_PROP(X,Y)	[X, Y] call dzn_fnc_dynai_getZoneVar

dzn_fnc_dynai_startZones = {	
	/*
		Start all zones
		INPUT: 	NULL
		OUTPUT: 	NULL
	*/
	
	if !(call dzn_fnc_dynai_initValidate) exitWith {};
	
	private ["_modules"];
	
	_modules = synchronizedObjects dzn_dynai_core;
	
	{		
		_x spawn {
			// Wait for zone activation (_this getVariable "isActive")
			waitUntil {!isNil {GET_PROP(_this, "init")} && {GET_PROP(_this, "init")}};
			waitUntil {!isNil {GET_PROP(_this,"isActive")} && {GET_PROP(_this,"isActive")}};
			if (DEBUG) then { player sideChat format ["dzn_dynai :: Creating zone '%1'", str(_this)]; };			
			
			(GET_PROP(_this,"properties")) call dzn_fnc_dynai_createZone;
		};
		sleep 0.5;	
	} forEach _modules;	
};

dzn_fnc_dynai_createZone = {
	/*
		Create zone from parameters
		INPUT: 		Zone propreties
		OUTPUT: 	NULL
	*/
	
	private [
		"_side","_name","_area","_wps"
		,"_refUnits","_behavior", "_zonePos","_count","_groupUnits","_groupSkill"
		,"_groups","_grp","_groupPos","_grpLogic"
		,"_classname","_assigned","_gear","_unit"
		,"_vehPos","_vehPosEmpty"
		,"_zoneBuildings","_zoneRoads"	
	];

	_name = _this select 0;
	_side = _this select 1;
	_area = _this select 3;
	_wps = _this select 4;
	_refUnits = _this select 5;
	_behavior = _this select 6;
	_zoneBuildings = _this select 7;
	_zoneRoads = _area call dzn_fnc_getLocationRoads;
	
	_zoneUsedBuildings = [];
	_groups = [];
	
	if (DEBUG) then { 
		player sideChat format ["dzn_dynai :: %1 :: Zone is activated", _name];
		diag_log format ["dzn_dynai :: %1 :: Zone is activated", _name]; 
	};
	
	// Creating center of side if not exists
	call compile format ["
		if (isNil { dzn_dynai_center_%1}) then {
			createCenter %1;
			dzn_dynai_center_%1 = true;
		};	
		",
		_side
	];
	
	if (DEBUG) then { diag_log format ["dzn_dynai :: %1 :: Calculating zone position", _name]; };
	_zonePos = _area call dzn_fnc_getZonePosition; //[CentralPos, xMin, yMin, xMax, yMax]
	
	if (DEBUG) then { diag_log format ["dzn_dynai :: %1 :: Spawning groups", _name]; };
	// For each groups templates
	{
		_count = ceil( (_x select 0) * (call dzn_fnc_dynai_getMultiplier) );
		_groupUnits = _x select 1;
		_groupSkill = if (!isNil {_x select 2}) then { _x select 2 } else { dzn_dynai_complexSkill };
		
		// For count of templated groups
		for "_i" from 0 to (_count - 1) do {
			if (DEBUG) then { diag_log format ["dzn_dynai :: %1 :: | Spawning group %2", _name, str(_i)]; };
			
			// Creates group
			_groupPos = _area call dzn_fnc_getRandomPointInZone; // return Pos3D
			_grp = createGroup (call compile _side);
			_groups pushBack _grp;
			_grp setVariable ["dzn_dynai_homeZone", call compile _name];
			_grp setVariable ["dzn_dynai_wpSet",false];
			private _cycleWaypoints = true;
		 
			// Creates GameLogic for group control
			//_grpLogic = _grp createUnit ["LOGIC", _groupPos, [], 0, "NONE"];			
			_grp setVariable ["dzn_dynai_units", []];
			_grp setVariable ["dzn_dynai_vehicles", []];
	
			// For each unit in group
			{
				if (DEBUG) then { diag_log format ["dzn_dynai :: %1 :: | Spawning group %2 -- Unit: %3 (%4)", _name, str(_i), str(_forEachIndex), _x select 0]; };
				
				_classname = _x select 0;
				_assigned = _x select 1;
				_gear = _x select 2;
				
				_unit = objNull;
				
				if (typename _assigned == "ARRAY") then {
					// Not assigned, Assigned in vehicle, Assigned to house			
			
					_unit = _grp createUnit [_classname , _groupPos, [], 0, "NONE"];
					_grp setVariable ["dzn_dynai_units", (_grp getVariable "dzn_dynai_units") + [_unit]];
					_grp setVariable ["dzn_dynai_vehicles", (_grp getVariable "dzn_dynai_vehicles") + [""]];
					
					if (DEBUG) then { diag_log format ["dzn_dynai :: %1 :: || Unit created %2 (%3)", _name, str(_unit), _classname]; };
					
					// Skill
					if (_groupSkill select 0) then {
						{ _unit setSkill _x; } forEach (_groupSkill select 1);
					} else {
						_unit setSkill (_groupSkill select 1);
					};					
					
					// Gear
					if !(typename _gear == "STRING" && {_gear == ""} ) then { [_unit, _gear] spawn dzn_fnc_gear_assignKit; };
					
					// Assignement	
					/*
						[] - no assignement
						[0, "role"] - assignement in vehicle
						["indoors"]	- assignement in default house
						["indoors", [classnames]] - assignement in specified house
					*/	
					if !(_assigned isEqualTo []) then {
						if (typename (_assigned select 0) == "STRING") then {
							// Indoors
							switch (_assigned select 0) do {
								case "indoors": {
									if (isNil {_assigned select 1}) then {										
										// Default houses
										[_unit, _zoneBuildings] spawn dzn_fnc_assignInBuilding;
									} else {
										// Specified houses
										[_unit, _zoneBuildings, _assigned select 1] spawn dzn_fnc_assignInBuilding;
									};
									[_unit, DEBUG] execFSM "dzn_dynai\FSMs\dzn_dynai_indoors_behavior.fsm";
									_unit setVariable ["dzn_dynai_isIndoor", true, true]; //dynai_isIndoor
								};
							};
						} else {
							// Assignement in vehicle
							[
								_unit, 
								(_grp getVariable "dzn_dynai_vehicles") select (_assigned select 0),	// ID of created unit/vehicle
								_assigned select 1	// string of assigned role - e.g. driver, gunner
							] call dzn_fnc_assignInVehicle; 
						};
					};					
				} else {
					// Is vehicle						
					_vehPos = [(_groupPos select 0) + 6*_forEachIndex, (_groupPos select 1) + 6*_forEachIndex, 0];
					while {
						(_vehPos isFlatEmpty [(sizeof _classname) / 5,0,300,(sizeof _classname),0]) select 0 isEqualTo []					
					} do {
						_vehPos = [(_groupPos select 0) + 6*_forEachIndex + 15 +  random(50), (_groupPos select 1) + 6*_forEachIndex + 15 + random(50), 0];
					};
					_unit = createVehicle [_classname, _vehPos, [], 0, "NONE"];
					_unit allowDamage false;
					
					_unit setPos _vehPos;
					_unit setVelocity [0,0,0];					
					_unit spawn { sleep 5; _this allowDamage true; };
					
					if !(typename _gear == "STRING" && {_gear == ""} ) then { [_unit, _gear, true] spawn dzn_fnc_gear_assignKit; };
					_grp setVariable ["dzn_dynai_vehicles", (_grp getVariable "dzn_dynai_vehicles") + [_unit]];
			
					// Vehicle type
					switch (true) do {						
						case (["Vehicle Hold", _assigned, false] call BIS_fnc_inString): {
							_grp setVariable ["dzn_dynai_wpSet", true];
							(waypoints _grp select 0) setWaypointType "Hold";
							
							_unit setVariable ["dzn_dynai_vehicleHold", true];
							if (dzn_dynai_allowVehicleHoldBehavior) then { 								
								[_unit, false] execFSM "dzn_dynai\FSMs\dzn_dynai_vehicleHold_behavior.fsm";
							};
						};
						case (["Vehicle Advance", _assigned, false] call BIS_fnc_inString): {
							_cycleWaypoints = false;
							_unit setVariable ["dzn_dynai_isStatic",true];
							_grp spawn {
								waitUntil {_this getVariable ["dzn_dynai_wpSet", false]};
								
								private _lastWp = (waypoints _this) select (count (waypoints _this) - 1);
								_lastWp setWaypointType "Hold";
								
								waitUntil { sleep 15; (_lastWp select 1) == currentWaypoint _this };
								[vehicle (leader _this), "vehicle hold"] call dzn_fnc_dynai_addUnitBehavior;
							};
						};						
						case (["Vehicle Road Patrol", _assigned, false] call BIS_fnc_inString): {
							_grp setVariable ["dzn_dynai_wpSet", true];
							_unit setVariable ["dzn_dynai_isStatic",true];
							
							private _road = selectRandom _zoneRoads;
							_unit setPos (_road modelToWorld [7 * selectRandom [1,-1], 0, 0]);							
							_unit setDir (random 360);
							
							[_grp,_zoneRoads] spawn {
								params["_grp","_zoneRoads"];
								
								waitUntil { sleep 5; !((units _grp) isEqualTo []) };
								[_grp, _zoneRoads] call dzn_fnc_createPathFromRoads;
							};
						};
						case (["Vehicle Road Hold", _assigned, false] call BIS_fnc_inString): {
							_grp setVariable ["dzn_dynai_wpSet", true];
							private _road = selectRandom _zoneRoads;
							
							(waypoints _grp select 0) setWaypointPosition [getPosASL _road, 10];
							(waypoints _grp select 0) setWaypointType "Hold";
							
							_unit setPos (_road modelToWorld [7 * selectRandom [1,-1], 0, 0]);							
							_unit setDir (random 360);
							
							_unit setVariable ["dzn_dynai_vehicleHold", true];
							if (dzn_dynai_allowVehicleHoldBehavior) then { 								
								[_unit, false] execFSM "dzn_dynai\FSMs\dzn_dynai_vehicleHold_behavior.fsm";
							};
						};						
						case (["Vehicle Patrol", _assigned, false] call BIS_fnc_inString);
						case (["Vehicle", _assigned, false] call BIS_fnc_inString): {};
					};
				};
				
				sleep 0.2;
			} forEach _groupUnits;			
			
			/*
			// Synhronize units with groupLogic			
			[_grpLogic] joinSilent grpNull;			// Unassign GameLogic from group
			_grpLogic synchronizeObjectsAdd (units _grp);
			[_grpLogic] spawn {
				waitUntil { sleep 30; {alive _x} count (synchronizedObjects (_this select 0)) < 1 };
				deleteVehicle (_this select 0);
			};
			*/
			
			// Set group behavior
			if !(_behavior select 0 == "") then { _grp setSpeedMode (_behavior select 0); };
			if !(_behavior select 1 == "") then { _grp setBehaviour (_behavior select 1); };
			if !(_behavior select 2 == "") then { _grp setCombatMode (_behavior select 2); };
			if !(_behavior select 3 == "") then { _grp setFormation (_behavior select 3); };
			
			// Assign waypoints
			if !(_grp getVariable "dzn_dynai_wpSet") then {				
				if (typename _wps == "ARRAY") then {
					if (DEBUG) then { diag_log format ["dzn_dynai :: %1 :: || Spawning group %2 -- Waypoint creation: Keypoint", _name, str(_i)]; };
					[_grp, _wps, 3 + round(random 3),_cycleWaypoints] call dzn_fnc_createPathFromKeypoints;
				} else {
					if (DEBUG) then { diag_log format ["dzn_dynai :: %1 :: || Spawning group %2 -- Waypoint creation: Random", _name, str(_i)]; };
					[_grp, _area, 3 + round(random 3),_cycleWaypoints] call dzn_fnc_createPathFromRandom;
				};
				_grp setVariable ["dzn_dynai_wpSet",true];
			};
			
			if (dzn_dynai_allowGroupResponse) then { _grp call dzn_fnc_dynai_initResponseGroup; };
		};
	} forEach _refUnits;
	
	if (dzn_dynai_allowGroupResponse && dzn_dynai_makeZoneAlertOnRequest) then {
		(call compile _name) setVariable ["dzn_dynai_isZoneAlerted", false];
	};
	
	(call compile _name) setVariable ["dzn_dynai_groups", _groups];	
	dzn_dynai_activatedZones pushBack (call compile _name);
	
	if (DEBUG) then { diag_log format ["dzn_dynai :: %1 :: Zone Created", _name]; };
};




// ================================================
//           DZN DYNAI -- New zone creation
// ================================================

dzn_fnc_dynai_addNewZone = {
	/*
	 * [@Name, @Side, @IsActive, @Area, @Keypoints, @Tamplates, @Behaviour] spawn dzn_fnc_dynai_addNewZone 
	 * Creates new DynAI zone according to passed parameters.
	 * 
	 * INPUT:
	 * 0: STRING - Zone's name
	 * 1: STRING - Zone's side (e.g. "west", "east", "resistance", "civilian")
	 * 2: BOOLEAN - true - active, false - inactive on creation
	 * 3: ARRAY - List of Locations or Triggers or [Pos3d, WidthX, WidthY, Direction, IsSquare(true/false)]
	 * 4: ARRAY or STRING - Keypoints (array of Pos3ds) or "randomize" to generate waypoints from zone's area
	 * 5: ARRAY - Groups templates for zone
	 * 6: ARRAY - Behavior settings in format [Speed mode, Behavior, Combat mode, Formation]
	 * OUTPUT: NULL
	 * 
	 * EXAMPLES:
	 *      
	 */
	private ["_zP","_zoneObject","_l","_loc"];
	_zP = _this;
	
	_loc = [];
	// Check what is come as 3rd argument - Locations, Triggers or Arrays of attributes
	switch (typename ((_zP select 3) select 0)) do {
		case "ARRAY": {
			{
				_l = createLocation ["Name", _x select 0, _x select 1, _x select 2];
				_l setDirection ( _x select 3);
				_l setRectangular ( _x select 4);
				_loc pushBack _l;
			} forEach (_zP select 3);
		};
		case "OBJECT": {
			{
				_loc pushBack ([_x, true] call dzn_fnc_convertTriggerToLocation);
			} forEach (_zP select 3);
		};
		case "LOCATION": { _loc = _zP select 3; };
	};
	_zP set [3, _loc];
	_zP pushBack ([_zP select 3] call dzn_fnc_getLocationBuildings);
	
	_grp = createGroup (call compile (_zP select 1));
	_zoneObject = _grp createUnit ["Logic", (locationPosition (_zP select 3 select 0)), [], 0, "NONE"];
	
	_zoneObject setVehicleVarName (_zP select 0); 
	call compile format [ "%1 = _zoneObject;", (_zP select 0)];
	
	_zoneObject setVariable ["dzn_dynai_area", _zP select 3];
	_zoneObject setVariable ["dzn_dynai_keypoints", _zP select 4];
	_zoneObject setVariable ["dzn_dynai_isActive", _zP select 2];
	
	_zoneObject setVariable ["dzn_dynai_properties", _zP];
	_zoneObject setVariable ["dzn_dynai_initialized", true];
	
	//dzn_dynai_zoneProperties pushBack _zP;
	
	_zP spawn dzn_fnc_dynai_createZone;
};

