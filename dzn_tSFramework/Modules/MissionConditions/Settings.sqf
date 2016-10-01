/*
 * Name of trigger to represent players base;
 * If set, it's possible to use :
 *    call fnc_CheckPlayersReturned    - function to check if all player returned to base
 *    BaseLoc                          - location created at PlayersBaseTrigger position (can be used in (getPos _unit) in BaseLoc
 * Set - PlayersBaseTrigger = "" to disable
*/
PlayersBaseTrigger = "";

/*
 * Default sleep interval between Mission Conditions checks (seconds)
*/
tSF_MissionCondition_DefaultCheckTimer 			= 2;

/*
 * List of mission Ends and Conditions (up to 20 conditions allowed)
 * In format MissionCondition%1 = [ 
 * 			%EndingClassname(String)
 *			, %Condition(String)
 *			, %Note/Description(String)
 *			, %TimerInterval(Number,seconds, optional) 
 *		];
*/ 

MissionCondition1 = [ "WIN", "Task_SeizeArea_Done && EndGameTimer >= 0", "Zone captured" ];
MissionCondition2 = [ "FAIL", "EndGameTimer <= 0", "Time end" ];
MissionCondition3 = [ "WIPED", "{alive _x} count (call BIS_fnc_listPlayers)", "All dead", 30 ];