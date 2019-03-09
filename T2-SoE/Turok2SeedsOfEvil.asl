// Turok 2: Seeds of Evil - Auto Splitter - by DJorzik
// For instructions or premade splits visit my github page: https://github.com/DJorzik/ASL-Scripts
// Special thanks to DvD_01 for testing and answering questions
 
//TODO CHANGE DESCRIPTION / NEW LINK / REFER TO SPEEDRUN.COM 
//(I.E. NOT SAVING PHASE CHANGE, NOT USING ACTUAL SIZES )
//TODO CLEANUP & PERFORMANCE
//TODO FUN INJECTIONS (MP WEAPONS, etc.)

state("Turok2")
{
	
}

startup
{
	//=============================================================================
	// Initialization
	//=============================================================================

	vars.watchers = new MemoryWatcherList();
	vars.isSplit = false;

	//=============================================================================
	// Data and Memory Addresses
	//=============================================================================
	//main calc: F: +11; D: -1; 

	//TODO ADD MISSIONS
	//TODO SKIP IF NOT CHECKED
	//TODO ORDER (LEVEL KEYS, WEAPONS ...)
	//TODO DEFAULT VALUES
	//TODO TOTEMS & -1 KEYS & HUB
	//TODO COMMENT OUT DEBUG STUFF

	var ordinalNames = new List<string> {"First", "Second", "Third", "Fourth"};

	vars.keysToAdd = new List<string> {
		"Level Keys",
		"Primagen Keys",
		"Eagle Feathers",
		"Talismans",
		"Nuke Parts",
		"Weapons",
		//"Mission Objects",
		"Bosses"
	};

	vars.levelIDs = new Dictionary<string, int> {
		{"Main Menu", 0},
		{"The Blind One Boss", 1},
		{"Mantid Queen Boss", 2},
		{"Mother Boss", 3},
		{"Primagen Endboss", 4},
		{"Intro 1", 50},
		{"Hub", 60}
	};

	vars.mainLevelNames = new List<string> {
		"Port of Adia",
		"River Of Souls",
		"Death Marshes",
		"Lair Of The Blind Ones",
		"Hive Of The Mantids",
		"Primagens Lightship"
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
				Tuple.Create("Level 6 Keys", 3, 0, 3)
			}, new List<int> {0x181B6C, 0x662}, 0xA, 1),
			
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Level 6 Keys", 4, 3, 6)
			}, new List<int> {0x0, 0x0}, 0x0, 1)

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
			
			//===============
			///The Blind One
			//===============
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
			
			//============
			//Mantid Queen
			//============
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

			//======
			//Mother
			//======
			//bossHPBar: none

			//P1[0,240]; P2[0,300]; P3[0,500] 
			//doesn't hit zero consistently like the primagens hp value
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Mother HP", 5, 0, 500)
			}, new List<int> {0x1364D9}, 0x0, 2),

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

			//========
			//Primagen
			//========
			//bossHPBar: P1[0,100]; P2[0,100]; P3[0,100] 

			//P1[0,80]; P2[0,130]; P3[0,200]
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Primagen HP", -1, 0, 200)
			}, new List<int> {0x1364FD}, 0x0, 1),

			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Primagen Big Arm", -1, 0, 80), //P2 - underflow
				Tuple.Create("Primagen Head", -1, 0, 200), //P3 - underflow
				Tuple.Create("Primagen Small Arm", -1, 0, 50), //P2
				Tuple.Create("Primagen Tentacle 1", -1, 0, 20), //P1
				Tuple.Create("Primagen Tentacle 2", -1, 0, 20), //P1
				Tuple.Create("Primagen Tentacle 3", -1, 0, 20), //P1
				Tuple.Create("Primagen Tentacle 4", -1, 0, 20)  //P1
			}, new List<int> {0x136879}, 0x4, 1),

			//MSB of Primagen Head
			Tuple.Create(new List<Tuple<string, int, int, int>> {
				Tuple.Create("Is Primagen Head Underflow", -1, 0, 1)
			}, new List<int> {0x13687F}, 0x0, 0)
		}}
	};

	//=============================================================================
	// Debug Functions
	//=============================================================================

	Action<string> DebugOutput = (s) => {
		print("[T2:SOE:Classic Autosplitter] " + s);
	};
	vars.DebugOutput = DebugOutput;

	Action<string, Process> DebugOutputCategory = (category, p) => {
		var cTupleList = vars.gameAddresses[category];
		DebugOutput("======== " + category.ToUpper() + " ========");
		for(int i = 0; i < cTupleList.Count; ++i)
		{
			var cTuple = cTupleList[i];
			for(int j = 0; j < cTuple.Item1.Count; ++j)
			{
				var cName = cTuple.Item1[j].Item1; 
				var cWatcher = vars.watchers[cName];
				cWatcher.Update(p);
				DebugOutput(cName + ": " + cWatcher.Current);
			}
		}
	};
	vars.DebugOutputCategory = DebugOutputCategory;

	//=============================================================================
	// Settings
	//=============================================================================
	
	settings.Add("deleteLater", true, "======== order for some parts doesn't matter for now ========");
	settings.Add("Warps", true, "Warp Transitions");
	settings.Add("Warps To Hub", true, "To The Hub", "Warps");
	settings.Add("Warps From Hub", false, "From The Hub", "Warps");
	
	for(int i = 0; i < vars.mainLevelNames.Count; ++i)
	{
		var cLevelName = vars.mainLevelNames[i];
		settings.Add(cLevelName, false, cLevelName);
	}

	for(int i = 0; i < vars.keysToAdd.Count; ++i)
	{	
		var entryKey = vars.keysToAdd[i];
		var entryValue = vars.gameAddresses[entryKey];

		if(entryKey == "Bosses")
		{			
			for(int j = 3; j < vars.bossData.Count; ++j)
			{
				var cBossName = vars.bossData[j].Item1;
				var cBossPhaseCount = vars.bossData[j].Item2;		
				settings.Add(cBossName, false, cBossName,
					j != vars.bossData.Count - 1 ? vars.mainLevelNames[j] : null);
				for(int k = 0; k < cBossPhaseCount; ++k) 
					settings.Add(cBossName + " Phase " + (k + 1).ToString(), false,
						ordinalNames[k] + " Phase", cBossName);
			} 
		}
		else
		{
			var cLevelEntryCount = new List<int>(new int[vars.mainLevelNames.Count]);

			for(int j = 0; j < entryValue.Count; ++j)
			{
				var cTuple = entryValue[j];
				var cDataTupleList = cTuple.Item1;
				for(int k = 0; k < cDataTupleList.Count; ++k) 
				{
					var cLevelIndex = cDataTupleList[k].Item2;
					if(cLevelIndex > -1) ++cLevelEntryCount[cLevelIndex];
				}
			}

			for(int j = 0; j < vars.mainLevelNames.Count; ++j)
			{
				if(cLevelEntryCount[j] > 1)
				{
					var cLevelName = vars.mainLevelNames[j];
					settings.Add(cLevelName + " " + entryKey,
						false, entryKey, cLevelName);
				}
			}

			for(int j = 0; j < entryValue.Count; ++j)
			{
				var cTuple = entryValue[j];
				var cDataTupleList = cTuple.Item1;
				for(int k = 0; k < cDataTupleList.Count; ++k) 
				{
					var cDataTuple = cDataTupleList[k];
					var cName = cDataTuple.Item1;
					var cLevelIndex = cDataTuple.Item2;
					var cMin = cDataTuple.Item3;
					var cMax = cDataTuple.Item4;

					if(cLevelIndex > -1)
					{
						var cLevelName = vars.mainLevelNames[cLevelIndex];
						var cSubEntryKey = cLevelName + " " + cName;

						settings.Add(cSubEntryKey, false, cName, cLevelEntryCount[cLevelIndex] > 1 ?
							cLevelName + " " + entryKey : cLevelName);

						if(entryKey == "Level Keys")
						{
							for(int l = cMin; l < cMax; ++l)
							{
								var cSubKeyCount = (l + 1).ToString();
								settings.Add(cSubEntryKey.Remove(cSubEntryKey.Length - 1) + " " + cSubKeyCount, false,
									"Key " + cName[6] + "-" + cSubKeyCount, cSubEntryKey);
							}
						}
					}
				}
			}
		}
	}
}

