extends VBoxContainer

func set_score(value):
	$Label.text = str((int)(value))

func set_player(number):
	$PlayerNameLabel.text = "Player %s" % str(number+1)
	$PlayerNameLabel.modulate = Interface.PLAYER_COLOURS[number].lerp(Color.WHITE, 0.5)
	$Label/ColorRect.modulate = Interface.PLAYER_COLOURS[number].lerp(Color(0, 0, 0, 0), 0.5)
