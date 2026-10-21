# DAGsoc party copatibility

Here is the checklist of what your mini-game needs to interface with our project.
If you use our
[minigame template](https://github.com/elf222/dagparty_minigame_template)
this is already implemented, in that case read the requierments and refer to this as docs

- Shared Resources and Logic
  - keymap
  - interface
  - assets
- Handoffs
  - data.tres
  - results
- Requierments and Suggested Workflows
  - main requierments
  - template
  - symlinks


## Shared Resources

### Keymap

For now the solution is for you to copy the keymap part from dag-soc party, unfortunately it is not symlinkable

- Open dag-soc party project.godot party in a text file
- It contains [application], [autoload], [display], [input], [physics], [rendering] parts
- Copy the [input] section to your game's [input] section
- Also, you can take the [input] section from the input_section.txt file in this folder

For testing you can add your own actions in

Project > Project Settings... > Input Map > +Add

This will make an action and you can add keys which activate it

Note: arrows p1 actions include keyboard arrows, all other actions set up only from gamepad

### Party

Party is a global that you need to mount

- mg_party_interface.gd is placed in "shared/" in dagsoc-party
- mount it as Party with Project > Project Settings... > Globals > Select Script/Scene

### Assets

``` GDScript
# Player data
Party.player_count
Party.player_faces
Party.PLAYER_COLOURS

# Results and validation
Party.end_minigame(rankings)
Party.check_rankings(rankings)
Party.minigame_finished.connect(_func)
Party.minigame_failed.connect(_func)

# Text
Party.text.measure(text, font_size)
Party.text.draw(self, text, position, font_size, colour)
Party.text.FONT
Party.text.DEFAULT_FONT_SIZE

# Face visuals
Party.faces.create(player_index)

# UI
Party.ui.create_score_ui()
Party.ui.theme
Party.ui.clock_texture

# Existing shader resource
Party.shaders.uv_glide
```

## Handoffs

Your game should have data.tres metadata file and submit player rankings

### data.tres

data.tres is a custom resource with minigame description and other metadata
Open this file in Godot to edit Title, How To Play, etc.

### Rankings submission

Finish your game with

``` GDScript
Party.end_minigame(rankings)
```

This sends DAGparty signal to take over and register player rankings. You can catch ot to draw custom stuff in standalone mode

Format an array rankings like [3, 0, 2, 1],
meaning:

p4 came 1st,
p1 - 2nd,
p3 - 3rd, 
p2 - 4th

IMPORTANT, the rankings array must be declared with the type, e.g.

``` GDScript
var rankings :Array[int]
```

inferred type array, even if filled with integers, will fail


## Requierments and Suggested Workflows

### Requirements

To make your minigame interface with DAGparty you just need:
1. Set up metadata with data.tres file
2. Give DAGParty your minigame's results
``` GDScript
Party.end_minigame(rankings)
```

Everythings else helps minigames fit stylistically, starting from player colours and chosen avatars to UI elements like timers and backgrounds

### Minigame template

We prepared a [minigame template on GitHub](https://github.com/elf222/dagparty_minigame_template) for you to use and example_counter in DAGParty showing more features

To get started:
- Make sure you have git and Godot 4.8 dev6-beta1 installed
- Navigate to the directory intended for DAGParty in the terminal/PowerShell
- Run the script to clone DAGparty and minigame_template
``` bash
git clone https://github.com/hryspider/dagsoc-party
git clone https://github.com/elf222/dagparty_minigame_template
```
You can use template repository as a template to your repository
- open dagsoc-party/project.godot to try out the party, dagparty_minigame_template/project.godot for the template investigation/developing your minigame

### Symlinks

When you work and test in both template and party projects you will need to sync shared/ to party's and mingames/<your-minigame> to template's respective folders.
You can do it by manually copying, but you might want to set up symlinks.

Symbolic links make files or folders available at another path.
This workflow uses two links:

1. Template's "shared/" link should point to Party's "shared/"
2. Party's "minigames/<your-minigame>/" - to the template's "minigames/<your-minigame>/"

#### macOS and Linux

1. In terminal navigate to the directory containing both cloned repositories
2. Run(with names changed apropriately):

```bash
ln -s "../dagsoc-party/shared" "dagparty_minigame_template/shared"
ln -s "../../dagparty_minigame_template/minigames/minigame_template" "dagsoc-party/minigames/minigame_template"
```

#### Windows

1. Open **Command Prompt (CMD) as Administrator**
2. Navigate to the directory containing both cloned repositories
3. Run(with names changed apropriately):

```bash
mklink /D "dagparty_minigame_template\shared" "..\dagsoc-party\shared"
mklink /D "dagsoc-party\minigames\minigame_template" "..\..\dagparty_minigame_template\minigames\minigame_template"
```