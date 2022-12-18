extends Base_ability

var percent = 100

func _init():
	type = CONSTANTS.ABILITY_TYPE_ENUM.PASSIVE
	max_lvl = 5
	element = "physic"

func apply_buff(s: Base_body):
	s.STATS.apply_buff({
		"CHANCE_BLEED": percent
	})

func _on_bleed_upgrade(s: Base_body, new_lvl):
		match new_lvl:
			1:
				apply_buff(s)
			2:
				percent = 2
				apply_buff(s)
			3: 
				percent = 2
				apply_buff(s)
			4: 
				percent = 2
				price = 40
				apply_buff(s)
			5: 
				percent = 2
				apply_buff(s)
		lvl = new_lvl
