extends Control

#Head: Color
#Eyes: Style, Position
#Nose: Style, Position
#Mouth: Style, Position
@onready var pixelarrow_left = $Label/Container/Pixelarrow
@onready var pixelarrow_right = $Label/Container/Pixelarrow2

var settings = [
	"Eye Type",
	"Eye Separation",
	"Eye Height",
	"Nose Type",
	"Nose Height",
	"Mouth Type",
	"Mouth Height"
]
var data : FaceData:
	set(value):
		data = value
		Global.player_faces[player] = data
		$Control/Head.data = data

var selected_setting = 0:
	set(value):
		selected_setting = posmod(value, len(settings))
		$Label.text = settings[selected_setting]
		$Below.text = settings[posmod(value+1, len(settings))]
		$Above.text = settings[posmod(value-1, len(settings))]
var timer = 0

@export var player = -1:
	set(value):
		player = value
		$Player.text = "Player %s" % str(value+1)
		$Player.set("theme_override_colors/font_outline_color", (Party.PLAYER_COLOURS[value]).blend(Color(0.0, 0.0, 0.0, 0.702)))
		$Control/Head.player_number = player
		data = Global.player_faces[player]

func _ready():
	data = Global.player_faces[player]
	timer = randf_range(0, 3)

func _process(delta):
	timer += delta
	pixelarrow_left.offset_transform_position.x = sin(timer*6)*3
	pixelarrow_right.offset_transform_position.x = -sin(timer*6)*3
	var left = Input.is_action_just_pressed("p%s_left" % str(player+1))
	var right = Input.is_action_just_pressed("p%s_right" % str(player+1))
	var up = Input.is_action_just_pressed("p%s_up" % str(player+1))
	var down = Input.is_action_just_pressed("p%s_down" % str(player+1))
	var left_right = int(right) - int(left)
	selected_setting += int(down)-int(up)
	if left or right:
		print(selected_setting)
		match selected_setting:
			0: data.eye_type += left_right
			1: data.eye_position.x += left_right
			2: data.eye_position.y -= left_right
			3: data.nose_type += left_right
			4: data.nose_pos -= left_right
			5: data.mouth_type += left_right
			6: data.mouth_pos -= left_right
			
		data = data
