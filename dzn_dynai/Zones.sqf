
/* *********** This array defines detailed properties of zones ************************** */

[
    "Main", /* Zone Name */
    "EAST",false, /* Side, is Active */ [],[],
    /* Groups: */
    [
        [
            3, /* Groups quantity */
            /* Units */
            [
                ["O_Soldier_F", ["indoors"], "KIT"]
                ,["O_Soldier_F", ["indoors"], "KIT"]
                ,["O_Soldier_F", ["indoors"], "KIT"]
                ,["O_Soldier_F", ["indoors"], "KIT"]
            ]
        ]
        ,[
            4, /* Groups quantity */
            /* Units */
            [
                ["O_Soldier_F", [], "KIT"]
                ,["O_Soldier_F", [], "KIT"]
            ]
        ]
        ,[
            4, /* Groups quantity */
            /* Units */
            [
                ["O_Soldier_F", [], "KIT"]
                ,["O_Soldier_F", [], "KIT"]
                ,["O_Soldier_F", [], "KIT"]
                ,["O_Soldier_F", [], "KIT"]
            ]
        ]
        ,[
            1, /* Groups quantity */
            /* Units */
            [
                ["HOSTILE_VEH", "Vehicle Road Hold", "HOSTILE_VEH_KIT"]
                ,["O_Soldier_F", [0,"Driver"], "KIT"]
                ,["O_Soldier_F", [0,"Gunner"], "KIT"]
            ]
        ]
        ,[
            1, /* Groups quantity */
            /* Units */
            [
                ["HOSTILE_VEH", "Vehicle Road Patrol", "HOSTILE_VEH_KIT"]
                ,["O_Soldier_F", [0,"Driver"], "KIT"]
                ,["O_Soldier_F", [0,"Gunner"], "KIT"]
            ]
        ]
    ],
    /* Behavior: Speed, Behavior, Combat mode, Formation */
    ["LIMITED","SAFE","YELLOW","STAG COLUMN"]
]

,[
    "Reinforcement", /* Zone Name */
    "EAST",false, /* Side, is Active */ [],[],
    /* Groups: */
    [
        [
            2, /* Groups quantity */
            /* Units */
            [
                ["O_Soldier_F", [], "KIT"]
                ,["O_Soldier_F", [], "KIT"]
                ,["O_Soldier_F", [], "KIT"]
                ,["O_Soldier_F", [], "KIT"]
            ]
        ]
        ,[
            1, /* Groups quantity */
            /* Units */
            [
                ["HOSTILE_VEH", "Vehicle Patrol", "HOSTILE_VEH_KIT"]
                ,["O_Soldier_F", [0,"Driver"], "KIT"]
                ,["O_Soldier_F", [0,"Gunner"], "KIT"]
            ]
        ]
    ],
    /* Behavior: Speed, Behavior, Combat mode, Formation */
    ["NORMAL","AWARE","YELLOW","STAG COLUMN"]
]
