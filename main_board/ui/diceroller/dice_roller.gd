extends Node3D

@onready var output = $Output
@onready var static_body_3d = $StaticBody3D

const SPACING = 10
var result = 0
var dice_waiting_on
var rolled = false
var action:="ui_accept"
var die_list #: Array[Die]
var die_nodes = []

signal finished(val)

func run():
	result = 0
	rolled = true
	var length = len(die_list)
	dice_waiting_on = length
	var pos = (0.5-length*0.5) *SPACING
	for i in die_list:
		static_body_3d.add_child(i)
		i.dice_output.connect(add_to_result, 1)
		i.initial_pos = Vector3(pos, 3, 0)
		i.position = i.initial_pos
		pos += SPACING
		die_nodes.append(i)
	rolled = false
	
		

func _input(event):
	if Input.is_action_just_pressed(action) and not rolled and die_list:
		rolled = true
		for i in die_list:
			i.trigger()
			await get_tree().create_timer(0.1).timeout

func add_to_result(val):
	result += val
	dice_waiting_on -= 1
	output.text = str(result)
	if dice_waiting_on == 0:
		await get_tree().create_timer(1).timeout
		while len(die_nodes) > 0:
			die_nodes.pop_back().queue_free()
		await get_tree().create_timer(1).timeout
		emit_signal("finished", result)
		output.text = ""
		
