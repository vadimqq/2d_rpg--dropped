extends Base_weapon

onready var animation = $Animation

var arrow_shot = SKILL_MANAGER.load_ability(self, "arrow_shot", 1)

func _init():
	tags = [CONSTANTS.WEAPON_TYPES.BOW]
	weapon_name = 'bow'

func _ready():
	attack_range = 100

func apply_stats(s: Base_body):
	s.STATS.apply_buff(STATS)

const STATS = {
	"ATTACK_SPEED": 0,
	"PROJECTILE_SPEED": 0,
	"DAMAGE": 0
}

func _on_Bow_use_weapon_ability():
	animation.playback_speed = owner_body.STATS.ATTACK_SPEED
	animation.play("attack")

func weapon_ability():
	arrow_shot.execute(owner_body, spawn_position.global_transform)

func _on_Bow_use_in_hand():
	animation.play("in_hand")


func _on_Bow_use_sheath():
	animation.play("sheath")
