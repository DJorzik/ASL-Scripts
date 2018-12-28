// Turok 2: Seeds of Evil - Auto Splitter - by DJorzik
// For instructions or premade splits visit my github page: https://github.com/DJorzik/ASL-Scripts
// Special thanks to DvD_01 for testing and answering questions

//TODO START TIMER NEXT LOAD ZONE + CM -> Boss (+ PMGN Counter Reset) (learning)
//TODO SPLIT OPTIONS FOR ITEMS (COULD BE IMPLEMENTED WITHOUT MUCH WORK FOR LEVEL BASED SPLITTING)
//TODO FIND PRIMAGEN PHASES IN MEMORY
//TODO CHANGE DESCRIPTION
//TODO LEVELINFO TUPLE/DICTIONARY
//TODO CURRENTLY SPLITS IF YOU LOAD FROM SOMEWHERE ELSE INTO THE HUB -> CHANGE INMENU (ID TIMING RELATED)
//TODO POSSIBLY PROBLEMATIC IF SOMEONE WARPS INTO THE WRONG LEVEL AND RELOADS 
//TODO MAYBE OFFER OPTIONS FOR SPLITTING BEFORE OR AFTER A LOAD
//TODO MAYBE REFINE SPLITS AFTER BOSS FIGHTS FOR LEVEL BASED SPLITTING (BOSS/TOTEM BASED SPLITTING?)

state("Turok2")
{
	/* 
		isLoading:
		
		0x1CA5FC (old):
			- bool: 
					hits zero an "arbitrarily" amount of times while loading  
					including not hitting it at all 
					(reproducable)

					not suitable without more code
					(behavior corresponds to partial load cycles ending?)

					may be useful later

		0x1CA5F8 (new):
			- int:  
					circular sequence: ... => 2 => 0 => 1 => 2 => 0 => ...
			- bool: 
					0 <-> not loading
					1 <-> loading
	*/

	int levelID : 0x1CA5F0;
	bool isLoading : 0x1CA5F8; 
	string30 levelName : 0x1741C8;
	bool inMenu : 0x1D4D0C;
	int primagenHP : 0x1CA71C;
}

startup
{
	/*
		vars.acclaimLogo_Name = "Acclaim logo";
		vars.iggy_Name = "(0) IGGY";
		vars.mainMenu_Name = "STARTMAP(don'tDelete)";
		vars.intro1_Name = "(6) cin adon";
		vars.hub_Name = "HUB";
		vars.rnd_Name = "cinema END 1b";
		vars.level1_1_Name = "Port of Adia 1";
		vars.level2_1_Name = "RiverOfSouls 1";
		vars.level3_1_Name = "Death Marsh 1";
		vars.level4_1_Name = "Blind Lair 1";
		vars.level5_1_Name = "HIVE TOP";
		vars.level6_1_Name = "Lightship 1";
		vars.oblivion2_Name = "River Oblivion";
		vars.primagenBoss_Name = "Primagen Boss";
	*/

	settings.Add("level", false, "Level Based Splitting");
	settings.SetToolTip("level", "Splits based on transitions to the hub and the death of the primagen at the end. (default: off)");

	vars.mainMenu = 0;
	vars.intro1 = 50;
	vars.hub = 60;
	vars.primagenBoss = 4;	
}

init
{
	vars.primagenPhase = 0;
	timer.IsGameTimePaused = false;
}

exit
{
	timer.IsGameTimePaused = true;	
}

update
{
	
}

start
{
	//Hit "NEW GAME" and the timer will start at the beginning of the intro (FULL) or if you load a save (IL)
	//Entering a level over the cheat menu won't start the timer

	vars.primagenPhase = 0;
	return old.levelID == vars.mainMenu && current.levelID == vars.intro1 || 
	       !current.inMenu && old.isLoading && !current.isLoading;
}					      

split
{
	//Splits every load zone but ignores loading from menu
	//Also splits right after defeating the primagen by counting his phases

	if(old.levelID == vars.primagenBoss && current.levelID == vars.primagenBoss)
	{
		if(old.primagenHP == 0 && current.primagenHP == 100) ++vars.primagenPhase;
		return vars.primagenPhase == 2 && old.primagenHP != 0 && current.primagenHP == 0;
	}

	if(current.inMenu) return false;
	return settings["level"] ? old.levelID != vars.hub && current.levelID == vars.hub  : 
				   !old.isLoading && current.isLoading;
}

reset
{
	//Every transition to the main menu resets the timer (Game Over -> Main Menu)

	return old.levelID != vars.mainMenu && current.levelID == vars.mainMenu; 
}

isLoading
{
	//Simple Load Time Removal if you enable "Game Time" in Auto Splitter Settings

	return current.isLoading;
}

gameTime
{

}
