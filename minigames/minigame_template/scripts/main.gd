extends Node2D

const PlayerScript = preload("player.gd")

@onready var slot_markers :Array[Marker2D] = [
	$PlayerSlots/Slot1,
	$PlayerSlots/Slot2,
	$PlayerSlots/Slot3,
	$PlayerSlots/Slot4,
]
@onready var round_timer :Timer = $RoundTimer/Timer
@onready var timer_label :Label = $RoundTimer/Label

var PLAYER_COUNT :int = Party.player_count
const TIME_LIMIT_SECONDS :float = 10.0
const TIME_PLAYER_SWITCH_ANIMATION_SECONDS :float = 0.15

const SLOT_ACTIONS :Array[String] = ["left", "up", "right", "down"]

var player_scene :PackedScene
var players :Array[PlayerScript] = []
var movement_tweens :Array[Tween] = []
var rankings :Array[int] = []

# -------------------------------------
# Godot callbacks
# -------------------------------------

func _ready() -> void:
	var minigame_directory :String = scene_file_path.get_base_dir() # necessary if you load scenes
	var player_scene_path :String = minigame_directory.path_join("player.tscn") # necessary if you load scenes

	player_scene = load(player_scene_path) as PackedScene

	_create_players()
	round_timer.wait_time = TIME_LIMIT_SECONDS
	round_timer.timeout.connect(_on_round_timer_timeout)
	round_timer.start()

func _process(_delta :float) -> void:
	if round_timer.is_stopped():
		return
	timer_label.text = "Time: %.1f" % round_timer.time_left
	_check_player_input()

# -------------------------------------
# Setup functions
# -------------------------------------

func _create_player(player_index: int) -> void:
	var player :PlayerScript = player_scene.instantiate()
	var player_colour :Color= Party.PLAYER_COLOURS[player_index]

	rankings.append(player_index)
	
	player.setup(player_index + 1, player_colour)
	player.position = slot_markers[player_index].position
	players.append(player)
	
	add_child(player)
	
func _create_players() -> void:
	movement_tweens.resize(PLAYER_COUNT)
	for player_index: int in range(PLAYER_COUNT):
		_create_player(player_index)

# -------------------------------------
# Logic and animations
# -------------------------------------

func _animation_move_player(player_index: int, destination: Vector2) -> void:
	var old_tween :Tween = movement_tweens[player_index]
	if old_tween != null and old_tween.is_valid():
		old_tween.kill()

	var player :PlayerScript = players[player_index]
	var movement_tween :Tween = create_tween()
	
	movement_tween.set_trans(Tween.TRANS_QUAD)
	movement_tween.set_ease(Tween.EASE_OUT)
	movement_tween.tween_property(player, "position", destination, TIME_PLAYER_SWITCH_ANIMATION_SECONDS)
	movement_tweens[player_index] = movement_tween

func _swap_players(player_index: int, target_player_index: int) -> void:
	if player_index == target_player_index:
		return
		
	var player_slot :int = rankings.find(player_index)
	var target_player_slot :int = rankings.find(target_player_index)
	
	rankings[player_slot] = target_player_index
	rankings[target_player_slot] = player_index
	
	_animation_move_player(player_index, slot_markers[target_player_slot].position)
	_animation_move_player(target_player_index, slot_markers[player_slot].position)

func _check_player_input() -> void:
	for player_index: int in range(PLAYER_COUNT):
		for target_player_index: int in range(PLAYER_COUNT):
			var action_name :String = "p%d_%s" % [player_index + 1, SLOT_ACTIONS[target_player_index]]
			if Input.is_action_just_pressed(action_name):
				_swap_players(player_index, target_player_index)


# -------------------------------------
# Game end
# -------------------------------------

func _on_round_timer_timeout() -> void:
	timer_label.text = "Time's up!"
	await get_tree().create_timer(2.0).timeout
	# rankings[place] -> player;
	Party.end_minigame(rankings.duplicate())
