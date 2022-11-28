extends TextureProgress

onready var particle = $Particle
onready var particle_2 = $Particle2

var is_active = false

func _process(delta):
	particle.emitting = is_active
	particle_2.emitting = is_active
