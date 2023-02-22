extends Item_with_popup

class_name Ability_scroll

onready var particle: Particles2D = $Particles2D
onready var ability: Base_ability = GAME_CORE.player.ability_list.find_node(id)

var normal_pool := []
var magic_pool := []
var rare_pool := []
var legendary_pool := []
var unic_pool := []

var scroll_rarity_weights := {
	"normal_pool": 60,
	"magic_pool": 27,
	"rare_pool": 9,
	"legendary_pool": 3,
	"unic_pool": 1
}

var current_upgrade = null

var rarity_color: Dictionary = {
	CONSTANTS.SCROLL_RARITY_ENUM.NORMAL: Color(0.482353, 0.482353, 0.482353),
	CONSTANTS.SCROLL_RARITY_ENUM.MAGIC: Color(0.015686, 0.407843, 0.752941),
	CONSTANTS.SCROLL_RARITY_ENUM.RARE: Color(0.603922, 0.686275, 0.035294),
	CONSTANTS.SCROLL_RARITY_ENUM.LEGENDARY: Color(1, 0.560784, 0),
}

func set_rarity_color(rarity):
	particle.process_material.color = rarity_color[rarity]

func get_random_upgrade():
	var current_pool
	
	randomize()
	var rarity_roll = randi()% 100 + 1
	for rarity in scroll_rarity_weights.keys():
		if rarity_roll <= scroll_rarity_weights[rarity]:
			current_pool = self[rarity]
			break
		else:
			rarity_roll -= scroll_rarity_weights[rarity]
	
	return current_pool[randi() % current_pool.size()]
