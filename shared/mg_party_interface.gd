extends Node

var player_count :int = 4

const PLAYER_COLOURS = [
	Color("F27C6F"),
	Color("28AAD4"),
	Color("F8FF57"),
	Color("523FB0")
]
var player_faces :Array[FaceData] = [FaceData.new(), FaceData.new(), FaceData.new(), FaceData.new()]


signal minigame_finished(rankings: Array[int])
signal minigame_failed(rankings: Array[int])

# REFACTOR: new function
func check_rankings(ranks : Array[int]) -> bool:
	if len(ranks) != player_count:
		printerr("Rankings length %s does not match player count %s" % [len(ranks), player_count])
		return false
	
	var seen = []
	for i in ranks:
		if i in seen:
			printerr("Rankings have a duplicate %s" % [ranks])
			return false
		if i < 0 or i > 3:
			printerr("Rankings rankings contain invalid players %s" % [ranks])
			return false
		seen.append(i)

	return true

# ranks[place] -> player_index, with the winner first
# Example: [2, 0, 1, 3] means Players 3, 1, 2, 4 finished in that order
func end_minigame(ranks : Array[int]):
	if check_rankings(ranks):
		minigame_finished.emit(ranks.duplicate())
	else:
		minigame_failed.emit(ranks.duplicate())
