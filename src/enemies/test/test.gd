extends Enemy

onready var weapon: Base_weapon = weapon_slot.get_child(0)

func _ready():
	STATS = Stat_system.new(base_stats)
	on_stats_init()
	ray_cast.cast_to.x = weapon.attack_range
	weapon.use_in_hand()

func _process(delta):
	if ray_cast.is_colliding():
		weapon.use_weapon_ability(self)
	
const base_stats = {
	"LVL": 1,
	
	"HP": 150,
	"HP_REG": 1.0,
	
	"MOVE_SPEED": 50.0,
	"DASH_TIME": 0.3,
	
	"ATTACK_SPEED": 5.0,
	"PROJECTILE_SPEED": 100.0,
	"DAMAGE": 10.0,
	
	"CAST_DURATION": 0.0,
	"INCREASE_AREA": 0.0,
	"KNOCKBACK_POWER": 0.0,
	"CDR": 0.0,
}


func _on_test_death():
	queue_free()
