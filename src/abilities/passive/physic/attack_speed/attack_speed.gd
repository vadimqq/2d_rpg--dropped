extends Base_ability

var attack_spped = 10

func _init():
	type = CONSTANTS.ABILITY_TYPE_ENUM.PASSIVE
	price = 10
	max_lvl = 5
	element = "physic"

func apply_buff(s: Base_body):
	var value = s.STATS.get_percent_attack_speed(attack_spped)
	s.STATS.modify_attack_speed(value)

func reset_buff(s: Base_body):
	var value = s.STATS.get_percent_attack_speed(attack_spped)
	s.STATS.modify_attack_speed(-value)

func _on_attack_speed_upgrade(s: Base_body, new_lvl):
	match new_lvl:
		1:
			apply_buff(s)
		2:
			reset_buff(s)
			attack_spped = 11
			price = 30
			apply_buff(s)
		3: 
			reset_buff(s)
			attack_spped = 12
			price = 40
			apply_buff(s)
		4: 
			reset_buff(s)
			attack_spped = 13
			price = 40
			apply_buff(s)
		5: 
			reset_buff(s)
			attack_spped = 15
			price = 40
			apply_buff(s)
	lvl = new_lvl
