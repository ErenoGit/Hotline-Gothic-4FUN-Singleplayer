# Hotline Gothic 4FUN Singleplayer

Gamemod Hotline Gothic is a simple script designed for the Gothic 2 Online platform (https://gothic-online.com), created on version 0.3.2.3.
The project was created for fun, to satisfy my own curiosity as to whether it would be possible.
The game mode consists of scoring points by shooting with a crossbow-shotgun at NPCs running up from all sides.

The script includes:
- original music player
- add-on containing the required textures and sound files
- BASS.dll module for playing music and sounds
- LocalStorage module for saving/reading the best score achieved
- bullet collision detection using bbox3d
- simple practical use of classes
- use of VisualFX
- custom crossbow-shotgun firing five projectiles at once (wow)
- custom cursor and character shooting towards the cursor
- GUI adapting to the player's screen resolution
- AreaManager (https://gitlab.com/g2o/scripts/areamanager)
- CameraPath (https://gitlab.com/g2o/scripts/camerapath)
- GUI Framework 2.0 by Tommy & Patrix (https://gitlab.com/g2o/scripts/gui-framework)

FAQ:
1. Why is missiles flight in onRender? Couldn't this have been done better? It's very resource-heavy on the game.
Answer: I know, but no other solution gave good results. I wanted to make the crossbow similar to a shotgun without interfering with the game engine. I wanted the add-on to contain only bare textures and sound files so that it would not interfere with Gothic scripts (so that people with add-ons with custom scripts would not have any problems with its operation).

2. Why is the character we control not the default character but an NPC?
Answer: I encountered a problem with the default character's (heroId) running animation when the bow/crossbow weapons mode is set. NPCs did not have this problem, so I had to make this workaround.

3. Sometimes characters shake strangely, why?
Answer: I don't know. It's probably something related to animations/use of animations in scripts/Gothic engine. I haven't looked into it.

4. I could have done better. Why are you uploading such rubbish?
Answer: Well, me too, but it's a casual project created in a few evenings out of boredom. I'm sharing it mainly to show some examples of how certain scripts/functions/modules can be used in practice in the latest version of G2O. If even one person finds something they need here or learns something, my mission is accomplished.

5. Cool project, can I continue it or change something in it?
Answer: Sure, take this project and even sign it if you want. I don't claim any rights to this script.

-----------------------------------------------------------------------------------
![Menu](https://i.imgur.com/53EIWCV.jpeg "Menu")

![Game](https://i.imgur.com/3cskGxm.jpeg "Game")