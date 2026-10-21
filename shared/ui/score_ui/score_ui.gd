extends Control
const SCORE_UI_PLAYER_COMPONENT = preload("uid://b5qb0ruw5uwt7")

signal game_start()
signal time_up()

@export var start_countdown_enabled = true
@export var timer_enabled = true
@export var timer_initial_value = 60.0
@export var end_minigame_handled = true
@onready var time = timer_initial_value:
	set(value):
		time = value
		$TimerUI/TimeLeftLabel.text = str(ceili(time))

var waiting = false

var player_score_nodes = []
var scores = [0,0,0,0]:
	set(value):
		scores = value
		for i in range(Party.player_count):
			player_score_nodes[i].set_score(scores[i])

func _ready():
	time = time
	for i in range(Party.player_count):
		var inst = SCORE_UI_PLAYER_COMPONENT.instantiate()
		$HBoxContainer.add_child(inst)
		inst.set_player(i)
		player_score_nodes.append(inst)
	waiting = true
	get_tree().paused = true
	if start_countdown_enabled:
		$AnimationPlayer.play("intro_countdown")
	else:
		start()
	$TimerUI.visible = timer_enabled

func set_score(player, value):
	#set_score(0,10) sets player 1's score to 10.
	scores[player] = value
	scores = scores

func increase_score(player, increase):
	scores[player] = scores[player] + increase
	scores = scores

func get_score(player):
	return scores[player]

func _process(delta):
	#if Input.is_action_just_pressed("ui_accept"): #Just here for debug!
		#var player = randi_range(0,3)
		#increase_score(player, 1)
	if timer_enabled and not waiting:
		if time < 0:
			emit_signal("time_up")
			if end_minigame_handled: finished()
			waiting = true
		else:
			time -= delta

func start():
	emit_signal("game_start")
	get_tree().paused = false
	waiting = false

func finished():
	get_tree().paused = true
	$AnimationPlayer.play("time_up")
	await $AnimationPlayer.animation_finished
	var zipped = []
	for i in range(Party.player_count):
		zipped.append([scores[i], i])
	zipped.sort()
	var results: Array[int] = []
	for i in zipped:
		results.append(i[1])
	results.reverse()
	Party.end_minigame(results)
#func get_first(a):
	#return a[0]
