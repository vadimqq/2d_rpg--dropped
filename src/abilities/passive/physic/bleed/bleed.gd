extends Base_ability

var percent = 10

func _init():
	type = CONSTANTS.ABILITY_TYPE_ENUM.PASSIVE
	price = 10
	max_lvl = 5
	element = "physic"

func apply_buff(s: Base_body):
	s.STATS.modify_bleed_chance(percent)

func reset_buff(s: Base_body):
	s.STATS.modify_bleed_chance(-percent)

func _on_bleed_upgrade(s: Base_body, new_lvl):
		match new_lvl:
			1:
				apply_buff(s)
			2:
				reset_buff(s)
				percent = 11
				price = 30
				apply_buff(s)
			3: 
				reset_buff(s)
				percent = 12
				price = 40
				apply_buff(s)
			4: 
				reset_buff(s)
				percent = 13
				price = 40
				apply_buff(s)
			5: 
				reset_buff(s)
				percent = 50
				price = 40
				apply_buff(s)
		lvl = new_lvl
