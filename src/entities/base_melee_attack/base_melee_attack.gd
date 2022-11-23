extends Base_attack

class_name Base_melee_attack

onready var sprite: Sprite = $Sprite

var flip_v = false
var is_hit = false
var life_time = 1.0

func _ready():
	sprite.flip_v = flip_v
