extends Base_weapon

onready var animation = $Animation

onready var fireball_shot: Base_ability = $Base_ability_slot/fireball_shot

func _init():
	tags = [CONSTANTS.WEAPON_TYPES.BOW]
	weapon_name = 'bow'

func _ready():
	attack_range = 100

func _process(delta):
	var pos = global_position - get_global_mouse_position()
	if !in_sheath && pos.x > 0:
		scale.y = -1
	else:
		scale.y = 1

func weapon_ability():
	fireball_shot.execute(owner_body, spawn_position.global_transform)

func get_base_ability_mana_cost():
	return fireball_shot.mana_cost

func _on_staff_use_in_hand():
	animation.play("in_hand")

func _on_staff_use_sheath():
	animation.play("sheath")

func _on_staff_use_weapon_ability():
	animation.playback_speed = owner_body.STATS.get_attack_speed()
	animation.play("attack")
