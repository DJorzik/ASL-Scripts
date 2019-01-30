// Turok 2: Seeds of Evil - Auto Splitter - by DJorzik
// For instructions or premade splits visit my github page: https://github.com/DJorzik/ASL-Scripts
// Special thanks to DvD_01 for testing and answering questions
 
//TODO CHANGE DESCRIPTION / NEW LINK / REFER TO SPEEDRUN.COM

state("Turok2")
{
	
}

startup
{
	vars.watchers = new MemoryWatcherList();

	//=============================================================================
	// Data and Memory Addresses
	//=============================================================================
	//main calc: F: +11; D: -1; 
	//TODO maybe better ds
	//TODO add missions
	//TODO bind keys to level

	vars.levelIDs = new Dictionary<string, int> {
		{"Main Menu", 0},
		{"Intro1", 50},
		{"Hub", 60},
		{"Primagen Boss", 4}
	};

	vars.mainLevelNames = new List<Tuple<string, string>> {
		Tuple.Create("poa", "Port of Adia"),
		Tuple.Create("ros", "River Of Souls"),
		Tuple.Create("dm", "Death Marshes"),
		Tuple.Create("lotbo", "Lair Of The Blind Ones"),
		Tuple.Create("hotm", "Hive Of The Mantids"),
		Tuple.Create("pl", "Primagens Lightship")
	};
	
	vars.bossData = new List<Tuple<string, int>> {
		Tuple.Create(string.Empty, 0),
		Tuple.Create(string.Empty, 0),
		Tuple.Create(string.Empty, 0),
		Tuple.Create("The Blind One Boss", 4),
		Tuple.Create("Mantid Queen Boss", 4),
		Tuple.Create("Mother Boss", 3),
		Tuple.Create("Primagen Endboss", 3)
	};
	
	vars.gameAddresses = new Dictionary<string, List<Tuple<List<Tuple<string, int, int, int>>, List<int>, int, int>>> {
		{ "General", new List<Tuple<List<Tuple<string, int, int, int>>, List<int>, int, int>> {		

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Level ID", -1, -1, -1)
			}, new List<int> {0x1CA5F0}, 0x0, 3),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Is Loading", -1, 0, 1)
			}, new List<int> {0x1CA5F8}, 0x0, 0),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Level Name", -1, -1, -1)
			}, new List<int> {0x1741C8}, 0x0, 11),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("In Menu", -1, 0, 1)
			}, new List<int> {0x1D4D1C}, 0x0, 0)

		}},
		{ "Player Stats", new List<Tuple<List<Tuple<string, int, int, int>>, List<int>, int, int>> {	
		
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Health Points", -1, 0, 200)
			}, new List<int> {0x181B6C, 0x525}, 0x0, 1), //off by 1 sometimes

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Life Forces", -1, 0, 100)
			}, new List<int> {0x181B6C, 0x528}, 0x0, 1),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Extra Lifes", -1, 0, 9)
			}, new List<int> {0x181B6C, 0x52A}, 0x0, 1),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Current Ammo", -1, 0, 150)
			}, new List<int> {0x181B6C, 0x10B8}, 0x0, 1)
		
		}},
		{ "Mission Objects", new List<Tuple<List<Tuple<string, int, int, int>>, List<int>, int, int>> {		

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Power Cells", 0, 0, 3)
			}, new List<int> {0x181B6C, 0x5F4}, 0x0, 1),
			
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Graveyard Keys", 1, 0, 2),
				Tuple.Create("Gate Keys", 1, 0, 2)
			}, new List<int> {0x181B6C, 0x545}, 0x5, 1),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Satchel Charges", 2, 0, 3)
			}, new List<int> {0x181B6C, 0x590}, 0x0, 1),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Cave Keys", 3, 0, 3),
				Tuple.Create("Satchel Charges", 3, 0, 8)
			}, new List<int> {0x181B6C, 0x540}, 0x5B, 1),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Satchel Charges", 4, 0, 4)
			}, new List<int> {0x181B6C, 0x59C}, 0x0, 1),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Green Ion Capacitors", 5, 0, 16),
				Tuple.Create("Red Laser Cells", 5, 0, 4),
				Tuple.Create("Blue Laser Cells", 5, 0, 4),
				Tuple.Create("Blue Ion Capacitors", 5, 0, 16)		
			}, new List<int> {0x181B6C, 0x612}, 0x1, 1)

		}},
		{ "Ammo", new List<Tuple<List<Tuple<string, int, int, int>>, List<int>, int, int>> {	

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Arrows", -1, 0, 20),
				Tuple.Create("Tek Arrows", -1, 0, 10),
				Tuple.Create("Pistol/Mag 50 Ammo", -1, 0, 50)
			}, new List<int> {0x181B6C, 0x934}, 0x2, 1),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Tranquilizer Darts", -1, 0, 15),
				Tuple.Create("Charge Dart Rifle Ammo", -1, 0, 30),
				Tuple.Create("Shotgun/Shredder Standard Shells", -1, 0, 20),
				Tuple.Create("Shotgun/Shredder Explosive Shells", -1, 0, 10)
			}, new List<int> {0x181B6C, 0x93C}, 0x2, 1),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Plasma/Cannon Ammo", -1, 0, 150),
				Tuple.Create("Sunfire Pod Amount", -1, 0, 6),
				Tuple.Create("Cerebral Bore Ammo", -1, 0, 10),
				Tuple.Create("P.F.M. Ammo", -1, 0, 10),
				Tuple.Create("Grenades", -1, 0, 10),
				Tuple.Create("Scorpion Missiles", -1, 0, 12),
				Tuple.Create("Harpoons", -1, 0, 12),
				Tuple.Create("Torpedos", -1, 0, 3)
			}, new List<int> {0x181B6C, 0x946}, 0x2, 1),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Flame Thrower Fuel", -1, 0, 50),
				Tuple.Create("Razor Wind Ammo", -1, 0, 1),
				Tuple.Create("Nuke Ammo", -1, 0, 5),
				Tuple.Create("Crossbow Ammo (MP)", -1, 0, -1),
				Tuple.Create("Charge Dart Rifle Ammo (MP)", -1, 0, 40),
				Tuple.Create("Assault Rifle Ammo (MP)", -1, 0, 100),
				Tuple.Create("Plasma Rifle Ammo (MP)", -1, 0, 100),
				Tuple.Create("Firestorm Cannon Ammo (MP)", -1, 0, -1),
				Tuple.Create("Cerebral Bore Ammo (MP)", -1, 0, 50),
				Tuple.Create("Grenades (MP)", -1, 0, 50),
				Tuple.Create("Scorpion Missiles (MP)", -1, 0, 25),
				Tuple.Create("Harpoons (MP)", -1, 0, -1),
				Tuple.Create("Torpedos (MP)", -1, 0, -1)
			}, new List<int> {0x181B6C, 0x95C}, 0x2, 1)

		}},
		{ "Weapons", new List<Tuple<List<Tuple<string, int, int, int>>, List<int>, int, int>> {	

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Talon", -1, 0, 1),
				Tuple.Create("War Blade", 1, 0, 1),
				Tuple.Create("Bow", -1, 0, 1),
				Tuple.Create("Tek Bow", 0, 0, 1),
				Tuple.Create("Pistol", 0, 0, 1),
				Tuple.Create("Mag 60", 1, 0, 1),
				Tuple.Create("Tranquilizer", 1, 0, 1),
				Tuple.Create("Charge Dart Rifle", 3, 0, 1),
				Tuple.Create("Shotgun", 0, 0, 1),
				Tuple.Create("Shredder", 2, 0, 1),
				Tuple.Create("Plasma Rifle", 2, 0, 1),
				Tuple.Create("Firestorm Cannon", 4, 0, 1),
				Tuple.Create("Sunfire Pod", 3, 0, 1),
				Tuple.Create("Cerebral Bore", 3, 0, 1),
				Tuple.Create("P.F.M. Layer", 4, 0, 1),
				Tuple.Create("Grenade Launcher", 2, 0, 1),
				Tuple.Create("Scorpion Launcher", 4, 0, 1),
				Tuple.Create("Harpoon Gun", 3, 0, 1),
				Tuple.Create("Torpedo Launcher", 3, 0, 1)
			}, new List<int> {0x181B6C, 0x972}, 0x1, 0),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Flame Thrower", 3, 0, 1),
				Tuple.Create("Razor Wind", 5, 0, 1),
				Tuple.Create("Nuke", 5, 0, 1),
				Tuple.Create("Flare", -1, 0, 1),
				Tuple.Create("Crossbow (MP)", -1, 0, 1),
				Tuple.Create("Charge Dart Rifle (MP)", -1, 0, 1),
				Tuple.Create("Assault Rifle (MP)", -1, 0, 1),
				Tuple.Create("Plasma Rifle (MP)", -1, 0, 1),
				Tuple.Create("Firestorm Cannon (MP)", -1, 0, 1),
				Tuple.Create("Cerebral Bore (MP)", -1, 0, 1),
				Tuple.Create("Grenade Launcher (MP)", -1, 0, 1),
				Tuple.Create("Scorpion Launcher (MP)", -1, 0, 1),
				Tuple.Create("Harpoon Gun (MP)", -1, 0, 1),
				Tuple.Create("Torpedo Launcher (MP)", -1, 0, 1)
			}, new List<int> {0x181B6C, 0x986}, 0x1, 0)

		}},
		{ "Level Keys", new List<Tuple<List<Tuple<string, int, int, int>>, List<int>, int, int>> {	

			//Level 6 Keys read only
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Level 2 Keys", 0, 0, 3),
				Tuple.Create("Level 3 Keys", 0, 0, 3),
				Tuple.Create("Level 4 Keys", 1, 0, 3),
				Tuple.Create("Level 5 Keys", 2, 0, 3),
				Tuple.Create("Level 6 Keys", -1, 0, 6) //3 & 4
			}, new List<int> {0x181B6C, 0x662}, 0xA, 1)

		}},
		{ "Primagen Keys", new List<Tuple<List<Tuple<string, int, int, int>>, List<int>, int, int>> {

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("First Primagen Key", 0, 0, 1),
				Tuple.Create("Second Primagen Key", 1, 0, 1),
				Tuple.Create("Third Primagen Key", 2, 0, 1),
				Tuple.Create("Fourth Primagen Key", 3, 0, 1),
				Tuple.Create("Fifth Primagen Key", 4, 0, 1),
				Tuple.Create("Sixth Primagen Key", 5, 0, 1)
			}, new List<int> {0x181B6C, 0x694}, 0x1, 1)

		}},
		{ "Eagle Feathers", new List<Tuple<List<Tuple<string, int, int, int>>, List<int>, int, int>> {

			//Not in Order
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Blue Eagle Feather", 2, 0, 1),
				Tuple.Create("Grey Eagle Feather", 5, 0, 1),
				Tuple.Create("Brown Eagle Feather", 1, 0, 1),
				Tuple.Create("Purple Eagle Feather", 4, 0, 1),
				Tuple.Create("Red Eagle Feather", 3, 0, 1)
			}, new List<int> {0x181B6C, 0x6BC}, 0x1, 1)

		}},
		{ "Talismans", new List<Tuple<List<Tuple<string, int, int, int>>, List<int>, int, int>> { 

			//Not in Order
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Breath of Life Talisman", 2, 0, 1),
				Tuple.Create("Eye of Truth Talisman", 5, 0, 1),
				Tuple.Create("Leap of Faith Talisman", 1, 0, 1),
				Tuple.Create("Whispers Talisman", 4, 0, 1),
				Tuple.Create("Heart of Fire Talisman", 3, 0, 1)
			}, new List<int> {0x181B6C, 0x6A8}, 0x1, 1)

		}},
		{ "Nuke Parts", new List<Tuple<List<Tuple<string, int, int, int>>, List<int>, int, int>> {

			//read only
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("First Nuke Part", 0, 0, 1),
				Tuple.Create("Second Nuke Part", 1, 0, 1),
				Tuple.Create("Third Nuke Part", 2, 0, 1),
				Tuple.Create("Fourth Nuke Part", 3, 0, 1),
				Tuple.Create("Fifth Nuke Part", 4, 0, 1),
				Tuple.Create("Sixth Nuke Part", 5, 0, 1)
			}, new List<int> {0x181B6C, 0x71F}, 0x1, 1)

		}},
		// TODO 
		{ "Missions", new List<Tuple<List<Tuple<string, int, int, int>>, List<int>, int, int>> {}},
		{ "Bosses", new List<Tuple<List<Tuple<string, int, int, int>>, List<int>, int, int>> {	

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Boss HP Bar", -1, 0, 100)
			}, new List<int> {0x1CA71C}, 0x0, 1),

			///The Blind One
			//bossHPBar:
			//P1: ST1: 31,23; ST2: 23,15; ST3: 15,7; ST4: 7,0 - (8/STi)
			//P2: PH1: 39,29; PHT2: 29,19; PH3: 19,9; PH4: 9,0 - (10/PHi)
			//P3: WT1: 9; WT2: 9; WT3: 9,0
			//P4: E: 0

			//WC1[0,12]: P1[0,8]; P2[0,8]; P3[0,12]; P4[0,0]
			//WC2[0,8]:  P1[4,8]; P2[4,8]; P3[4,8];  P4[0,0]
			//phase change if WC2 is 4
			//last 4 die off over time
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Blind Worm Count 1", 3, 0, 12),
				Tuple.Create("Blind Worm Count 2", 3, 0, 8)
			}, new List<int> {0x135E00}, 0x4, 1),

			//P1: 1,3,2,5; P2: 3,4; P3: 3,6; P4: 9,10
			//Note: can shortly hit 3 inbetween 6 and 9
			//1  - start
			//2  - cutscene
			//3  - worms
			//4  - pukeHoles
			//5  - slimeTentacles
			//6  - wallTentacles
			//9  - eye
			//10 - dead
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Blind Phase", 3, 1, 10)
			}, new List<int> {0x135DFC}, 0x0, 1),

			//eyes death is determined by the phase
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Blind Puke Hole Count", 3, 0, 4), //P2
				Tuple.Create("Blind Slime Tentacle Count", 3, 0, 4) //P1
			}, new List<int> {0x135E0C}, 0x4, 1),

			//seperated because of other type
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Blind Spawn Wall Tentacles", 3, 0, 1) //P3
			}, new List<int> {0x135E14}, 0x0, 0),

			//Mantid Queen
			//bossHPBar: P[0,100]: SP1(94,100]; SP2(39,94]; SP3(6,39]; SP4[0,6]  

			//PC[1,8]: SP1[1,2]; SP2[3,4]; SP3[5,6]; SP4[7,8] 
			//1 - bugs
			//2 - smallArms
			//3 - bugs
			//4 - butt
			//5 - bugs
			//6 - arms
			//7 - on the ground
			//8 - dead
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Queen Phase", 4, 1, 8)
			}, new List<int> {0x136C50}, 0x0, 1),

			//BGKC[R, R + #KB] 1:[R,R+2]; 3:[R+2,R+2+4]; 5:[R+2+4,R+2+4+4]
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Queen Bug Kill Counter", 4, -1, -1)
			}, new List<int> {0x136CB0}, 0x0, 1),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Queen Butt", 4, 0, 255), //SP2
				Tuple.Create("Queen Arms", 4, 0, 150), //SP3
				Tuple.Create("Queen Head", 4, 0, 30), //SP4
				Tuple.Create("Queen Small Arms", 4, 0, 25) //SP1
			}, new List<int> {0x136AB1}, 0x68, 1),

			//Mother
			//bossHPBar: none
			//P1[0,240]; P2[0,300]; P3[0,500] 
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Mother HP", 5, 0, 500)
			}, new List<int> {0x136C50}, 0x0, 2),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Mother Big Tentacle Right", 5, 0, 150), //P2
				Tuple.Create("Mother Tentacle 1R", 5, 0, 40), //P1
				Tuple.Create("Mother Tentacle 2R", 5, 0, 40), //P1
				Tuple.Create("Mother Tentacle 3R", 5, 0, 40), //P1
				Tuple.Create("Mother Big Tentacle Left", 5, 0, 150), //P2
				Tuple.Create("Mother Tentacle 1L", 5, 0, 40), //P1
				Tuple.Create("Mother Tentacle 2L", 5, 0, 40), //P1
				Tuple.Create("Mother Tentacle 3L", 5, 0, 40)  //P1
			}, new List<int> {0x135EE1}, 0x68, 1),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Mother Head", 5, 0, 500) // P3
			}, new List<int> {0x1363C1}, 0x0, 2), 

			//Primagen
			//bossHPBar: P1[0,100]; P2[0,100]; P3[0,100] 

			//P1[0,80]; P2[0,130]; P3[0,200]
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Primagen HP", -1, 0, 200)
			}, new List<int> {0x1364FD}, 0x0, 1),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Primagen Big Arm", -1, 0, 80), //P2
				Tuple.Create("Primagen Head", -1, 0, 200), //P3 - can underflow
				Tuple.Create("Primagen Small Arm", -1, 0, 50), //P2
				Tuple.Create("Primagen Tentacle 1", -1, 0, 20), //P1
				Tuple.Create("Primagen Tentacle 2", -1, 0, 20), //P1
				Tuple.Create("Primagen Tentacle 3", -1, 0, 20), //P1
				Tuple.Create("Primagen Tentacle 4", -1, 0, 20)  //P1
			}, new List<int> {0x136879}, 0x4, 1)
		}}
	};

	//=============================================================================
	// Debug and Utility Functions
	//=============================================================================

	Action<string> DebugOutput = (s) => {
		print("[T2:SOE:Classic Autosplitter] " + s);
	};
	vars.DebugOutput = DebugOutput;

	Func<string, string> toLowerCamelCase = (s) => {
		var x = s.Replace(" ", string.Empty)
			.Replace("/", string.Empty)
			.Replace("\\", string.Empty)
			.Replace("(", string.Empty)
			.Replace(")", string.Empty)
			.Replace("]", string.Empty)
			.Replace("[", string.Empty)
			.Replace(".", string.Empty);
		x = System.Text.RegularExpressions.Regex.Replace(x, "([A-Z])([A-Z]+)($|[A-Z])",
			m => m.Groups[1].Value + m.Groups[2].Value.ToLower() + m.Groups[3].Value);
		return char.ToLower(x[0]) + x.Substring(1);
	};
	vars.toLowerCamelCase = toLowerCamelCase;

	Action<string> DebugOutputCategory = (category) => {
		var cTupleList = vars.gameAddresses[category];
		DebugOutput("======== " + category.ToUpper() + " ========");
		for(int i = 0; i < cTupleList.Count; ++i)
		{
			var cTuple = cTupleList[i];
			for(int j = 0; j < cTuple.Item1.Count; ++j)
			{
				var cName = toLowerCamelCase(cTuple.Item1[j].Item1); 
				DebugOutput(cName + ": " + vars.watchers[cName].Current);
			}
		}
	};
	vars.DebugOutputCategory = DebugOutputCategory;

	//=============================================================================
	// Settings
	//=============================================================================

	settings.Add("deleteLater", true, "======== order for some parts doesn't matter for now ========");
	settings.Add("warps", true, "Warp Transitions");
	settings.Add("warpsToHub", true, "To The Hub", "warps");
	settings.Add("warpsFromHub", true, "From The Hub", "warps");


	for(int i = 0; i < vars.mainLevelNames.Count; ++i)
		settings.Add(vars.mainLevelNames[i].Item1, false, vars.mainLevelNames[i].Item2);

	var ordinalNames = new List<string> {"First", "Second", "Third", "Fourth"};

	var keysToAdd = new List<string> {
		"Level Keys",
		"Primagen Keys",
		"Eagle Feathers",
		"Talismans",
		"Weapons",
		"Mission Objects",
		"Bosses"
	};

	for(int i = 0; i < keysToAdd.Count; ++i)
	{	
		var entryKey = keysToAdd[i];
		var entryValue = vars.gameAddresses[entryKey];

		if(entryKey == "Bosses")
		{			
			for(int j = 3; j < vars.bossData.Count; ++j)
			{
				var cBossName = vars.bossData[j].Item1;
				var cBossNameKey = vars.toLowerCamelCase(cBossName);
				var cBossPhaseCount = vars.bossData[j].Item2;		
				settings.Add(cBossNameKey, false, cBossName,
					j != vars.bossData.Count - 1 ? vars.mainLevelNames[j].Item1 : null);
				for(int k = 0; k < cBossPhaseCount; ++k) 
					settings.Add(vars.toLowerCamelCase(cBossName + "Phase" + (k + 1).ToString()), false,
						ordinalNames[k] + " Phase", cBossNameKey);
			}
		}
		else
		{
			var cLevelEntryCount = new List<int>(new int[vars.mainLevelNames.Count]);

			for(int j = 0; j < entryValue.Count; ++j)
			{	
				var cDataTupleList = entryValue[j].Item1;
				for(int k = 0; k < cDataTupleList.Count; ++k) 
				{
					var cLevelIndex = cDataTupleList[k].Item2;
					if(cLevelIndex > -1) ++cLevelEntryCount[cLevelIndex];
				}
			}

			for(int j = 0; j < vars.mainLevelNames.Count; ++j)
			{
				if(cLevelEntryCount[j] > 1)
					settings.Add(vars.toLowerCamelCase(vars.mainLevelNames[j].Item1 + entryKey),
						false, entryKey, vars.mainLevelNames[j].Item1);
			}

			for(int j = 0; j < entryValue.Count; ++j)
			{	
				var cDataTupleList = entryValue[j].Item1;
				for(int k = 0; k < cDataTupleList.Count; ++k) 
				{
					var cDataTuple = cDataTupleList[k];
					var cName = cDataTuple.Item1;
					var cLevelIndex = cDataTuple.Item2;
					var cMax = cDataTuple.Item4;

					if(cLevelIndex > -1)
					{
						var cLevelKey = vars.mainLevelNames[cLevelIndex].Item1;
						var cSubEntryKey = vars.toLowerCamelCase(cLevelKey + cName);

						settings.Add(cSubEntryKey, false, cName, cLevelEntryCount[cLevelIndex] > 1 ?
							vars.toLowerCamelCase(cLevelKey + entryKey) : cLevelKey);

						if(entryKey == "Level Keys")
							for(int l = 0; l < cMax; ++l)
								settings.Add(cSubEntryKey.Remove(cSubEntryKey.Length - 1) + (l + 1).ToString(), false,
									"Key " + cName[6] + "-" + (l + 1).ToString(), cSubEntryKey);
					}
					else if(entryKey == "Level Keys")
					{
						var level4Key = vars.mainLevelNames[vars.mainLevelNames.Count - 3].Item1;
						var level4SubEntryKey = vars.toLowerCamelCase(level4Key + cName);	
						
						var level5Key = vars.mainLevelNames[vars.mainLevelNames.Count - 2].Item1;
						var level5SubEntryKey = vars.toLowerCamelCase(level5Key + cName);

						settings.Add(level4SubEntryKey, false, cName, level4Key);
						settings.Add(level5SubEntryKey, false, cName, level5Key);

						for(int l = 0; l < cMax; ++l)
						{
							if(l < 3)
								settings.Add(level4SubEntryKey.Remove(level4SubEntryKey.Length - 1) + (l + 1).ToString(), false,
									"Key " + cName[6] + "-" + (l + 1).ToString(), level4SubEntryKey);
							else
								settings.Add(level5SubEntryKey.Remove(level5SubEntryKey.Length - 1) + (l + 1).ToString(), false,
									"Key " + cName[6] + "-" + (l + 1).ToString(), level5SubEntryKey);
						}
					}
				}
			}
		}
	}	
}

