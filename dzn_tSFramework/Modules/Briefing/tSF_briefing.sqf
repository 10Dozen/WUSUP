//     tSF Briefing
// Do not modify this part
#define BRIEFING		_briefing = [];
#define TOPIC(NAME) 	_briefing pushBack ["Diary", [ NAME,
#define END			]];
#define ADD_TOPICS	for "_i" from (count _briefing) to 0 step -1 do {player createDiaryRecord (_briefing select _i);};
//
//
// Briefing goes here

BRIEFING

TOPIC("Отряды")
"Отряды будут сформированы автоматически после запуска миссии. Ваша роль в отряде будет выбранна случайно"
END

TOPIC("Задание")
"Вашей задачей будет завхат и удержание зоны, которая будет выбрана после старта миссии."
END

ADD_TOPICS
