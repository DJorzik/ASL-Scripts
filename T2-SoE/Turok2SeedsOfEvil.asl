// Turok 2: Seeds of Evil - Auto Splitter - by DJorzik
// For instructions or premade splits visit my github page: https://github.com/DJorzik/ASL-Scripts
// Special thanks to DvD_01 for testing and answering questions

//Not Important
//TODO START TIMER NEXT LOAD ZONE + CM -> Boss (+ PMGN Counter Reset) (learning)
//TODO SPLIT OPTIONS FOR ITEMS

//Important
//TODO replace string comparisons with ID
//TODO find primagen phases directly in memory

state("Turok2")
{
	int LevelID : 0x1CA5F0;
	bool IsLoading : 0x1CA5F8; // changes with every little load cycle -> 0x1CA5FC;
	string30 LevelName : 0x1741C8;
	bool InMenu : 0x1D4D0C;
	int PrimagenHP : 0x1CA71C;
}

startup
{

}

init
{
	/*
	vars.AcclaimLogo = "Acclaim logo";
	vars.Iggy = "(0) IGGY";
	vars.Hub = "HUB";
	vars.End = "cinema END 1b";
	vars.Level1B = "Port of Adia 1";
	vars.Level2B = "RiverOfSouls 1";
	vars.Level3B = "Death Marsh 1";
	vars.Level4B = "Blind Lair 1";
	vars.Level5B = "HIVE TOP";
	vars.Level6B = "Lightship 1";
	vars.Oblivion2 = "River Oblivion";
	*/

	vars.MainMenu = "STARTMAP(don'tDelete)";
	vars.Intro1 = "(6) cin adon";

	vars.PrimagenBoss = "Primagen Boss";	
	vars.PrimagenPhase = 0;

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

	vars.PrimagenPhase = 0;
	return old.LevelName == vars.MainMenu && current.LevelName == vars.Intro1 || !current.InMenu && old.IsLoading && !current.IsLoading;
}					      

split
{
	//Splits every load zone but ignores loading from menu
	//Also splits right after defeating the primagen by counting his phases

	if(old.LevelName == vars.PrimagenBoss && current.LevelName == vars.PrimagenBoss)
	{
		if(old.PrimagenHP == 0 && current.PrimagenHP == 100) ++vars.PrimagenPhase;
		return vars.PrimagenPhase == 2 && old.PrimagenHP != 0 && current.PrimagenHP == 0;
	}
	return !current.InMenu && !old.IsLoading && current.IsLoading;
}

reset
{
	//Every transition to the main menu resets the timer (Game Over -> Main Menu)

	return old.LevelName != vars.MainMenu && current.LevelName == vars.MainMenu; 
}

isLoading
{
	//Simple Load Time Removal if you enable "Game Time" in Auto Splitter Settings

	return current.IsLoading;
}

gameTime
{

}
