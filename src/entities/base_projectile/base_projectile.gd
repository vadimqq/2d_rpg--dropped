extends Base_attack

class_name Base_projectile

onready var sprite = $Sprite

var flip_v = false
var is_hit = false


func _ready():
	sprite.flip_v = flip_v

func _physics_process(delta):
	if !is_hit:
		position += transform.x * speed * delta
