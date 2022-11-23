extends Base_spirit

var lightning_bolt = preload("res://src/skills/lightning_bolt/Lightning_bolt.tscn")

var skill_dict: Dictionary

func _ready():
	yield(get_tree(),"idle_frame")
	skill_dict = {
		'first_skill': {
			'name': 'base attack',
			'cd': 0.5
		}
	}
	player.STATS.apply_buff(STATS)

func _on_void_spirit_cast_first_skill():
	var cdr = skill_dict['first_skill']['cd'] / player.STATS.ATTACK_SPEED
	player.combat_controler.playback_speed = cdr
	first_skill_timer.wait_time = cdr
		
	var lightning_bolt_instance = lightning_bolt.instance()
	lightning_bolt_instance.set_collision(8, 129)
	
	lightning_bolt_instance.flip_v = global_transform.x.x < 0
	get_tree().current_scene.add_child(lightning_bolt_instance)
	lightning_bolt_instance.cast(player.muzzle_spawn_postion.global_transform, player.muzzle.rotation, player.STATS.DAMAGE, player.STATS.PROJECTILE_SPEED)



const STATS = {
	"ATTACK_SPEED": 0,
	"PROJECTILE_SPEED": 0,
	"DAMAGE": 0
}