init
{
	//=============================================================================
	// Initialization
	//=============================================================================

	timer.IsGameTimePaused = false;
	vars.isSplit = false;
	
	//=============================================================================
	// Utility Functions
	//=============================================================================

	Func<bool> isBlindPhaseChange = () => {
		var wBlindPhase = vars.watchers["Blind Phase"];
		wBlindPhase.Update(game);
		return (
			wBlindPhase.Old != wBlindPhase.Current && (
				   settings["The Blind One Boss Phase 1"] && wBlindPhase.Old == 5 
				|| settings["The Blind One Boss Phase 2"] && wBlindPhase.Old == 4
				|| settings["The Blind One Boss Phase 3"] && wBlindPhase.Old == 6
				|| settings["The Blind One Boss Phase 4"] && wBlindPhase.Old == 9
			)
		);		
	};
	vars.isBlindPhaseChange = isBlindPhaseChange;

	Func<bool> isQueenPhaseChange = () => {
		var wQueenPhase = vars.watchers["Queen Phase"];
		wQueenPhase.Update(game);
		return (
			wQueenPhase.Old != wQueenPhase.Current && (
				   settings["Mantid Queen Boss Phase 1"] && wQueenPhase.Old == 2
				|| settings["Mantid Queen Boss Phase 2"] && wQueenPhase.Old == 4
				|| settings["Mantid Queen Boss Phase 3"] && wQueenPhase.Old == 6
				|| settings["Mantid Queen Boss Phase 4"] && wQueenPhase.Old == 7
			)
		); 		
	};
	vars.isQueenPhaseChange = isQueenPhaseChange;

	Func<bool> isMotherPhaseChange = () => {
		var wMotherBTRHP = vars.watchers["Mother Big Tentacle Right"];
		var wMotherT1RHP = vars.watchers["Mother Tentacle 1R"];
		var wMotherT2RHP = vars.watchers["Mother Tentacle 2R"];
		var wMotherT3RHP = vars.watchers["Mother Tentacle 3R"];
		var wMotherBTLHP = vars.watchers["Mother Big Tentacle Left"];
		var wMotherT1LHP = vars.watchers["Mother Tentacle 1L"];
		var wMotherT2LHP = vars.watchers["Mother Tentacle 2L"];
		var wMotherT3LHP = vars.watchers["Mother Tentacle 3L"];
		var wMotherHeadHP = vars.watchers["Mother Head"];
		
		wMotherBTRHP.Update(game);
		wMotherT1RHP.Update(game);
		wMotherT2RHP.Update(game);
		wMotherT3RHP.Update(game);
		wMotherBTLHP.Update(game);
		wMotherT1LHP.Update(game);
		wMotherT2LHP.Update(game);
		wMotherT3LHP.Update(game);
		wMotherHeadHP.Update(game);

		var isFirstPhaseChange = (
			   wMotherT1RHP.Current == 0 
			&& wMotherT2RHP.Current == 0 
			&& wMotherT3RHP.Current == 0 
			&& wMotherT1LHP.Current == 0
			&& wMotherT2LHP.Current == 0 
			&& wMotherT3LHP.Current == 0 
			&& (
				   wMotherT1RHP.Old != 0
				|| wMotherT2RHP.Old != 0
				|| wMotherT3RHP.Old != 0
				|| wMotherT1LHP.Old != 0
				|| wMotherT2LHP.Old != 0
				|| wMotherT3LHP.Old != 0
			)
		);

		var isSecondPhaseChange =  (
			   wMotherBTRHP.Current == 0
			&& wMotherBTLHP.Current == 0
			&& (
				   wMotherBTRHP.Old != 0
				|| wMotherBTLHP.Old != 0
			)
		);

		var isThirdPhaseChange = (
			   wMotherHeadHP.Old != 0 
			&& wMotherHeadHP.Current == 0
		);

		return (
			   settings["Mother Boss Phase 1"] && isFirstPhaseChange
			|| settings["Mother Boss Phase 2"] && isSecondPhaseChange
			|| settings["Mother Boss Phase 3"] && isThirdPhaseChange
		);		
	};
	vars.isMotherPhaseChange = isMotherPhaseChange;

	Func<bool> isPrimagenPhaseChange = () => {
		var wPrimagenHP = vars.watchers["Primagen HP"];
		var wPrimagenHeadHP = vars.watchers["Primagen Head"];
		var wIsPrimagenHeadUF = vars.watchers["Is Primagen Head Underflow"];

		wPrimagenHP.Update(game);
		wPrimagenHeadHP.Update(game);
		wIsPrimagenHeadUF.Update(game);

		return (
			wPrimagenHP.Old == 0 && (
				   settings["Primagen Endboss Phase 1"] && wPrimagenHP.Current == 130
				|| settings["Primagen Endboss Phase 2"] && wPrimagenHP.Current == 200		
			)
			|| (
				   settings["Primagen Endboss Phase 3"] 
				&& wPrimagenHeadHP.Old != 0 && !wIsPrimagenHeadUF.Old
				&& (wPrimagenHeadHP.Current == 0 || wIsPrimagenHeadUF.Current)
			)
		);
	};
	vars.isPrimagenPhaseChange = isPrimagenPhaseChange;

	Func<string, bool> isPhaseChangeOf = (s) => {
		switch(s)
		{
			case "The Blind One Boss":	return vars.isBlindPhaseChange();
			case "Mantid Queen Boss":	return vars.isQueenPhaseChange();
			case "Mother Boss":			return vars.isMotherPhaseChange();
			case "Primagen Endboss":	return vars.isPrimagenPhaseChange();
			default:					return false;
		}
	};
	vars.isPhaseChangeOf = isPhaseChangeOf;

	//=============================================================================
	// Memory Watchers
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

			if(cPointerPath[0] != 0x0)
			{
				vars.DebugOutput("------------ TUPLE " + (i+1).ToString() + " ------------");

				for(int j = 0; j < cDataTupleList.Count; ++j) 
				{
					var cDataTuple = cDataTupleList[j];
					var cName = cDataTuple.Item1;
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

					var cWatcher = vars.watchers[cName];
					cWatcher.Update(game);
					vars.DebugOutput("Added MemoryWatcher " + cName + " with Base: " + cPointerPath[0].ToString("X") + ","
									+ " Last Offset: " + cPointerPath[cPointerPath.Count - 1].ToString("X") + " and"
									+ " Current Value: " + cWatcher.Current);

					cPointerPath[cPointerPath.Count - 1] += cOffset;
				}
			}
			else vars.DebugOutput("------------ TUPLE " + (i+1).ToString() + " SKIPPED ------------");
		}
	}	
}

