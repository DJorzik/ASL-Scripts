
// Turok 2: Seeds of Evil - Auto Splitter - by DJorzik
// For instructions or premade splits visit my github page: https://github.com/DJorzik/ASL-Scripts
// Special thanks to DvD_01 for testing and answering questions

state("Turok2")
{
	int isLoading : 0x1CA5FC;
	string30 level : 0x1741C8;
	int inMenu : 0x1D4D0C;
}

startup
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
	
}

init
{
		
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
	return old.level == vars.mainMenu && current.level == vars.intro1 || current.inMenu == 0 && old.isLoading != 0 && current.isLoading == 0;	
}					      

split
{	
	//Splits every load zone but ignores loading from menu
	return current.inMenu == 0 && old.isLoading == 0 && current.isLoading != 0 || old.level == vars.primagenBoss && current.level == vars.end;
}

reset
{
	//Every transition to the main menu resets the timer (Game Over -> Main Menu)
	return old.level != vars.mainMenu && current.level == vars.mainMenu; 
}

isLoading
{
	//Simple Load Time Removal if you enable "Game Time" in Auto Splitter Settings
	return current.isLoading != 0;
}
