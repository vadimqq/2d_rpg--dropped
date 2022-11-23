extends Base_weapon

onready var animation = $Animation

var sword_slash = SKILL_MANAGER.load_ability(self, "sword_slash")

func _init():
	tags = [CONSTANTS.WEAPON_TYPES.SWORD]
	weapon_name = 'sword'

func _ready():
	attack_range = 30
	animation.play("in_hand")

func apply_stats(s: Base_body):
	s.STATS.apply_buff(STATS)

const STATS = {
	"ATTACK_SPEED": 0,
	"PROJECTILE_SPEED": 0,
	"DAMAGE": 0,
	"INCREASE_AREA": 0
}

func _process(delta):
	if owner_body != null:
		var vector = owner_body.ray_cast.transform.x
		
		if vector.x > 0:
			sprite.flip_h = false
			scale.y = 1
			
			if in_sheath:
				scale.y = 1
		else:
			sprite.flip_h = true
			scale.y = -1
			
			if in_sheath:
				scale.y = 1

func weapon_ability():
	sword_slash.execute(owner_body, spawn_position.global_transform)

func _on_Sword_use_sheath():
	animation.play("sheath")


func _on_Sword_use_in_hand():
	animation.play("in_hand")


func _on_Sword_use_weapon_ability():
	animation.playback_speed = owner_body.STATS.ATTACK_SPEED
	animation.play("attack")
