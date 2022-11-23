extends Base_spirit


onready var animation = $Animation

var skill_dict: Dictionary = {
		'first_skill': {
			'name': 'base attack',
			'cd': 1.0
		}
	}

func _ready():
	yield(get_tree(),"idle_frame")
	skill_dict 
	animation.play("chase")
	player.STATS.apply_buff(STATS)


const STATS = {
	"ATTACK_SPEED": 0,
	"PROJECTILE_SPEED": 0,
	"DAMAGE": 0
}