exit
{
	timer.IsGameTimePaused = true;
}

update
{
	//TODO REFACTORING OF QUICK & DIRTY PARTS (Check Only Relevant Things & return)
	//TODO CHECK WHATS CHECKED & CHECK AFTER LOCATION
	//TODO WEAPONS IN BOSSFIGHTS IGNORED (BLIND) 
	//TODO MAYBE RETURN DIRECTLY AFTER FINDING SPLIT

	//TODO NEXT: DEFINE UTILITY FUNC FOR EVERY ENTITY 
	//(REDUCE UPDATE RATE BY PUTTING SETTINGS CHECK BEFORE UPDATE)

	//=============================================================================
	// Global Watcher Updates
	//=============================================================================

	var wLevelID = vars.watchers["Level ID"];
	var wIsLoading = vars.watchers["Is Loading"];
	var wInMenu = vars.watchers["In Menu"];

	wLevelID.Update(game);
	wIsLoading.Update(game);
	wInMenu.Update(game);

	//=============================================================================
	// Splitting
	//=============================================================================

	vars.isSplit = false;
	var hubID = vars.levelIDs["Hub"];
	
	if(settings["Warps"])
		vars.isSplit |= (
			   settings["Warps To Hub"] && wLevelID.Old != hubID && wLevelID.Current == hubID
			|| settings["Warps From Hub"] && wLevelID.Old == hubID && wLevelID.Current != hubID
		);

	for(int i = 0; i < vars.keysToAdd.Count; ++i)
	{	
		var entryKey = vars.keysToAdd[i];
		var entryValue = vars.gameAddresses[entryKey];

		if(entryKey == "Bosses")
		{
			for(int j = 3; j < vars.bossData.Count; ++j)
			{
				var cBossName = vars.bossData[j].Item1;
				vars.isSplit |= (
					   settings[cBossName]
					&& wLevelID.Current == vars.levelIDs[cBossName] 
					&& vars.isPhaseChangeOf(cBossName)
				);
			}
		}
		else
		{
			for(int j = 0; j < entryValue.Count; ++j)
			{
				var cTuple = entryValue[j];
				var cDataTupleList = cTuple.Item1;
				var cType = cTuple.Item4;
				for(int k = 0; k < cDataTupleList.Count; ++k)
				{
					var cDataTuple = cDataTupleList[k];
					var cName = cDataTuple.Item1;
					var cLevelIndex = cDataTuple.Item2;
					var cMin = cDataTuple.Item3;
					var cMax = cDataTuple.Item4;

					if(cLevelIndex > -1)
					{					
						var cLevelName = vars.mainLevelNames[cLevelIndex];
						if(settings[cLevelName])
						{
							switch((string)entryKey)
							{
								case "Weapons":
									var cwWeapon = vars.watchers[cName];
									cwWeapon.Update(game);
									vars.isSplit |= (
										   settings[cLevelName + " " + cName]
										&& !cwWeapon.Old && cwWeapon.Current
									);
									break;
								case "Level Keys":
									var cwLevelKey = vars.watchers[cName];
									cwLevelKey.Update(game);
									var cSubEntryKey = cLevelName + " " + cName;
									cSubEntryKey = cSubEntryKey.Remove(cSubEntryKey.Length - 1);
									for(int l = cMin; l < cMax; ++l)								
										vars.isSplit |= (
											   settings[cSubEntryKey + " " + (l + 1).ToString()]
											&& cwLevelKey.Old < cwLevelKey.Current
										); 
									break;
								case "Primagen Keys":
								case "Eagle Feathers": 
								case "Talismans": 
								case "Nuke Parts":
									var cwEntity = vars.watchers[cName];
									cwEntity.Update(game);
									vars.isSplit |= (
										   settings[cLevelName + " " + cName]
										&& cwEntity.Old < cwEntity.Current
									);
									break;	
							}
						}
					}
				}
			}
		}
	}
}

start
{
	var wLevelID = vars.watchers["Level ID"];
	var wIsLoading = vars.watchers["Is Loading"];
	var wInMenu = vars.watchers["In Menu"];

	var isNewGame = wLevelID.Old == vars.levelIDs["Main Menu"] &&
		wLevelID.Current == vars.levelIDs["Intro 1"];

	var isLoadingSave = !wInMenu.Current && 
		wIsLoading.Old && !wIsLoading.Current;

	return isNewGame || isLoadingSave;
}					      

split
{
	var wInMenu = vars.watchers["In Menu"];
	return vars.isSplit && !wInMenu.Current;		   
}

reset
{
	var wLevelID = vars.watchers["Level ID"];
	var mainMenuID = vars.levelIDs["Main Menu"];

	var isTransitionToMainMenu =  wLevelID.Old != mainMenuID &&
		wLevelID.Current == mainMenuID;

	return isTransitionToMainMenu; 
}

isLoading
{
	var wIsLoading = vars.watchers["Is Loading"];
	return wIsLoading.Current;
}