tf_no_auto_long_range_radio = true;

switch ("par_daytime" call BIS_fnc_getParamValue ) do {
	case 0: { setDate [2016,7,7,10 + round(random 4), 00]; };
	case 1: { setDate [2016,7,7, 21 + round(random 8), 00]; };
	case 2: { setDate [2016,7,7, round(random 24), 00]; };
};

  // dzn Gear
  // set true to engage Edit mode
[false] execVM "dzn_gear\dzn_gear_init.sqf";
  // dzn DynAI
[] execVM "dzn_dynai\dzn_dynai_init.sqf";
  // TS Framework
[] execVM "dzn_tSFramework\dzn_tSFramework_Init.sqf";
  // dzn AAR
[] execVM "dzn_brv\dzn_brv_init.sqf";


