extends Control

@onready var h_box_container = $HBoxContainer
@onready var continue_prompt = $"Continue Prompt"
@onready var player_visual = $"Player Visual"

func _ready():
	var winner = Global.player_positions.find(Global.player_positions.max())
	player_visual.player_number = winner


func _on_timer_timeout():
	continue_prompt.show()

func _input(event):
	if continue_prompt.visible and (event.is_action_pressed("p1_button_bottom") or event.is_action_pressed("ui_accept")):
		Global.reset()
		Transition.transition_to("res://main_board/rooms/title.tscn")
