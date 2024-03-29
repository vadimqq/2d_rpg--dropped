extends Base_weapon

onready var animation = $Animation

func _init():
	tags = [CONSTANTS.WEAPON_TYPES.BOW]
	weapon_name = 'bow'

func _ready():
	base_ability = GAME_CORE.player.ability_list.get_node("arrow_shot")
	attack_range = 100

func _on_Bow_use_weapon_ability():
	animation.playback_speed = owner_body.STATS.get_attack_speed()
	animation.play("attack")

func weapon_ability():
	base_ability.execute(owner_body, spawn_position.global_transform)

func get_base_ability_mana_cost():
	return base_ability.mana_cost

func _on_Bow_use_in_hand():
	animation.play("in_hand")

func _on_Bow_use_sheath():
	animation.play("sheath")
