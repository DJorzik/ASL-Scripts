# ASL-Scripts for Livesplit
## Turok 2: Seeds of Evil (WIP)
- If you need premade splits visit [SPEEDRUN.COM](http://www.speedrun.com/turok2/resources) (By DvD_01)
- Atm no item split triggers (your splits have to rely on warps) 
- Special thanks to [DvD_01](http://www.speedrun.com/user/DvD_01) for testing and answering questions
- You can always suggest changes and I will see what I can do
### TODO
 - Notice if someone is warping back accidentally 
   - Did not work due to problems with load timings & warping back and forth while progressing
   - Level name based split system did not help to fix the problems
   - Maybe find another memory address thats useful
 - Add item split triggers for 100% 
 - Only split if collecting a talisman, not while entering or leaving the shrines (same for nuke part?)
 - Don't split while entering or leaving the save portals
 - Split directly after defeating the Primagen
   - For now it splits at the start of the Adon end scene 
### INSTRUCTIONS
#### INSTALLATION

__⟹ You can activate the Auto Splitter directly in Live Split:__ 
![TL](https://github.com/DJorzik/ASL-Scripts/blob/master/Resources/T2SOE_INSTALL_LS.PNG?raw=true)

_If you downloaded premade splits and activated the Auto Splitter via Live Split_ <br/>
_make sure that the Game Name is exactly set to "Turok 2: Seeds of Evil"_ :boom:

__⟹ Otherwise download the .asl file [from my Repository](https://github.com/DJorzik/ASL-Scripts/releases) and add it manually:__ 
![TM1](https://github.com/DJorzik/ASL-Scripts/blob/master/Resources/T2SOE_INSTALL_M1.PNG?raw=true)
![TM2](https://github.com/DJorzik/ASL-Scripts/blob/master/Resources/T2SOE_INSTALL_M2.PNG?raw=true)
![TM3](https://github.com/DJorzik/ASL-Scripts/blob/master/Resources/T2SOE_INSTALL_M3.PNG?raw=true)

---

#### LOAD TIME REMOVAL
- __Off by default__
- Choose __"Game Time"__ in Auto Splitter Settings

---

#### FULL GAME RUN
##### START
- Hit __"NEW GAME"__ and the timer __will start at the beginning of the intro__
##### SPLIT
- Triggers next split in the list __if you enter a warp__
- Don't accidentally enter a warp more than once 
- Some places like save portals or talisman shrines will trigger 2 splits (entering & leaving)
##### RESET
- __Enter main menu__ again by going __game over or quitting__ the game

---

#### IL RUN
##### START
- __Load a save__
- Can be __triggered by any loading screen__ (blue transition screen)
- Entering a level over the cheat menu won't start the timer
##### SPLIT
- Triggers next split in the list __if you enter a warp__
- Don't accidentally enter a warp more than once 
- Some places like save portals or talisman shrines will trigger 2 splits (entering & leaving)
##### RESET
- __Enter main menu__ again by going __game over or quitting__ the game
- Just __reset manually and load the save again__ if you want to __quickly reset from within the level__

---