init
{
	timer.IsGameTimePaused = false;

	//=============================================================================
	// Memory Watcher
	//=============================================================================

	foreach(KeyValuePair<string, List<Tuple<List<Tuple<string, int, int, int>>, List<int>, int, int>>> entry in vars.gameAddresses)
	{
		vars.DebugOutput("================ " + entry.Key.ToUpper() + " ================");
		for(int i = 0; i < entry.Value.Count; ++i)
		{	
			var cTuple = entry.Value[i];
			var cDataTupleList = cTuple.Item1;
			var cPointerPath = cTuple.Item2;
			var cOffset = cTuple.Item3;
			var cType = cTuple.Item4;

			vars.DebugOutput("------------ TUPLE " + (i+1).ToString() + " ------------");

			for(int j = 0; j < cDataTupleList.Count; ++j) 
			{
				var cDataTuple = cDataTupleList[j];
				var cName = vars.toLowerCamelCase(cDataTuple.Item1);
				var cDeepPointer = new DeepPointer(cPointerPath[0], cPointerPath.GetRange(1, cPointerPath.Count - 1).ToArray());
				
				switch(cType)
				{
					case 0: vars.watchers.Add(new MemoryWatcher<bool>(cDeepPointer) { Name = cName }); break;
					case 1: vars.watchers.Add(new MemoryWatcher<byte>(cDeepPointer) { Name = cName }); break;
					case 2: vars.watchers.Add(new MemoryWatcher<ushort>(cDeepPointer) { Name = cName }); break;
					case 3: vars.watchers.Add(new MemoryWatcher<uint>(cDeepPointer) { Name = cName }); break;
					case 4: vars.watchers.Add(new MemoryWatcher<ulong>(cDeepPointer) { Name = cName }); break;
					case 5: vars.watchers.Add(new MemoryWatcher<sbyte>(cDeepPointer) { Name = cName }); break;
					case 6: vars.watchers.Add(new MemoryWatcher<short>(cDeepPointer) { Name = cName }); break;
					case 7: vars.watchers.Add(new MemoryWatcher<int>(cDeepPointer) { Name = cName }); break;
					case 8: vars.watchers.Add(new MemoryWatcher<long>(cDeepPointer) { Name = cName }); break;
					case 9: vars.watchers.Add(new MemoryWatcher<float>(cDeepPointer) { Name = cName }); break;
					case 10: vars.watchers.Add(new MemoryWatcher<double>(cDeepPointer) { Name = cName }); break;
					case 11: vars.watchers.Add(new StringWatcher(cDeepPointer, 255) { Name = cName }); break;
					default: vars.DebugOutput("ERROR: " + cName + " has no valid type index."); break;
				}

				vars.watchers.UpdateAll(game);
				vars.DebugOutput("Added MemoryWatcher " + cName + " with Base: " + cPointerPath[0].ToString("X") + ","
								+ " Last Offset: " + cPointerPath[cPointerPath.Count - 1].ToString("X") + " and"
								+ " Current Value: " + vars.watchers[cName].Current);
				cPointerPath[cPointerPath.Count - 1] += cOffset;
			}		
		}
	}
	
}

exit
{
	timer.IsGameTimePaused = true;
}

update
{
	vars.watchers.UpdateAll(game);
	//vars.DebugOutputCategory("Ammo");
}

start
{
		var isNewGame = vars.watchers["levelId"].Old == vars.levelIDs["Main Menu"] &&
			vars.watchers["levelId"].Current == vars.levelIDs["Intro1"];

		var isLoadingSave = !vars.watchers["inMenu"].Current && 
			vars.watchers["isLoading"].Old &&
			!vars.watchers["isLoading"].Current;

		return isNewGame || isLoadingSave;
}					      

split
{

				   
}

reset
{
	var isTransitionToMainMenu =  vars.watchers["levelId"].Old != vars.levelIDs["Main Menu"] &&
		vars.watchers["levelId"].Current == vars.levelIDs["Main Menu"];

	return isTransitionToMainMenu; 
}

isLoading
{
	//Simple Load Time Removal if you enable "Game Time" in Auto Splitter Settings

	return vars.watchers["isLoading"].Current;
}