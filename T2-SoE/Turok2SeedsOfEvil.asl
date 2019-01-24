// Turok 2: Seeds of Evil - Auto Splitter - by DJorzik
// For instructions or premade splits visit my github page: https://github.com/DJorzik/ASL-Scripts
// Special thanks to DvD_01 for testing and answering questions
 
//TODO CHANGE DESCRIPTION / NEW LINK / REFER TO SPEEDRUN.COM
//TODO CURRENTLY SPLITS IF YOU LOAD FROM SOMEWHERE ELSE INTO THE HUB -> CHANGE INMENU (ID TIMING RELATED)
//TODO POSSIBLY PROBLEMATIC IF SOMEONE WARPS INTO THE WRONG LEVEL AND RELOADS 
//TODO MAYBE OFFER OPTIONS FOR SPLITTING BEFORE OR AFTER A LOAD
//TODO MAYBE REFINE SPLITS AFTER BOSS FIGHTS FOR LEVEL BASED SPLITTING (BOSS/TOTEM BASED SPLITTING?)

// General Plan
// - add addresses
// - utility functions
// - memory watcher
// - settings
// - split code

state("Turok2")
{
	/* TODO delete later
	int levelID : 0x1CA5F0;
	bool isLoading : 0x1CA5F8; //0x1CA5FC 
	string30 levelName : 0x1741C8;
	bool inMenu : 0x1D4D1C;
	*/
}

