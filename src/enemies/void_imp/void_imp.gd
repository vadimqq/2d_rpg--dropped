extends Enemy

onready var attack_hitbox: Base_attack = $RayCast/Weapon_slot/Attack

func _ready():
	animation.playback_speed = STATS.get_attack_speed()
	
func _process(delta):
	if ray_cast.is_colliding():
		ai_state = AI_STATE.ATTACK

func attack():
	attack_hitbox.type = CONSTANTS.DAMAGE_TYPE_ENUM.PHYSIC
	attack_hitbox.load_info(self, attack_hitbox.transform, 0, [], STATS.get_physic_damage())

func end_attack():
	ai_state = AI_STATE.CHASE
