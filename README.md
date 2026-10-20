# README
Will contain instructions on how to modify the project.

<span style="color:rgb(255,128,128)">IMPORTANT: You will need at least [Godot 4.8](https://godotengine.org/download/archive/4.8-beta1/) (betas are out) to run the project due to menu offset transforms.</span>


# File structure
All the base menus, the board game system and general assets we've provided for minigames are stored in the `main_board` folder.
Do not edit content in here when making your minigame, but feel free to use it.

`default_theme.tres` is a simple theme that styles Buttons and sets the font of Control nodes to a pixel font (`res://main_board/fonts/retro-pixel-cute-prop.ttf`.)
- Set the `theme` attribute of a Control node to this file to apply the same effect.

### Individual minigames
All minigames are stored in the `minigames` folder.
Each minigame and their unique assets are stored in their own separate folder inside this.


We have made example minigames that you can duplicate and work from as a base.
# Minigame metadata
At the top level of a minigame's folder, there is a file called `data.tres`.
This is required to exist here for a minigame to be read in.
`data.tres` is a `MinigameData` resource (a custom prefab) with the following text fields:
- Title
- Author
- Description
   - This is a good place to put instructions.
- Thumbnail
   - Image displayed on the how to play screen.
- Scene Path
   -  The relative path to the scene that will get loaded in when the minigame commences.
	Double-click on your minigame's `data.tres` in the Files and you should be able to edit these fields in the Inspector.

You can test your minigame by going to the minigames menu from the title screen and clicking on your game.

# Input system
