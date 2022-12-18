extends Enemy

onready var attack_hitbox: Base_attack = $RayCast/Weapon_slot/Attack
onready var animation_tree: AnimationTree = $AnimationTree

func _ready():
	animation.playback_speed = STATS.get_attack_speed()
	STATS.apply_buff({
		"GAIN_HEALTH": 5 * lvl,
		"GAIN_DAMAGE": 5 * lvl,
		"GAIN_MOVE_SPEED": 0.2 * lvl,
		"GAIN_ATTACK_SPEED": 1 * lvl,
	})

func _process(delta):
	if ray_cast.is_colliding():
		ai_state = AI_STATE.ATTACK
	
	match ai_state:
		AI_STATE.ATTACK:
			animation_tree.get("parameters/playback").travel("attack")
	
	if ai_state != AI_STATE.ATTACK && ai_state != AI_STATE.TAKE_HIT:
		animation_tree.get("parameters/playback").travel("move")
	
	animation_tree.set("parameters/move/blend_position", Motion)

func attack():
	attack_hitbox.type = CONSTANTS.DAMAGE_TYPE_ENUM.PHYSIC
	attack_hitbox.load_info(self, attack_hitbox.transform, 0, [], STATS.get_physic_damage())

func _on_void_imp_take_damage(attack):
	ai_state = AI_STATE.TAKE_HIT
	animation_tree.get("parameters/playback").travel("take_hit")
