extends Base_body


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	STATS = Stat_system.new(base_stats)
	on_stats_init()

const base_stats = {
	"HP": 50000.0,
}
