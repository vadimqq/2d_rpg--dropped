extends TextureRect

onready var count_label = $Count

var count = 1

func add_count():
	count += 1
	count_label.text  = str(count)
