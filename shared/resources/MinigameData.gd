extends Resource
class_name MinigameData

# To make your own data, right-click in your folder, choose Create New > Resource > MinigameData.
# Name it data.tres and keep it at the top of your minigame folder.

@export var title := "Minigame Title"
@export var author := "DAGsoc"
@export var how_to_play := "This is sample text. It might tell you how to play."
@export_file("*.tscn") var main_scene_path := ""
@export var thumbnail : Texture2D
@export_range(1,4) var players := 4
