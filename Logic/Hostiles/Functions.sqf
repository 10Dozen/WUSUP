

dzn_fnc_hostiles_generateGroups = {

	private _par_amount = ("par_hostileAmount" call BIS_fnc_getParamValue);
	private _kit = format["kit_%1_random", dzn_hostiles_faction];	

	#define	MAN_PATROL		[dzn_hostiles_baseInfantryClass, [], _kit]
	#define	MAN_BUILD		[dzn_hostiles_baseInfantryClass, ["indoors"], _kit]
	#define	MAN_DRIVER		[dzn_hostiles_baseInfantryClass, [0,"Driver"], _kit]
	#define	MAN_GUNNER		[dzn_hostiles_baseInfantryClass, [0,"Gunner"], _kit]
	#define	MAN_COMANDER	[dzn_hostiles_baseInfantryClass, [0,"Commander"], _kit]
	
	#define	GET_AMOUNT(X)	([X,dzn_hostiles_groupsPerAmount] call dzn_fnc_getValueByKey) select _par_amount
	
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
	if (dzn_hostiles_armor != "no") then {
	// Vehicle Road Hold
		
		
	// Vehicle Road Patrol
	
	
	};

};








dzn_fnc_hostiles_addLocationsMain = {
	private _trgs = [Task_DynaiZone_Main, { _x isKindOf "EmptyDetector" }] call BIS_fnc_conditionalSelect;

	{
		_x synchronizeObjectsRemove [Task_DynaiZone_Main];
		_x synchronizeObjectsAdd [Main];
	} forEach _trgs;	
};

dzn_fnc_hostiles_addLocationsReinforcement = {
	private _trgs = [Task_DynaiZone_Reinforcement, { _x isKindOf "EmptyDetector" }] call BIS_fnc_conditionalSelect;

	{
		_x synchronizeObjectsRemove [Task_DynaiZone_Reinforcement];
		_x synchronizeObjectsAdd [Reinforcement];
	} forEach _trgs;	
};

dzn_fnc_hostiles_updateGroupsMain = {};

/*


*/