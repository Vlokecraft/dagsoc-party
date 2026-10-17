extends Sprite2D


var data : FaceData:
	set(value):
		data = value
		if get_child_count() > 0:
			$Eyes.frame = data.eye_type
			$Eyes2.position = Vector2i(14, -14) + data.eye_position*2
			$Eyes.position = $Eyes2.position * Vector2(-1, 1)
			$Eyes2.frame = data.eye_type
			$Noses.frame = data.nose_type
			$Mouths.frame = data.mouth_type
			$Noses.position.y = data.nose_pos*2
			$Mouths.position.y = data.mouth_pos*2

@export_range(0, 3) var player_number : int:
	set(value):
		player_number = value
		data = Global.player_faces[value]
		self_modulate = Interface.PLAYER_COLOURS[value]
		

func _ready():
	player_number = player_number

var timer = 0.0
func _process(delta):
	timer += delta
	frame = posmod(timer*4, 3)
