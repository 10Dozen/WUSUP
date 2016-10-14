// ***********************************
// Gear Kits 
// ***********************************

// ******** USEFUL MACROSES *******
// Maros for Empty weapon
#define EMPTYKIT	[["","","","",""],["","","","",""],["","","","",""],["","","","",""],[],[["",0],["",0],["",0],["",0],["",0],["",0],["",0],["",0],["",0]],[["",0],["",0],["",0],["",0],["",0],["",0]],[]]
// Macros for Empty weapon
#define EMPTYWEAPON	"","",["","","",""]
// Macros for the list of items to be chosen randomly
#define RANDOM_ITEM	["H_HelmetB_grass","H_HelmetB"]
// Macros to give the item only if daytime is in given inerval (e.g. to give NVGoggles only at night)
#define NIGHT_ITEM(X)	if (daytime < 9 || daytime > 18) then { X } else { "" }

#define	COMMON_UITEMS	["ACE_fieldDressing",5],["ACE_packingBandage",5],["ACE_elasticBandage",5],["ACE_tourniquet",2],["ACE_morphine",2],["ACE_epinephrine",2],["ACE_quikclot",5],["ACE_CableTie",2],["ACE_Flashlight_XL50",1],["ACE_EarPlugs",1]
#define	COMMON_AITEMS	"ItemMap","ItemCompass","ItemWatch","ItemRadio", NIGHT_ITEM("NVGoggles_INDEP")

kit_vehicle = [
	[],[],[],[]
];

/*
	US ARMY OCP (USOCP)
*/

kit_usocp_random = [
	"kit_usocp_ftl"
	, "kit_usocp_ar"
	, "kit_usocp_gr", "kit_usocp_gr"
	, "kit_usocp_r", "kit_usocp_r"	
];