startup
{
	//=============================================================================
	// Memory Addresses
	//=============================================================================

	//Dictionary<category, List<Tuple<string, start, offset, length>>>
	//calc: F: +11;	D: -1; 

	vars.gameAddresses = new Dictionary<string, List<Tuple<List<string>, List<int>, int, int, int>>> {
		{ "General", new List<Tuple<List<string>, List<int>, int, int, int>> {		
			Tuple.Create(new List<string> {"Level ID"}, new List<int> {0x1CA5F0}, 0x0, 1, 1),
			Tuple.Create(new List<string> {"Is Loading"}, new List<int> {0x1CA5F8}, 0x0, 1, 1),
			Tuple.Create(new List<string> {"Level Name"}, new List<int> {0x1741C8}, 0x0, 1, 1),
			Tuple.Create(new List<string> {"In Menu"}, new List<int> {0x1D4D1C}, 0x0, 1, 1)
		}},
		{ "Player Stats", new List<Tuple<List<string>, List<int>, int, int, int>> {		
			Tuple.Create(new List<string> {"Health Points"}, new List<int> {0x181B6C, 0x525}, 0x0, 1, 1),
			Tuple.Create(new List<string> {"Life Forces"}, new List<int> {0x181B6C, 0x528}, 0x0, 1, 1),
			Tuple.Create(new List<string> {"Extra Lifes"}, new List<int> {0x181B6C, 0x52A}, 0x0, 1, 1),
			Tuple.Create(new List<string> {"Current Ammo"}, new List<int> {0x181B6C, 0x10B8}, 0x0, 1, 1)
		}},
		{ "Mission Objects", new List<Tuple<List<string>, List<int>, int, int, int>> {		
			//Port of Adia
			Tuple.Create(new List<string> {"Power Cells"}, new List<int> {0x181B6C, 0x5F4}, 0x0, 1, 1),

			//River Of Souls
			Tuple.Create(new List<string> {
				"Graveyard Keys", "Gate Keys"
			}, new List<int> {0x181B6C, 0x545}, 0x5, 2, 1),

			//Death Marshes
			Tuple.Create(new List<string> {"Satchel Charges"}, new List<int> {0x181B6C, 0x590}, 0x0, 1, 1),

			//Lair Of The Blind Ones
			Tuple.Create(new List<string> {
				"Cave Keys", "Satchel Charges"
			}, new List<int> {0x181B6C, 0x540}, 0x5B, 2, 1),

			//Hive Of The Mantids
			Tuple.Create(new List<string> {"Satchel Charges"}, new List<int> {0x181B6C, 0x59C}, 0x0, 1, 1),

			//Primagens Lightship
			Tuple.Create(new List<string> {
				"Green Ion Capacitors", "Red Laser Cells",
				"Blue Laser Cells", "Blue Ion Capacitors",
			}, new List<int> {0x181B6C, 0x612}, 0x1, 4, 1)
		}},
		{ "Ammo", new List<Tuple<List<string>, List<int>, int, int, int>> {	
			Tuple.Create(new List<string> {
				"Arrows", "Tek Arrows", "Pistol/Mag 50 Ammo"
			}, new List<int> {0x181B6C, 0x934}, 0x2, 3, 1),

			Tuple.Create(new List<string> {
				"Tranquilizer Darts", "Charge Dart Rifle Ammo",
				"Shotgun/Shredder Standard Shells", "Shotgun/Shredder Explosive Shells"
			}, new List<int> {0x181B6C, 0x93C}, 0x2, 4, 1),

			Tuple.Create(new List<string> {
				"Plasma/Cannon Ammo", "Sunfire Pod Amount", "Cerebral Bore Ammo", "P.F.M. Ammo", "Grenades",
				"Scorpion Missiles", "Harpoons", "Torpedos"
			}, new List<int> {0x181B6C, 0x946}, 0x2, 8, 1),

			Tuple.Create(new List<string> {
				"Flame Thrower Fuel", "Razor Wind Ammo", "Nuke Ammo", "Crossbow Ammo (MP)",
				"Charge Dart Rifle Ammo (MP)", "Assault Rifle Ammo (MP)", "Plasma Rifle Ammo (MP)",
				"Firestorm Cannon Ammo (MP)",  "Cerebral Bore Ammo (MP)", "Grenades (MP)",
				"Scorpion Missiles (MP)", "Harpoons (MP)", "Torpedos (MP)"
			}, new List<int> {0x181B6C, 0x95C}, 0x2, 13, 1)
		}},
		{ "Weapons", new List<Tuple<List<string>, List<int>, int, int, int>> {	
			Tuple.Create(new List<string> {
				"Talon", "War Blade", "Bow",  "Tek Bow", "Pistol",
				"Mag 60", "Tranquilizer", "Charge Dart Rifle",  "Shotgun", "Shredder",
				"Plasma Rifle", "Firestorm Cannon", "Sunfire Pod",  "Cerebral Bore", "P.F.M. Layer",
				"Grenade Launcher", "Scorpion Launcher", "Harpoon Gun",  "Torpedo Launcher"
			}, new List<int> {0x181B6C, 0x972}, 0x1, 19, 1),

			Tuple.Create(new List<string> {
				"Flame Thrower", "Razor Wind", "Nuke", "Flare",
				"Crossbow (MP)", "Charge Dart Rifle (MP)", "Assault Rifle (MP)", "Plasma Rifle (MP)",
				"Firestorm Cannon (MP)",  "Cerebral Bore (MP)", "Grenade Launcher (MP)",
				"Scorpion Launcher (MP)", "Harpoon Gun (MP)", "Torpedo Launcher (MP)"
			}, new List<int> {0x181B6C, 0x986}, 0x1, 14, 1)
		}},
		{ "Level Keys", new List<Tuple<List<string>, List<int>, int, int, int>> {	//Level 6 Keys read only
			Tuple.Create(new List<string> {
				"Level 2 Keys", "Level 3 Keys", "Level 4 Keys", "Level 5 Keys", "Level 6 Keys"
			}, new List<int> {0x181B6C, 0x662}, 0xA, 5, 1)
		}},
		{ "Primagen Keys", new List<Tuple<List<string>, List<int>, int, int, int>> {
			Tuple.Create(new List<string>{
				"First Primagen Key", "Second Primagen Key", "Third Primagen Key",
				"Fourth Primagen Key", "Fifth Primagen Key", "Sixth Primagen Key"
			}, new List<int> {0x181B6C, 0x694}, 0x1, 6, 1)
		}},
		{ "Eagle Feathers", new List<Tuple<List<string>, List<int>, int, int, int>> { //Not in Order
			Tuple.Create(new List<string> {
				"Blue Eagle Feather", "Grey Eagle Feather",
				"Brown Eagle Feather", "Purple Eagle Feather", "Red Eagle Feather" 
			}, new List<int> {0x181B6C, 0x6BC}, 0x1, 5, 1)
		}},
		{ "Talismans", new List<Tuple<List<string>, List<int>, int, int, int>> { //Not in Order
			Tuple.Create(new List<string> {
				"Breath of Life Talisman", "Eye of Truth Talisman",
				"Leap of Faith Talisman", "Whispers Talisman", "Heart of Fire Talisman"
			}, new List<int> {0x181B6C, 0x6A8}, 0x1, 5, 1)
		}},
		{ "Nuke Parts", new List<Tuple<List<string>, List<int>, int, int, int>> {	//read only
			Tuple.Create(new List<string>{

			}, new List<int> {0x181B6C, 0x71F}, 0x1, 6, 1)
		}},
		/* TODO
		{ "Missions", new List<Tuple<List<string>, List<int>, int, int, int>> {		


		}},
		*/
		{ "Bosses", new List<Tuple<List<string>, List<int>, int, int, int>> {	
			Tuple.Create(new List<string> {"Boss HP Bar"}, new List<int> {0x1CA71C}, 0x0, 1, 1),

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
			Tuple.Create(new List<string> {"B Worms"}, new List<int> {0x135E00}, 0x4, 2, 1),

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
			Tuple.Create(new List<string> {"B Phase"}, new List<int> {0x135DFC}, 0x0, 1, 1),

			//eyes death is determined by the phase
			Tuple.Create(new List<string> {
				"B Puke Holes",			//[0,4]; P2
				"B Slime Tentacles",	//[0,4]; P1
				"B Wall Tentacles"		//[0,1]; P3 - bool!
			}, new List<int> {0x135E0C}, 0x4, 2, 1),

			//Mantid Queen
			//bossHPBar:: P[0,100]: SP1(94,100]; SP2(39,94]; SP3(6,39]; SP4[0,6]  

			//PC[1,8]: SP1[1,2]; SP2[3,4]; SP3[5,6]; SP4[7,8] 
			//odd: bug fights, except SP4: 7 = on the ground; 8 = dead
			Tuple.Create(new List<string> {"Q Phase"}, new List<int> {0x136C50}, 0x0, 1, 1),

			//BGKC[R, R + #KB] 1:[R,R+2]; 3:[R+2,R+2+4]; 5:[R+2+4,R+2+4+4]
			Tuple.Create(new List<string> {"Q Bugs"}, new List<int> {0x136CB0}, 0x0, 1, 1),

			Tuple.Create(new List<string> {
				"Q Butt",		//[0,255]	;SP2
				"Q Arms",		//[0,150]	;SP3
				"Q Head",		//[0,30]	;SP4
				"Q Small Arms"	//[0,25]	;SP1
			}, new List<int> {0x136AB1}, 0x68, 4, 1),

			//Mother
			//bossHPBar:: none
			//P1[0,240]; P2[0,300]; P3[0,500] 
			Tuple.Create(new List<string> {"Mother HP"}, new List<int> {0x136C50}, 0x0, 1, 2),

			Tuple.Create(new List<string> {
				"M Big Tentacle Right",	//[0,150]	;P2
				"M Tentacle 1R",	//[0,40]	;P1
				"M Tentacle 2R",	//[0,40]	;P1
				"M Tentacle 3R",	//[0,40]	;P1
				"M Big Tentacle Left",	//[0,150]	;P2
				"M Tentacle 1L",	//[0,40]	;P1
				"M Tentacle 2L",	//[0,40]	;P1
				"M Tentacle 3L"		//[0,40]	;P1
			}, new List<int> {0x135EE1}, 0x68, 8, 1),

			Tuple.Create(new List<string> {"M Head"}, new List<int> {0x1363C1}, 0x0, 1, 2), //[0,500]; P3

			//Primagen
			//bossHPBar: P1[0,100]; P2[0,100]; P3[0,100] 

			//P1[0,80]; P2[0,130]; P3[0,200]
			Tuple.Create(new List<string> {"Primagen HP"}, new List<int> {0x1364FD}, 0x0, 1, 1),

			Tuple.Create(new List<string> {
				"P Big Arm",	//[0,80]	;P2
				"P Head",	//[0,200]	;P3 - can underflow
				"P Small Arm",	//[0,50]	;P2
				"P Tentacle 1",	//[0,20]	;P1
				"P Tentacle 2",	//[0,20]	;P1
				"P Tentacle 3",	//[0,20]	;P1
				"P Tentacle 4",	//[0,20]	;P1
			}, new List<int> {0x136879}, 0x4, 7, 1)
		}}
	};

	//=============================================================================
	// Utility Functions
	//=============================================================================

	Func<string, string> toLowerCamelCase = (s) => {
		var x = s.Replace(" ", string.Empty)
				 .Replace("/", string.Empty)
				 .Replace("\\", string.Empty)
				 .Replace("(", string.Empty)
				 .Replace(")", string.Empty)
				 .Replace("]", string.Empty)
				 .Replace("[", string.Empty)
				 .Replace(".", string.Empty);
		Debug.Assert(x.Length == 0, "[toLowerCamelCase] empty string");
		x = System.Text.RegularExpressions.Regex.Replace(x, "([A-Z])([A-Z]+)($|[A-Z])",
			m => m.Groups[1].Value + m.Groups[2].Value.ToLower() + m.Groups[3].Value);
		return char.ToLower(x[0]) + x.Substring(1);
	};
	vars.toLowerCamelCase = toLowerCamelCase;

	Action<string> DebugOutput = (s) => {
		print("[T2:SOE:Classic Autosplitter] " + s);
	};
	vars.DebugOutput = DebugOutput;

	//=============================================================================
	// Settings
	//=============================================================================
	
	vars.mainMenu = 0;
	vars.intro1 = 50;
	vars.hub = 60;
	vars.primagenBoss = 4;	
}

init
{
	timer.IsGameTimePaused = false;

	//=============================================================================
	// Memory Watcher
	//=============================================================================

	//=============================================================================
	// Pre-Formatting (do it later on the fly)
	//=============================================================================

	foreach(KeyValuePair<string, List<Tuple<List<string>, List<int>, int, int, int>>> entry in vars.gameAddresses)
	{
		for(int i = 0; i < entry.Value.Count; ++i)
		{		
			for(int j = 0; j < entry.Value[i].Item1.Count; ++j) 
			{
				vars.DebugOutput("Reformatted \"" + entry.Value[i].Item1[j] + "\" => ...");
				entry.Value[i].Item1[j] = vars.toLowerCamelCase(entry.Value[i].Item1[j]);
				vars.DebugOutput("... => \"" + entry.Value[i].Item1[j] + "\"");
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
	//TODO Watcher
}

start
{

}					      

split
{

				   
}

reset
{
	return old.levelID != vars.mainMenu && current.levelID == vars.mainMenu; 
}

isLoading
{
	//Simple Load Time Removal if you enable "Game Time" in Auto Splitter Settings

	return current.isLoading;
}