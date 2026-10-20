extends Node

# REFACTOR: copy to shared
var player_count :int = 4

# REFACTOR: copy to shared
var player_faces :Array[FaceData] = [FaceData.new(), FaceData.new(), FaceData.new(), FaceData.new()]
# REFACTOR: no
var player_positions = [0,0,0,0]

var player_turn = 0 # eg: 0 means it's player 1's turn
var round = 0

func _ready() -> void:
	Interface.minigame_finished.connect(end_minigame)

func sync_faces_to_interface() -> void:
	if player_faces.size() != player_count:
		printerr("Expected one face per player slot (%s)." % player_count)
		return

	var faces: Array[FaceData] = []
	for face in player_faces:
		if face == null:
			printerr("Player faces cannot be null.")
			return
		faces.append(face.copy())
	Interface.player_faces = faces
func reset():
	player_turn = 0
	round = 0
	player_positions = [0,0,0,0]
	rankings = [0,1,2,3]
	selected_minigame = null

func next_turn():
	var pos = rankings.find(player_turn)
	print("pos is %s" % str(pos))
	if pos >= 3 or pos < 0:
		return false
	player_turn = rankings[pos+1]
	return true	

var rankings : Array[int]= [0,1,2,3] # Must be set using set_rankings when a minigame ends.
var selected_minigame : MinigameData

func load_minigames():
	var result = []
	var minigame_dirs = DirAccess.get_directories_at("res://minigames/")
	var load_failed_dirs = []
	for i in minigame_dirs:
		var dir = "res://minigames/" + i
		var files = DirAccess.get_files_at(dir)
		var data = null
		if files.has("data.tres"):
			data = load(dir + "/data.tres")
			if data is MinigameData:
				result.append(data)
			else:
				printerr("Error loading Minigame Data from %s: data.tres is not a MinigameData Resource." % i)
				data = null
		else:
			printerr("Error loading Minigame Data from %s: data.tres not found." % i)
			print("!!! Your minigame needs a data.tres MinigameData resource file to load.")
		if data == null:
			load_failed_dirs.append(i)
	return result


# REFACTOR: move to shared, make failures not silent
func set_rankings(ranks : Array[int]):
	rankings = []
	if Interface.check_rankings(ranks):
		rankings = ranks.duplicate()

# REFACTOR: connect via signals, maybe move to Transition
func end_minigame(ranks):
	set_rankings(ranks)
	Transition.transition_to("res://main_board/rooms/results.tscn")
