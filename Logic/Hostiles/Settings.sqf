dzn_hostiles_initDelay = 15;

dzn_hostiles_reinforcementCheckTimer = 30;

dzn_hostiles_side				=	east;
dzn_hostiles_baseInfantryClass	=	"O_Soldier_F";

dzn_hostiles_faction = 	[
	"usocp" 	/*"US Army"*/
	,"ruvv" 	/*"RU VV"*/
	,"rebels" 	/*"Rebels"*/
] select ("par_hostileFaction" call BIS_fnc_getParamValue);

dzn_hostiles_armor = [ 
	[""]
	, ["carClass"]
	, ["apc"]
	, ["icv"]
	, ["mbt"]
] select ("par_hostileArmor" call BIS_fnc_getParamValue);

dzn_hostiles_groupsPerAmount = [
	["2MP"	, [3, 2, 3, 4]]		/* 2 Men Patrol */
	,["4MP"	, [0, 2, 3, 4]]		/* 4 Men Patrol */
	,["MB"	, [4, 6, 8, 10]]		/* Men in Buildings */
	,["VRH"	, [1, 1, 1, 2]]		/* Vehicle Road Hold */
	,["VRP"	, [0, 0, 1, 1]]		/* Vehicle Road Patrol */
	
	,["4MP-R"	, [1, 1, 2, 2]]		/* 4 Men Patrol Reinforcement */
	,["V-R"	, [0, 1, 1, 1]]		/* Vehicle Patrol Reinforcement */
];

