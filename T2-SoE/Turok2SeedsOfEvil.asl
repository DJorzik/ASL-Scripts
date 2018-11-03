// Turok 2: Seeds of Evil - Auto Splitter - by DJorzik
// For instructions or premade splits visit my github page: https://github.com/DJorzik/ASL-Scripts
// Special thanks to DvD_01 for testing and answering questions

//TODO START TIMER NEXT LOAD ZONE + CM -> Boss (+ PMGN Counter Reset) (learning)
//TODO SPLIT OPTIONS FOR ITEMS

state("Turok2")
{
	bool isLoading : 0x1CA5FC;
	string30 level : 0x1741C8;
	bool inMenu : 0x1D4D0C;
	int primagenHP : 0x1CA71C;
}

startup
{

}

init
{
	vars.mainMenu = "STARTMAP(don'tDelete)";
	vars.acclaimLogo = "Acclaim logo";
	vars.iggy = "(0) IGGY";
	vars.hub = "HUB";
	vars.intro1 = "(6) cin adon";
	vars.end = "cinema END 1b";
	vars.level1 = "Port of Adia 1";
	vars.level2 = "RiverOfSouls 1";
	vars.level3 = "Death Marsh 1";
	vars.level4 = "Blind Lair 1";
	vars.level5 = "HIVE TOP";
	vars.level6 = "Lightship 1";
	vars.primagenBoss = "Primagen Boss";	
	vars.primagenPhase = 0;
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
	return old.level == vars.mainMenu && current.level == vars.intro1 || !current.inMenu && old.isLoading && !current.isLoading;	
}					      

split
{
	//Splits every load zone but ignores loading from menu
	//Also splits right after defeating the primagen by counting his phases
	if(old.level == vars.primagenBoss && current.level == vars.primagenBoss)
	{
		if(old.primagenHP == 0 && current.primagenHP == 100) ++vars.primagenPhase;
		return vars.primagenPhase == 2 && old.primagenHP != 0 && current.primagenHP == 0;
	}
	return !current.inMenu && !old.isLoading && current.isLoading;	
}

reset
{
	//Every transition to the main menu resets the timer (Game Over -> Main Menu)
	return old.level != vars.mainMenu && current.level == vars.mainMenu; 
}

isLoading
{
	//Simple Load Time Removal if you enable "Game Time" in Auto Splitter Settings
	return current.isLoading;
}

gameTime
{

}
