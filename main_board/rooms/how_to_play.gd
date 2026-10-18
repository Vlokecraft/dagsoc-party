extends Control
@onready var title_label = $TitleLabel
@onready var author_label = $AuthorLabel
@onready var instructions_label = $InstructionsLabel
@onready var continue_prompt = $"Continue Prompt"
@onready var thumbnail_texture = $ThumbnailTexture

func _ready():
	randomize()
	if Global.selected_minigame == null:
		Global.selected_minigame = Global.load_minigames().pick_random()
	title_label.text = Global.selected_minigame.title
	author_label.text = "by %s" % Global.selected_minigame.author
	instructions_label.text = Global.selected_minigame.how_to_play
	thumbnail_texture.texture = Global.selected_minigame.thumbnail

func _on_timer_timeout():
	continue_prompt.show()

func _input(event):
	if continue_prompt.visible and (event.is_action_pressed("p1_button_bottom") or event.is_action_pressed("ui_accept")):
		Global.sync_faces_to_interface()
		Transition.transition_to(Global.selected_minigame.main_scene_path)
