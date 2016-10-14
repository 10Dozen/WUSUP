
/*
	GROUPS
*/
dzn_fnc_hostiles_generateGroups = {
	private _par_amount = ("par_hostileAmount" call BIS_fnc_getParamValue);
	
	private _kit = format["kit_%1_random", dzn_hostiles_faction];	
	private _kitVeh = "kit_vehicle";
	/*format ["kit_%1_vehicle", dzn_hostiles_faction];*/
	
	private _vehicleClasses  = if (dzn_hostiles_armor > 0) then { 
		([dzn_hostiles_armorClassPerFaction, dzn_hostiles_faction] call dzn_fnc_getValueByKey) select (dzn_hostiles_armor - 1)
	} else {
		[]
	};	

	#define	MAN_PATROL		[dzn_hostiles_baseInfantryClass, [], _kit]
	#define	MAN_BUILD		[dzn_hostiles_baseInfantryClass, ["indoors"], _kit]
	
	#define	MAN_DRIVER		[dzn_hostiles_baseInfantryClass, [0,"Driver"], _kit]
	#define	MAN_GUNNER		[dzn_hostiles_baseInfantryClass, [0,"Gunner"], _kit]
	#define	MAN_COMANDER	[dzn_hostiles_baseInfantryClass, [0,"Commander"], _kit]
	
	#define	GET_RANDOM_VEH	(selectRandom _vehicleClasses)
	#define	VEH_ROADHOLD	[GET_RANDOM_VEH, "Vehicle Road Hold", _kitVeh]
	#define	VEH_ROADPATROL	[GET_RANDOM_VEH, "Vehicle Road Hold", _kitVeh]
	#define	VEH_PATROL		[GET_RANDOM_VEH, "Vehicle Patrol", _kitVeh]
	
	#define	GET_AMOUNT(X)	(([dzn_hostiles_groupsPerAmount,X] call dzn_fnc_getValueByKey) select _par_amount)

	// Patrols
	private _group_2MP = [GET_AMOUNT("2MP"), [MAN_PATROL, MAN_PATROL]];	
	private _group_4MP = [GET_AMOUNT("4MP"), [MAN_PATROL, MAN_PATROL, MAN_PATROL, MAN_PATROL]];
	
	// In Buildings
	private _units = [];
	for "_i" from 1 to GET_AMOUNT("MB") do {
		_units pushBack MAN_BUILD;	
	};
	private _group_MB = [1, _units];
	
	// Vehicles	
	private _group_VRH = [ 
		if (dzn_hostiles_armor == 0) then { 0 } else { GET_AMOUNT("VRH") }
		, [VEH_ROADHOLD, MAN_DRIVER, MAN_GUNNER]
	];
	
	private _group_VRP = [ 
		if (dzn_hostiles_armor == 0) then { 0 } else { GET_AMOUNT("VRH") }
		, [VEH_ROADPATROL, MAN_DRIVER, MAN_GUNNER	]
	];
	
	// Reinforcements
	private _group_4MP_R = [GET_AMOUNT("4MP-R"), [MAN_PATROL, MAN_PATROL, MAN_PATROL, MAN_PATROL]];
	private _group_V_R = [ 
		if (dzn_hostiles_armor == 0) then { 0 } else { GET_AMOUNT("V-R") }
		, [VEH_PATROL, MAN_DRIVER, MAN_GUNNER]
	];
	
	
	// [ @MainGroups, @Reinforcements ]
	[
		[
			_group_2MP
			, _group_4MP
			, _group_MB
			, _group_VRH
			, _group_VRP
		]
		, [
			_group_4MP_R
			, _group_V_R		
		]
	]
};

dzn_fnc_hostiles_updateGroups = {
	private _groups = call dzn_fnc_hostiles_generateGroups;
	
	[Main, _groups select 0] call dzn_fnc_dynai_setGroupTemplates;	
	[Reinforcement, _groups select 1] call dzn_fnc_dynai_setGroupTemplates;
};



/*
	ZONES
*/
dzn_fnc_hostiles_addLocationsMain = {
	private _trgs = [synchronizedObjects Task_DynaiZone_Main, { _x isKindOf "EmptyDetector" }] call BIS_fnc_conditionalSelect;
	
	{
		_x synchronizeObjectsRemove [Task_DynaiZone_Main];
		_x synchronizeObjectsAdd [Main];
	} forEach _trgs;	
};

dzn_fnc_hostiles_addLocationsReinforcement = {
	private _trgs = [synchronizedObjects Task_DynaiZone_Reinforcement, { _x isKindOf "EmptyDetector" }] call BIS_fnc_conditionalSelect;

	{
		_x synchronizeObjectsRemove [Task_DynaiZone_Reinforcement];
		_x synchronizeObjectsAdd [Reinforcement];
	} forEach _trgs;	
};

dzn_fnc_hostiles_getReinforcementRandomPositions = {
	private _poses = [];
	for "_i" from 0 to 6 do {
		_poses pushBack ([getPosATL Main, random(360), 100 + random(1100)] call dzn_fnc_getPosOnGivenDir);
	};
	
	_poses
};


/*
	REINFORCEMENTS
*/

dzn_fnc_hostiles_runReinfocementCaller = {
	waitUntil { 
		sleep dzn_hostiles_reinforcementCheckTimer;
		[Task_SeizeArea, 300, "bool"] call dzn_fnc_isPlayerNear
	};
	
	dzn_hostiles_reinforcementsCalled = true;
};