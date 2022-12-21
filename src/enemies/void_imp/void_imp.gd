extends Enemy

onready var animation_tree: AnimationTree = $AnimationTree

func _ready():
	animation.playback_speed = STATS.get_attack_speed()
	STATS.apply_buff({
		"HEALTH": 1 * PACT_MANAGER.enemy_lvl,
		"GAIN_HEALTH": 1 * PACT_MANAGER.enemy_lvl,
		"MANA": 2 * PACT_MANAGER.enemy_lvl,
		"GAIN_ATTACK_SPEED": 1 * PACT_MANAGER.enemy_lvl,
		"GAIN_DAMAGE": 0.5 * PACT_MANAGER.enemy_lvl,
		"GAIN_PROJECTILE_SPEED": 1 * PACT_MANAGER.enemy_lvl,
		"PHYSIC_DAMAGE": 0.5 * PACT_MANAGER.enemy_lvl,
		"PHYSIC_RESIST": 0.1 * PACT_MANAGER.enemy_lvl
	})
	STATS.CURRENT_HEALTH = STATS.HEALTH

func _process(delta):
	if ray_cast.is_colliding():
		ai_state = AI_STATE.ATTACK

	match ai_state:
		AI_STATE.ATTACK:
			state = IDLE
			animation_tree.get("parameters/playback").travel("attack")

	if ai_state != AI_STATE.ATTACK && ai_state != AI_STATE.TAKE_HIT:
		animation_tree.get("parameters/playback").travel("move")

	animation_tree.set("parameters/move/blend_position", Motion)

func attack():
	for ability in ability_list.get_children():
		ability.execute(self, transform)

func _on_void_imp_take_damage(attack):
	ai_state = AI_STATE.TAKE_HIT
	animation_tree.get("parameters/playback").travel("take_hit")
