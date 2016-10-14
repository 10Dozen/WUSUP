dzn_hostiles_initDelay = 15;

dzn_hostiles_reinforcementCheckTimer = 30;

dzn_hostiles_side				=	east;
dzn_hostiles_baseInfantryClass	=	"O_Soldier_F";

dzn_hostiles_faction = 	[
	"usocp" 	/*"US Army"*/
	,"ruvv" 	/*"RU VV"*/
	,"rebels" 	/*"Rebels"*/
] select ("par_hostileFaction" call BIS_fnc_getParamValue);

dzn_hostiles_armor = "par_hostileArmor" call BIS_fnc_getParamValue;


/* [ @Faction, [ @CAR, @APC, @ICV, @MBT ] ] */
dzn_hostiles_armorClassPerFaction = [
	["usocp", [
		["rhsusf_m1025_w_m2","rhsusf_m1025_w_mk19"]
		, ["rhsusf_m113_usarmy","rhsusf_m113_usarmy_M240","rhsusf_m113_usarmy_MK19","CUP_B_M1130_CV_M2_Woodland"]
		, ["RHS_M2A3_wd","RHS_M2A2_wd"]
		, ["rhsusf_m1a1aimwd_usarmy"]
	]]
	, ["ruvv", [
		["rhs_tigr_sts_3camo_vv","rhs_tigr_sts_vv","CUP_O_UAZ_AGS30_RU","CUP_O_UAZ_MG_RU"]
		, ["rhs_btr70_vv","rhs_btr80_vv","rhs_btr60_vv","rhs_btr80a_vv","rhs_gaz66_zu23_vv","RHS_Ural_Zu23_VV_01"]
		, ["rhs_bmp2k_vv","rhs_bmp2d_vv"]
		, ["CUP_O_T72_RU"]
	]]
	, ["rebels", [ 
		["O_G_Offroad_01_armed_F","CUP_O_UAZ_MG_CHDKZ","CUP_O_LR_MG_TKA","CUP_O_UAZ_AGS30_TKA","CUP_O_UAZ_MG_TKA"]
		, ["CUP_I_BRDM2_NAPA","CUP_O_Ural_ZU23_CHDKZ","CUP_O_BRDM2_CHDKZ","CUP_O_BTR60_TK","CUP_O_BRDM2_TKA"]
		, ["CUP_I_BMP2_NAPA","CUP_I_BMP1_TK_GUE","CUP_O_ZSU23_ChDKZ","CUP_O_BMP2_TKA","CUP_O_BMP2_ZU_TKA","CUP_O_BMP1_TKA"]
		, ["CUP_I_T72_NAPA","CUP_I_T55_TK_GUE","CUP_O_T55_TK"]
	]]
];

dzn_hostiles_groupsPerAmount = [
	["2MP"	, [3, 2, 3, 4]]		/* 2 Men Patrol */
	,["4MP"	, [0, 2, 3, 4]]		/* 4 Men Patrol */
	,["MB"	, [4, 6, 8, 10]]		/* Men in Buildings */
	,["VRH"	, [1, 1, 1, 2]]		/* Vehicle Road Hold */
	,["VRP"	, [0, 0, 1, 1]]		/* Vehicle Road Patrol */
	
	,["4MP-R"	, [1, 1, 2, 2]]		/* 4 Men Patrol Reinforcement */
	,["V-R"	, [0, 1, 1, 1]]		/* Vehicle Patrol Reinforcement */
];

