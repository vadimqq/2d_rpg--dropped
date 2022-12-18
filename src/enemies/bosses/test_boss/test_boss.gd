extends Enemy

onready var first_ability = $Abilities/homming_void_bomb
onready var animation_tree: AnimationTree = $AnimationTree


func _ready():
	animation.playback_speed = STATS.get_attack_speed()
	STATS.apply_buff({
		"GAIN_HEALTH": 5 * lvl,
		"GAIN_DAMAGE": 2 * lvl,
		"GAIN_ATTACK_SPEED": 1 * lvl,
	})

func _process(delta):
	if ray_cast.is_colliding() && first_ability.is_ready:
		ai_state = AI_STATE.ATTACK
		state = IDLE
	
	match ai_state:
		AI_STATE.ATTACK:
			animation_tree.get("parameters/playback").travel("first_ability")
		AI_STATE.CHASE:
			animation_tree.get("parameters/playback").travel("move")
	
	animation_tree.set("parameters/idle/blend_position", Motion)
	animation_tree.set("parameters/move/blend_position", Motion)

func first_ability():
	first_ability.execute(self, transform)

func _on_test_boss_death():
	pass
#	GAME_CORE.complite_location()
