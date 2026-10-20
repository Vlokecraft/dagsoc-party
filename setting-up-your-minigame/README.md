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

### Interface

Interface is a global that you need to mount

- mg-party-interface.gd is placed in "shared/" in dagsoc-party
- mount it as Interface with Project > Project Settings... > Globals > Select Script/Scene

### Assets




## Handoffs

Your game should have data.tres metadata file and submit player rankings

### data.tres / metadata

change to your game's name and other customisable fields

don't touch things before [resource]

in [resource]
- do not touch script
- set title
- set author
- explain how to play
- specify main scene path


### Rankings submission

Finish your game with

``` GDScript
Interface.end_minigame(rankings)
```

This sends DAGparty signal to take over and register player rankings.

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
Interface.end_minigame(rankings)
```

Everythings else helps minigames fit stylistically, starting from player colours and chosen avatars to UI elements like timers and backgrounds

### Minigame template

We prepared a [minigame template on GitHub](https://github.com/elf222/dagparty_minigame_template) for you to use and example_counter in DAGParty showing more features

To get started:
- Make sure you have git and Godot 4.8 dev6-beta1 installed
- Navigate to the directory intended for DAGParty in the terminal/PowerShell
- Run the script to clone DAGparty and minigame-template
``` bash
git clone https://github.com/hryspider/dagsoc-party
git clone https://github.com/elf222/dagparty_minigame_template
```
- open dagsoc-party/project.godot for trying out party, dagparty_minigame_template/project.godot

### Symlinks
