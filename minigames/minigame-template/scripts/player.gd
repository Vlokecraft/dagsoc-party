extends Node2D

const SharedText = preload("res://shared/drawing/text.gd")
const CIRCLE_RADIUS: float = 42.0

var _player_number :int = 0
var _player_colour :Color = Color.WHITE


func setup(new_player_number: int, new_player_colour: Color) -> void:
	_player_number = new_player_number
	_player_colour = new_player_colour
	queue_redraw()


func _draw() -> void:
	draw_circle(Vector2.ZERO, CIRCLE_RADIUS, _player_colour)
	draw_arc(Vector2.ZERO, CIRCLE_RADIUS, 0.0, TAU, 48, Color.WHITE, 3.0, true)
	
	var player_text :String = "P%d" % _player_number
	var font_size :int = 25
	var text_size :Vector2 = SharedText.measure_text(player_text, font_size)
	var text_position :Vector2 = Vector2(-text_size.x * 0.5, text_size.y * 0.35)
	
	SharedText.draw_text(self, player_text, text_position, font_size, Color.BLACK)
