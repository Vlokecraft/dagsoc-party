extends Node
const SPACE = preload("uid://bg4yj0u1mh8ic")
const MOVE_SPACE = preload("uid://rlpqpdee7cfq")
const DICE_ROLLER = preload("uid://opq7dn6lagp")
const GOLD_DIE = preload("uid://d206keu1oibo4")
const SILVER_DIE = preload("uid://bfxbr3abr5o46")
const REGULAR_DIE = preload("uid://dll1k7kmi8sn0")
const BRONZE_DIE = preload("uid://qdg7m3leedrp")

@onready var camera_3d = $Path3D/PathFollow3D/Camera3D
@onready var dice_roller = $Path3D/PathFollow3D/DiceRoller
@onready var path_follow_3d = $Path3D/PathFollow3D
@onready var turn_label = $Control/Control/TurnLabel
@onready var round_label = $Control/Control/RoundLabel
@onready var order_number_label = $Control/Control/OrderNumberLabel
@onready var new_round_label = $Control/Control/RoundScreen/NewRoundLabel
@onready var animation_player = $AnimationPlayer

@onready var players = [
	$PlayerPiece,
	$PlayerPiece2,
	$PlayerPiece3,
	$PlayerPiece4
]

@export var string_data: String
@export var path : Path3D

var space_positions : Array[Vector3] = []


func _ready():
	Global.player_turn = Global.rankings[0]
	var still_turns_left = true
	add_spaces_from_str(string_data)
	for i in range(4):
		players[i].position = space_positions[Global.player_positions[i]]+players[i].offset
		
	if Global.round == 0: still_turns_left = false
	while still_turns_left:
		order_number_label.text = get_order_text()
		turn_label.text = "Player %s's turn" % str(Global.player_turn+1)
		turn_label.modulate = Interface.PLAYER_COLOURS[Global.player_turn]
		round_label.text = "Round %s" % str(Global.round)
		path_follow_3d.target = players[Global.player_turn]
		await get_tree().create_timer(0.3).timeout
		print(Global.player_turn)
		var result = await roll_dice()
		var current_pos = Global.player_positions[Global.player_turn]
		var target_pos = current_pos + result
		if result > 0:
			print("player jumps to pos " + str(target_pos))
			await players[Global.player_turn].jump_to_places(space_positions.slice(current_pos, target_pos+1))
		Global.player_positions[Global.player_turn] = target_pos
		still_turns_left = Global.next_turn()
		await get_tree().create_timer(0.5).timeout
	Global.round += 1
	new_round_label.text = "Now starting... Round %s" % str(Global.round)
	animation_player.play("newround")

func add_spaces_from_str(string):
	var i = 0
	var negative = false
	for s in string:
		var space_inst
		if s == "-":
			negative = true
			continue
		if int(s) != 0:
			space_inst = MOVE_SPACE.instantiate()
			if negative:
				space_inst.set_amount(-int(s))
			else:
				space_inst.set_amount(int(s))
		else:
			space_inst = SPACE.instantiate()
		#match s:
			#"m":
				#data = MinigameSpace.new()
			#"v":
				#data = VictorySpace.new()
				
		space_inst.transform = path.curve.sample_baked_with_rotation(i*8)
		space_inst.rotation *= Vector3(1, 0, 0)
		i += 1
		add_child(space_inst)
		space_positions.append(space_inst.position)
func roll_dice():
	dice_roller.die_list = [REGULAR_DIE.instantiate()]
	match Global.rankings.get(Global.player_turn):
		0: dice_roller.die_list.append(GOLD_DIE.instantiate())
		1: dice_roller.die_list.append(SILVER_DIE.instantiate())
		2: dice_roller.die_list.append(BRONZE_DIE.instantiate())
	dice_roller.action = "p%s_button_bottom" % str(Global.player_turn + 1)
	dice_roller.action = "ui_accept"
	dice_roller.run()
	
	dice_roller.global_rotation.y = camera_3d.global_rotation.y
	var result = await dice_roller.finished
	return result
	
func get_order_text():
	var output = ""
	for i in Global.rankings:
		if Global.player_turn == i:
			output += "[wave amp=100.0]"
		output += "[color=#%s]%s[/color] " % [Interface.PLAYER_COLOURS[i].to_html(), str(i+1)]
		if Global.player_turn == i:
			output += "[/wave]"
	return output
	
func new_round_logic():
	Transition.transition_to("res://main_board/rooms/how_to_play.tscn")
