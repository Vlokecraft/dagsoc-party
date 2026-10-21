# README
Will contain instructions on how to modify the project.

# File structure
All the base menus, the board game system and general assets we've provided for minigames are stored in the `main_board` folder.
Do not edit content in here when making your minigame, but feel free to use it.

`default_theme.tres` is a simple theme that styles Buttons and sets the font of Control nodes to a pixel font (`res://shared/assets/fonts/retro_pixel_cute_prop.ttf`.)
- Set the `theme` attribute of a Control node to this file to apply the same effect.

### Individual minigames
All minigames are stored in the `minigames` folder.
Each minigame and their unique assets are stored in their own separate folder inside this.



We have made an example minigame (`res://minigames/example_minigame/`) that you're reccomended to duplicate and work from as a base.
### Minigame metadata
At the top level of a minigame's folder, there is a file called `data.tres`.
This is required to exist here for a minigame to be read in.
`data.tres` is a `MinigameData` resource (a custom prefab) with the following text fields:
- Title
- Author
- Description
   - This is a good place to put instructions.
- Scene Path
   -  The relative path to the scene that will get loaded in when the minigame commences.
	Double-click on your minigame's `data.tres` in the Files and you should be able to edit these fields in the Inspector.
