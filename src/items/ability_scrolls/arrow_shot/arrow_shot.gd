extends Ability_scroll

signal upgrade_count_projectile
signal gain_damage
signal add_rebound_count
signal add_pierce_count
signal add_projectile_speed

func _ready():
	normal_pool = ["gain_damage"]
	magic_pool = ["add_projectile_speed" ]
	rare_pool = ["add_rebound_count", "add_pierce_count"]
	legendary_pool = ["upgrade_count_projectile"]
	unic_pool = ["upgrade_count_projectile"]
	current_upgrade = get_random_upgrade()
	item_name = upgrades_info[current_upgrade].name
	description = upgrades_info[current_upgrade].description
	set_rarity_color(upgrades_info[current_upgrade].rarity)

func _on_arrow_shot_take_ability_scroll():
	emit_signal(current_upgrade)

func _on_arrow_shot_upgrade_count_projectile():
	ability.projectile_count += 1

func _on_arrow_shot_add_pierce_count():
	ability.count_pierce += 1

func _on_arrow_shot_add_rebound_count():
	ability.count_rebound += 1

func _on_arrow_shot_gain_damage():
	ability.damage_incounter += 5

func _on_arrow_shot_add_projectile_speed():
	pass # Replace with function body.


var upgrades_info: Dictionary = {
	"upgrade_count_projectile": {
		"name": "Upgrade count projectile",
		"description": "arrow shot add 1 additional projectile",
		"rarity": CONSTANTS.SCROLL_RARITY_ENUM.LEGENDARY
	},
	"gain_damage": {
		"name": "Hardened arrows",
		"description": "Increace arrow shot damage by 5%",
		"rarity": CONSTANTS.SCROLL_RARITY_ENUM.NORMAL
	},
	"add_rebound_count": {
		"name": "Rebound arrows",
		"description": "The arrow can bounce off the wall 1 more time",
		"rarity": CONSTANTS.SCROLL_RARITY_ENUM.RARE
	},
	"add_pierce_count": {
		"name": "Piercing arrows",
		"description": "Arrows pierce 1 more enemy",
		"rarity": CONSTANTS.SCROLL_RARITY_ENUM.RARE
	},
	"add_projectile_speed": {
		"name": "Powerful shot",
		"description": "Speeds up the flight of arrows by 10 units",
		"rarity": CONSTANTS.SCROLL_RARITY_ENUM.MAGIC
	},
}
