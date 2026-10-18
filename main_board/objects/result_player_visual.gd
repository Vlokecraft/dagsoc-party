extends VBoxContainer
const BRONZEDIE = preload("uid://buyd7j66d203e")
const GOLDDIE = preload("uid://dph1bb4cq26w4")
const REGULARDIE = preload("uid://suu33xpc6pki")
const SILVERDIE = preload("uid://bqeq5d8sqox83")

@export var place = 0
		
var player = 0
		

@onready var timer = randf()

func _ready():
	$"Control/Player Visual".player_number = player
	$"Control/Player Visual".data = Global.player_faces[player]
	$PlayerLabel.text = "Player %s" % str(player+1)
	match place:
		0:
			$Label.text = "1st"
			$"Control/Player Visual/Extra Die".texture = GOLDDIE
		1:
			$Label.text = "2nd"
			$"Control/Player Visual/Extra Die".texture = SILVERDIE
		2:
			$Label.text = "3rd"
			$"Control/Player Visual/Extra Die".texture = BRONZEDIE
		3:
			$Label.text = "4th"
			$"Control/Player Visual/Extra Die".hide()
			

func _process(delta):
	timer += delta
	$"Control/Player Visual/Main Die".position.y = -68 + sin(timer*3)*5
	$"Control/Player Visual/Extra Die".position.y = -120 + sin(0.5+timer*3)*5
	$"Control/Player Visual/Main Die".rotation = sin(timer*1.5)*0.1
	$"Control/Player Visual/Extra Die".rotation = sin(0.5+timer*1.5)*-0.1
