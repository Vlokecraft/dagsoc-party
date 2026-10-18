extends Control
@onready var bg = $Bg
@onready var title = $HBoxContainer/VBoxContainer/Title
@onready var author = $HBoxContainer/VBoxContainer/Author
@onready var directory = $HBoxContainer/VBoxContainer/Directory
@onready var scene = $HBoxContainer/VBoxContainer/Scene
@onready var how_to_play = $HBoxContainer/ScrollContainer/Description
var hovered = false

var data : MinigameData:
	set(value):
		data = value
		title.text = value.title
		author.text = "by %s" % value.author
		scene.text = "Loads up %s" % value.main_scene_path
		how_to_play.text = value.how_to_play



func _input(event):
	if hovered and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Global.sync_faces_to_interface()
		Transition.transition_to(data.main_scene_path)

func _ready():
	bg.modulate = Color.GRAY

func _on_mouse_entered():
	bg.modulate = Color.WHITE
	hovered = true


func _on_mouse_exited():
	bg.modulate = Color.GRAY
	hovered = false
