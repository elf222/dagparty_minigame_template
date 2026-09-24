# DAGsoc party copatibility

Here is the checklist of what your mini-game needs to interface with our project.
If you use our template this is already implemented unless stated otherwise, use it as docs

- inputs
  - data.tres
  - keymap
  - globals
- outputs
  - results

## Inputs

### data.tres

change to your game's name and other customisable fields

### Keymap

For now the solution is for you to copy the keymap part from dag-soc party:

- Open dag-soc party project.godot party in a text file
- It contains [application], [autoload], [display], [input], [physics], [rendering] parts
- Copy the [input] section to your game's [input] section
- Also, you can take the [input] section from the input_section.txt file in this folder

For testing you can add your own actions in

Project > Project Settings... > Input Map > +Add

This will make an action and you can add keys which activate it

### Globals

You need to mount global.gd file to your project for testing

- global.gd is placed in this folder and in "/main_board/global/global.gd" in dagsoc-party
- make sure there is a copy of it in your project
- mount as Global with Project > Project Settings... > Globals > Select Script/Scene

## Outputs

Set Global.rankings to an array like [3, 0, 2, 1], meaning 1st player came fourth, 2nd - 1st, 3rd - 3rd, 4th - second

<!-- other things ton properly finish the game -->