kit_usocp_sl =
	[
	["<EQUIPEMENT >>  ","rhs_uniform_cu_ocp","rhsusf_iotv_ocp_Squadleader","tf_bussole","rhsusf_ach_helmet_headset_ocp",""],
	["<PRIMARY WEAPON >>  ","rhs_weap_m4a1_carryhandle_grip","rhs_mag_30Rnd_556x45_Mk318_Stanag",["","rhsusf_acc_anpeq15side","rhsusf_acc_ACOG2_USMC",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","CUP_hgun_M9","CUP_15Rnd_9x19_M9",["","","",""]],
	["<ASSIGNED ITEMS >>  ", COMMON_AITEMS, "ACE_Vector"],
	["<UNIFORM ITEMS >> ", [ COMMON_UITEMS, ["ACE_MapTools",1] ]],
	["<VEST ITEMS >> ",[["HANDGUN MAG",2],["30Rnd_556x45_Stanag",8],["rhs_mag_an_m8hc",2],["Chemlight_green",2],["SmokeShellGreen",1],["SmokeShellRed",1],["HandGrenade",2],["SmokeShellOrange",2]]],
	["<BACKPACK ITEMS >> ",[]]
];

kit_usocp_ftl =
	[
	["<EQUIPEMENT >>  ","rhs_uniform_cu_ocp","rhsusf_iotv_ocp_Teamleader","","rhsusf_ach_helmet_headset_ocp",""],
	["<PRIMARY WEAPON >>  ","rhs_weap_m4a1_carryhandle_m203","rhs_mag_30Rnd_556x45_Mk318_Stanag",["","rhsusf_acc_anpeq15side","rhsusf_acc_ACOG2",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ", COMMON_AITEMS],
	["<UNIFORM ITEMS >> ", [ COMMON_UITEMS ]],
	["<VEST ITEMS >> ",[["rhs_mag_an_m8hc",2],["Chemlight_green",2],["HandGrenade",2],["30Rnd_556x45_Stanag",9],["rhs_mag_M433_HEDP",8]]],
	["<BACKPACK ITEMS >> ",[]]
];

kit_usocp_g =
	[
	["<EQUIPEMENT >>  ","rhs_uniform_cu_ocp","rhsusf_iotv_ocp_Grenadier","","rhsusf_ach_helmet_headset_ocp",""],
	["<PRIMARY WEAPON >>  ","rhs_weap_m4a1_carryhandle_m203","rhs_mag_30Rnd_556x45_Mk318_Stanag",["","rhsusf_acc_anpeq15side","rhsusf_acc_eotech_552",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ", COMMON_AITEMS],
	["<UNIFORM ITEMS >> ", [ COMMON_UITEMS ]],
	["<VEST ITEMS >> ",[["rhs_mag_an_m8hc",2],["Chemlight_green",2],["HandGrenade",2],["30Rnd_556x45_Stanag",8],["rhs_mag_M433_HEDP",10]]],
	["<BACKPACK ITEMS >> ",[]]
];

kit_usocp_r =
	[
	["<EQUIPEMENT >>  ","rhs_uniform_cu_ocp","rhsusf_iotv_ocp_Rifleman","B_AssaultPack_cbr","rhsusf_ach_helmet_headset_ocp",""],
	["<PRIMARY WEAPON >>  ","rhs_weap_m4a1_carryhandle_grip","rhs_mag_30Rnd_556x45_Mk318_Stanag",["","rhsusf_acc_anpeq15side","CUP_optic_CompM4",""]],
	["<LAUNCHER WEAPON >>  ","rhs_weap_M136_hedp","rhs_m136_hedp_mag",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ", COMMON_AITEMS],
	["<UNIFORM ITEMS >> ", [ COMMON_UITEMS ]],
	["<VEST ITEMS >> ",[["rhs_mag_an_m8hc",2],["Chemlight_green",2],["HandGrenade",2],["30Rnd_556x45_Stanag",10]]],
	["<BACKPACK ITEMS >> ",[["rhsusf_100Rnd_556x45_soft_pouch",4]]]
];

kit_usocp_ar =
	[
	["<EQUIPEMENT >>  ","rhs_uniform_cu_ocp","rhsusf_iotv_ocp_SAW","B_AssaultPack_cbr","rhsusf_ach_helmet_headset_ocp",""],
	["<PRIMARY WEAPON >>  ","rhs_weap_m249_pip_L","rhs_200rnd_556x45_M_SAW",["","rhsusf_acc_anpeq15side","rhsusf_acc_eotech_552",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","CUP_hgun_M9","CUP_15Rnd_9x19_M9",["","","",""]],
	["<ASSIGNED ITEMS >>  ", COMMON_AITEMS],
	["<UNIFORM ITEMS >> ", [ COMMON_UITEMS ]],
	["<VEST ITEMS >> ",[["rhs_mag_an_m8hc",2],["Chemlight_green",2],["HandGrenade",2],["rhsusf_100Rnd_556x45_soft_pouch",2],["HANDGUN MAG",3]]],
	["<BACKPACK ITEMS >> ",[["rhsusf_100Rnd_556x45_soft_pouch",3]]]
];  

kit_usocp_pl =
	[
	["<EQUIPEMENT >>  ","rhs_uniform_cu_ocp","rhsusf_iotv_ocp_Squadleader","tf_bussole","H_Beret_Colonel","TRYK_TAC_EARMUFF_Gs"],
	["<PRIMARY WEAPON >>  ","rhs_weap_m4a1_carryhandle_grip","rhs_mag_30Rnd_556x45_Mk318_Stanag",["","rhsusf_acc_anpeq15side","rhsusf_acc_ACOG3_USMC","rhsusf_acc_grip1"]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","CUP_hgun_M9","CUP_15Rnd_9x19_M9",["","","",""]],
	["<ASSIGNED ITEMS >>  ", COMMON_AITEMS, "ACE_Vector"],
	["<UNIFORM ITEMS >> ", [ COMMON_UITEMS, ["ACE_MapTools",1] ]],
	["<VEST ITEMS >> ",[["ACE_MapTools",1],["HANDGUN MAG",2],["30Rnd_556x45_Stanag",8],["rhs_mag_an_m8hc",2],["Chemlight_green",2],["SmokeShellGreen",1],["SmokeShellRed",1],["HandGrenade",2],["SmokeShellOrange",2]]],
	["<BACKPACK ITEMS >> ",[]]
];

/*
	RU VV
*/

kit_ruvv_random = [
	"kit_ruvv_ftl"
	, "kit_ruvv_ar"
	, "kit_ruvv_g", "kit_ruvv_g"
	, "kit_ruvv_r", "kit_ruvv_r"
];

kit_ruvv_sl =
	[
	["<EQUIPEMENT >>  ","TRYK_U_pad_hood_Cl","TRYK_V_ArmorVest_rgr2","tf_bussole","rhs_6b47_bala","TRYK_TAC_EARMUFF_Gs"],
	["<PRIMARY WEAPON >>  ","rhs_weap_ak74m_camo_npz","rhs_30Rnd_545x39_AK",["rhs_acc_dtk1","rhs_acc_perst1ik","rhsusf_acc_SpecterDR_OD",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ", COMMON_AITEMS, "ACE_Vector"],
	["<UNIFORM ITEMS >> ", [ COMMON_UITEMS, ["ACE_MapTools",1] ]],
	["<VEST ITEMS >> ",[["PRIMARY MAG",9],["rhs_mag_rgn",2],["rhs_mag_rdg2_white",1],["rhs_mag_rdg2_black",1],["SmokeShellBlue",1]]],
	["<BACKPACK ITEMS >> ",[]]
];

kit_ruvv_ftl =
	[
	["<EQUIPEMENT >>  ","TRYK_U_pad_hood_Cl","TRYK_V_ArmorVest_rgr2","TRYK_B_Belt_CYT","rhs_6b47_bala","TRYK_TAC_EARMUFF_Gs"],
	["<PRIMARY WEAPON >>  ","rhs_weap_ak74m_fullplum_gp25_npz","rhs_30Rnd_545x39_AK",["rhs_acc_dtk1","","rhsusf_acc_SpecterDR",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ", COMMON_AITEMS],
	["<UNIFORM ITEMS >> ", [ COMMON_UITEMS ]],
	["<VEST ITEMS >> ",[["rhs_mag_rgd5",2],["rhs_mag_rdg2_black",2],["PRIMARY MAG",9]]],
	["<BACKPACK ITEMS >> ",[["rhs_VOG25P",10]]]
];

kit_ruvv_g =
	[
	["<EQUIPEMENT >>  ","TRYK_U_pad_hood_Cl","TRYK_V_ArmorVest_rgr2","TRYK_B_Belt_CYT","rhs_6b47_bala","TRYK_TAC_EARMUFF_Gs"],
	["<PRIMARY WEAPON >>  ","rhs_weap_ak74m_fullplum_gp25_npz","rhs_30Rnd_545x39_AK",["rhs_acc_dtk1","","CUP_optic_MRad",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ", COMMON_AITEMS],
	["<UNIFORM ITEMS >> ", [ COMMON_UITEMS ]],
	["<VEST ITEMS >> ",[["rhs_mag_rgd5",2],["rhs_mag_rdg2_black",2],["PRIMARY MAG",9]]],
	["<BACKPACK ITEMS >> ",[["rhs_VOG25P",10]]]
];

kit_ruvv_ar =
	[
	["<EQUIPEMENT >>  ","TRYK_U_pad_hood_Cl","TRYK_V_ArmorVest_rgr2","B_AssaultPack_rgr","rhs_6b47_bala","TRYK_TAC_EARMUFF_Gs"],
	["<PRIMARY WEAPON >>  ","CUP_arifle_RPK74","CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",["","","CUP_optic_Kobra",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ", COMMON_AITEMS],
	["<UNIFORM ITEMS >> ", [ COMMON_UITEMS ]],
	["<VEST ITEMS >> ",[["rhs_mag_rdg2_black",2],["CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",2],["rhs_mag_rgd5",2]]],
	["<BACKPACK ITEMS >> ",[["CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",4]]]
];

kit_ruvv_r =
	[
	["<EQUIPEMENT >>  ","TRYK_U_pad_hood_Cl","TRYK_V_ArmorVest_rgr2","B_AssaultPack_rgr","rhs_6b47_bala","TRYK_TAC_EARMUFF_Gs"],
	["<PRIMARY WEAPON >>  ","rhs_weap_ak105_npz","rhs_30Rnd_545x39_AK",["rhs_acc_dtk","rhs_acc_perst1ik","CUP_optic_MRad",""]],
	["<LAUNCHER WEAPON >>  ","rhs_weap_rpg26","rhs_rpg26_mag",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ", COMMON_AITEMS],
	["<UNIFORM ITEMS >> ", [ COMMON_UITEMS ]],
	["<VEST ITEMS >> ",[["rhs_mag_rdg2_black",2],["rhs_mag_rgd5",2],["PRIMARY MAG",9]]],
	["<BACKPACK ITEMS >> ",[["CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",4],["SECONDARY MAG",1]]]
];

kit_ruvv_pl =
	[
	["<EQUIPEMENT >>  ","TRYK_U_pad_hood_Cl","TRYK_V_ArmorVest_rgr2","tf_bussole","rhs_beret_milp","TRYK_TAC_EARMUFF_Gs"],
	["<PRIMARY WEAPON >>  ","rhs_weap_ak74m_camo_npz","rhs_30Rnd_545x39_AK",["rhs_acc_dtk1","rhs_acc_perst1ik","rhsusf_acc_SpecterDR_OD",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ", COMMON_AITEMS, "ACE_Vector"],
	["<UNIFORM ITEMS >> ", [ COMMON_UITEMS, ["ACE_MapTools",1] ]],
	["<VEST ITEMS >> ",[["PRIMARY MAG",9],["rhs_mag_rgn",2],["rhs_mag_rdg2_white",1],["rhs_mag_rdg2_black",1],["SmokeShellBlue",1]]],
	["<BACKPACK ITEMS >> ",[]]
];

/*
	REBELS AI 
*/

kit_rebels_random = [
	"kit_rebels_r"
	,"kit_rebels_gr"
	,"kit_rebels_rheavy"
	,"kit_rebels_r"
	,"kit_rebels_gr"
	,"kit_rebels_rheavy"
	,"kit_rebels_mg"
];

#define INS_UNI	["CUP_U_O_Partisan_VSR_Mixed2","CUP_U_O_Partisan_VSR_Mixed1","CUP_U_O_Partisan_TTsKO_Mixed","CUP_U_O_Partisan_TTsKO","CUP_U_I_GUE_Woodland1","CUP_U_I_GUE_Flecktarn","CUP_U_I_GUE_Flecktarn3","CUP_U_I_GUE_Flecktarn2"]
#define INS_HEAD	["H_Bandanna_cbr","H_Bandanna_camo", "H_MilCap_dgtl"]
kit_rebels_r =
	[
	["<EQUIPEMENT >>  ",INS_UNI,"TRYK_V_harnes_od_L","",INS_HEAD,"G_Bandanna_oli"],
	["<PRIMARY WEAPON >>  ","rhs_weap_ak74m","rhs_30Rnd_545x39_AK",["rhs_acc_dtk","","",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemCompass","ItemWatch","ItemRadio"],
	["<UNIFORM ITEMS >> ",[["ACE_fieldDressing",8],["ACE_packingBandage",4],["PRIMARY MAG",1]]],
	["<VEST ITEMS >> ",[["PRIMARY MAG",8],["HandGrenade",3],["rhs_mag_rdg2_black",2]]],
	["<BACKPACK ITEMS >> ",[]]
];
kit_rebels_gr =
	[
	["<EQUIPEMENT >>  ",INS_UNI,"TRYK_V_harnes_od_L","",INS_HEAD,"G_Bandanna_oli"],
	["<PRIMARY WEAPON >>  ","rhs_weap_ak74m_gp25","rhs_30Rnd_545x39_AK",["rhs_acc_dtk","","",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemCompass","ItemWatch","ItemRadio"],
	["<UNIFORM ITEMS >> ",[["ACE_fieldDressing",8],["ACE_packingBandage",4],["PRIMARY MAG",1]]],
	["<VEST ITEMS >> ",[["HandGrenade",1],["rhs_mag_rdg2_black",2],["PRIMARY MAG",6],["rhs_VOG25",8]]],
	["<BACKPACK ITEMS >> ",[]]
];
kit_rebels_rheavy =
	[
	["<EQUIPEMENT >>  ",INS_UNI,"TRYK_V_harnes_od_L","",INS_HEAD,"G_Bandanna_oli"],
	["<PRIMARY WEAPON >>  ","rhs_weap_akms","rhs_30Rnd_762x39mm",["","","",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemCompass","ItemWatch","ItemRadio"],
	["<UNIFORM ITEMS >> ",[["ACE_fieldDressing",8],["ACE_packingBandage",4],["PRIMARY MAG",3]]],
	["<VEST ITEMS >> ",[["HandGrenade",2],["rhs_mag_rdg2_black",2],["PRIMARY MAG",8]]],
	["<BACKPACK ITEMS >> ",[]]
];
kit_rebels_mg =
	[
	["<EQUIPEMENT >>  ",INS_UNI,"TRYK_V_harnes_od_L","CUP_B_AlicePack_Khaki",INS_HEAD,"G_Bandanna_oli"],
	["<PRIMARY WEAPON >>  ","CUP_lmg_PKM","CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M",["","","",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","","",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemCompass","ItemWatch","ItemRadio"],
	["<UNIFORM ITEMS >> ",[["ACE_fieldDressing",8],["ACE_packingBandage",4]]],
	["<VEST ITEMS >> ",[["HandGrenade",2],["rhs_mag_rdg2_black",2],["PRIMARY MAG",1]]],
	["<BACKPACK ITEMS >> ",[["PRIMARY MAG",2]]]
];

