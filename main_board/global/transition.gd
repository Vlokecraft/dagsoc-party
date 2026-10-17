extends Control

var destination = ""

func transition_to(path:String):
	destination = path
	$AnimationPlayer.play("transition")

func _change_scene():
	get_tree().change_scene_to_file(destination)
	get_tree().paused = false
