# README
Will contain instructions on how to modify the project.

<span style="color:rgb(255,128,128)">IMPORTANT: You will need at least [Godot 4.8](https://godotengine.org/download/archive/4.8-beta1/) (betas are out) to run the project due to menu offset transforms.</span>


# File structure
All the base menus, the board game system and general assets we've provided for minigames are stored in the `main_board` folder.
Do not edit content in here when making your minigame, but feel free to use it.

`default_theme.tres` is a simple theme that styles Buttons and sets the font of Control nodes to a pixel font (`res://shared/assets/fonts/retro_pixel_cute_prop.ttf`.)
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
- Main Scene Path
   -  The relative path to the scene that will get loaded in when the minigame commences.
	Double-click on your minigame's `data.tres` in the Files and you should be able to edit these fields in the Inspector.
- Players
  - Number of players the minigame is for. Try making it work for 4!

You can test your minigame by going to the minigames menu from the title screen and clicking on your game.

# Party (globally available class)
### Attributes
`Party` is a class you can get the attributes from for anything you like. You can also change them if you really want.
`int playercount` - Number of players.
- Currently, the board only supports 4 players, but don't be discouraged from making 1, 2 or 3 player minigames. We're planning on making it a feature.
- (The `res://main_board/ui/template_ui/score_ui.tscn`component supports 1-4 players and will display differently if you set playercount.)

`Array[Color] PLAYER_COLOURS` - The colours of each player, using Godot's `Color` class.
- `Party.PLAYER_COLOURS[0]` Gives you the colour associated with Player **1**.
- If you set a Node2D's `modulate` attribute to this, it multiplies all its colour by that player's colour. Good for if you make your own components.

`Array[FaceData] player_faces` - The data for each player avatar's faces, using a custom type we've defined.
### Using Party to end the minigame/rankings
The function `Party.end_minigame()` expects an array of length 4, containing precisely the integers 0 to 3 in an order corresponding to player ranks.
The graphic below demonstrates what this is evaluated to.

![](main_board/sprites/ranks_guide.png)

Player 1 is the number 0 due to zero-indexing of arrays in GDScript.
Components like `res://main_board/ui/template_ui/score_ui.tscn` does the ranking for you based off the scores in there.

# Input system
We've predefined controller inputs for players 1-4, with player 1 having some keyboard keys associated too.
You can see these by going to Project > Project Settings > Input Map.
For every player *x*, there's:
- `px_left, px_right, px_up, px_down`: Left joystick input.
- `px_button_bottom, px_button_right, px_button_top, px_button_left`: Face buttons (eg: bottom button is A for Xbox, X for Playstation)

Godot has a system similar to fstrings in other languages, which is a good way to handle different players having different input names.
`"p%s_left" % str(player_number+1)` evaluates to "p1_left" when player_number is 0, so making 4 of the same node with different player_number values essentially makes 4 nodes that take the different player's input. This can be applied to player faces, too! That's what `res://shared/faces/player_visual_2d/player_visual_2d.tscn` does.