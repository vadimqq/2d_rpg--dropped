extends Item_with_popup

var count = 1

func _init():
	id = "clock"
	item_name = "Clock"
	description = "reduce CDR"
	stats = {
		"GAIN_CDR": 10
	}

