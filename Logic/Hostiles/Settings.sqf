dzn_hostiles_initDelay = 15;

dzn_hostiles_side				=	east;
dzn_hostiles_baseInfantryClass	=	"O_Soldier_F";

dzn_hostiles_faction = 	[
	"usarmy" 	/*"US Army"*/
	,"usmc" 	/*"USMC"*/
	,"ruvv" 	/*"RU VV"*/
	,"rebels" 	/*"Rebels"*/
	,"pmc" 	/*"PMC"*/
] select ("par_hostileFaction" call BIS_fnc_getParamValue);

dzn_hostiles_armor = [ 
	"no"
	, "car"
	, "apc"
	, "icv"
	, "mbt" 
] select ("par_hostileArmor" call BIS_fnc_getParamValue);

dzn_hostiles_groupsPerAmount = [
	["2MP"	, [3, 2, 3, 4]]		/* 2 Men Patrol */
	,["4MP"	, [0, 2, 3, 4]]		/* 4 Men Patrol */
	,["MB"	, [4, 6, 8, 10]]		/* Men in Buildings */
	,["VRH"	, [1, 1, 1, 2]]		/* Vehicle Road Hold */
	,["VRP"	, [0, 0, 1, 1]]		/* Vehicle Road Patrol */
];