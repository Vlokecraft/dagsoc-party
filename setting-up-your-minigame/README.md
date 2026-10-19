# DAGsoc party copatibility

Here is the checklist of what your mini-game needs to interface with our project.
If you use our template this is already implemented, unless stated otherwise, in that case refer to this as docs

- inputs
  - data.tres
  - keymap
  - globals
- outputs
  - results

## Inputs

### data.tres

change to your game's name and other customisable fields

don't touch things before [resource]

in [resource]
- don't touch script
- set title
- set author
- explain how to play
- specify

### Keymap

For now the solution is for you to copy the keymap part from dag-soc party:

- Open dag-soc party project.godot party in a text file
- It contains [application], [autoload], [display], [input], [physics], [rendering] parts
- Copy the [input] section to your game's [input] section
- Also, you can take the [input] section from the input_section.txt file in this folder

For testing you can add your own actions in

Project > Project Settings... > Input Map > +Add

This will make an action and you can add keys which activate it

Note: arrows p1 actions include keyboard arrows, all other actions set up only from gamepad

### Globals

You need to mount global.gd file to your project for testing

- global.gd is placed in this folder and in "shared/mg-party-interface/" in dagsoc-party
- mount as Global respectively with Project > Project Settings... > Globals > Select Script/Scene



## Outputs

Format an array rankings like [3, 0, 2, 1],
meaning:

p4 came 1st,
p1 - 2nd,
p2 - 3rd, 
p3 - 4th

with Global.end_minigame(rankings), this will close your game in dagsoc party


<!-- other things to properly finish the game -->
