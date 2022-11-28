extends Base_NPC



func _process(delta):
	if Input.is_action_pressed("action") && in_range:
		GAME_CORE.level_master.show()
