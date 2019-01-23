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
	int levelID : 0x1CA5F0;
	bool isLoading : 0x1CA5F8; //0x1CA5FC 
	string30 levelName : 0x1741C8;
	bool inMenu : 0x1D4D1C;
}

startup
{
	//=============================================================================
	// Memory Addresses
	//=============================================================================

	//Dictionary<category, List<Tuple<string, start, offset, length>>>

	vars.items = new Dictionary<string, List<Tuple<List<string>, List<int>, int, int>>> {
		{ "Ammo", new List<Tuple<List<string>, List<int>, int, int, int>>> {	
			Tuple.Create(new List<string> {
				"Arrows", "Tek Arrows", "Pistol/Mag 50 Ammo"
			}, new List<int> {0x181B6C, 0x934}, 0x2, 3, 1),

			Tuple.Create(new List<string> {
				"Tranquilizer Darts", "Charge Dart Rifle Ammo",
				"Shotgun/Shredder Standard Shells", "Shotgun/Shredder Explosive Shells"
			}, new List<int> {0x181B6C, 0x93C}, 0x2, 4, 1),

			Tuple.Create(new List<string> {
				"Plasma/Cannon Ammo", "Sunfire Pods", "Cerebral Bore Ammo", "P.F.M. Ammo", "Grenades",
				"Scorpion Missiles", "Harpoons", "Torpedos"
			}, new List<int> {0x181B6C, 0x946}, 0x2, 8, 1),

			Tuple.Create(new List<string> {
				"Flame Thrower Fuel", "Razor Wind", "Nuke Ammo", "Crossbow Ammo (MP)",
				"Charge Dart Rifle Ammo (MP)", "Assault Rifle Ammo (MP)", "Plasma Rifle Ammo (MP)",
				"Firestorm Cannon Ammo (MP)",  "Cerebral Bore Ammo (MP)", "Grenades (MP)",
				"Scorpion Missiles (MP)", "Harpoons (MP)", "Torpedos (MP)"
			}, new List<int> {0x181B6C, 0x95C}, 0x2, 13, 1),
		}},
		{ "Weapons", new List<Tuple<List<string>, List<int>, int, int, int>>> {	
			Tuple.Create(new List<string> {
				"Talon", "War Blade", "Bow",  "Tek Bow", "Pistol",
				"Mag 60", "Tranquilizer", "Charge Dart Rifle",  "Shotgun", "Shredder",
				"Plasma Rifle", "Firestorm Cannon", "Sunfire Pod",  "Cerebral Bore", "P.F.M. Layer",
				"Grenade Launcher", "Scorpion Launcher", "Harpoon Gun",  "Torpedo Launcher"
			}, new List<int> {0x181B6C, 0x972}, 0x1, 19, 1),

			Tuple.Create(new List<string> {
				"Flame Thrower", "Razor Wind", "Nuke", "Flare",
				"Crossbow (MP)", "Charge Dart Rifle (MP)", "Assault Rifle (MP)", "Plasma Rifle (MP)",
				"Firestorm Cannon (MP)",  "Cerebral Bore (MP)", "Grenade Launcher (MP)", "Scorpion Launcher (MP)",
				"Harpoon Gun (MP)", "Torpedo Launcher (MP)"
			}, new List<int> {0x181B6C, 0x986}, 0x1, 14, 1)
		}},
		{ "Level Keys", new List<Tuple<List<string>, List<int>, int, int, int>>> {	//Level 6 Keys read only
			Tuple.Create(null, new List<int> {0x181B6C, 0x662}, 0xA, 6, 1)
		}},
		{ "Primagen Keys", new List<Tuple<List<string>, List<int>, int, int, int>>> {
			Tuple.Create(null, new List<int> {0x181B6C, 0x694}, 0x1, 6, 1)
		}},
		{ "Eagle Feathers", new List<Tuple<List<string>, List<int>, int, int, int>>> { //Not in Order
			Tuple.Create(new List<string> {
				"Blue", "Grey", "Brown", "Purple", "Red" 
			}, new List<int> {0x181B6C, 0x6BC}, 0x1, 5, 1)
		}},
		{ "Talismans", new List<Tuple<List<string>, List<int>, int, int, int>>> { //Not in Order
			Tuple.Create(new List<string> {
				"Breath of Life", "Eye of Truth", "Leap of Faith", "Whispers", "Heart of Fire"
			}, new List<int> {0x181B6C, 0x6A8}, 0x1, 5, 1)
		}},
		{ "Nuke Parts", new List<Tuple<List<string>, List<int>, int, int, int>>> {	//read only
			Tuple.Create(null, new List<int> {0x181B6C, 0x71F}, 0x1, 6, 1)
		}},
	}


	//=============================================================================
	// Functions
	//=============================================================================

	Func<string, string> toLowerCamelCase = (s) => {
		var x = s.Replace("_", string.Empty).Replace(" ", string.Empty);
        Debug.Assert(x.Length == 0, "[toLowerCamelCase] empty string");
        x = System.Text.RegularExpressions.Regex.Replace(x, "([A-Z])([A-Z]+)($|[A-Z])",
            m => m.Groups[1].Value + m.Groups[2].Value.ToLower() + m.Groups[3].Value);
        return char.ToLower(x[0]) + x.Substring(1);
	};
	vars.toLowerCamelCase = toLowerCamelCase;

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