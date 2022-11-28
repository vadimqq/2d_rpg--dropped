extends Base_weapon

onready var animation = $Animation

#var sword_slash = SKILL_MANAGER.load_ability(self, "sword_slash")

func _init():
	tags = [CONSTANTS.WEAPON_TYPES.SWORD]
	weapon_name = 'sword'

func _ready():
	attack_range = 30
	animation.play("in_hand")

func _process(delta):
	if owner_body != null:
		var vector = owner_body.ray_cast.transform.x
		
		if vector.x > 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true

func weapon_ability():
	pass
#	sword_slash.execute(owner_body, spawn_position.global_transform)

func _on_Sword_use_sheath():
	animation.play("sheath")


func _on_Sword_use_in_hand():
	animation.play("in_hand")


func _on_Sword_use_weapon_ability():
	animation.playback_speed = owner_body.STATS.get_attack_speed()
	animation.play("attack")
