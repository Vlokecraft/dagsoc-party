extends Node2D

@export_range(0, 3) var player_number : int
signal player_increase(player, amount)

func _ready():
	$"Player Visual".player_number = player_number

func _process(delta):
	scale = scale.lerp(Vector2.ONE, 0.1)
	if Input.is_action_just_pressed("p%s_button_bottom" % str(player_number+1)):
		scale = Vector2.ONE *1.2
		emit_signal("player_increase", player_number, 1)
