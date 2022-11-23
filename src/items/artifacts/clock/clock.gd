extends Item_with_popup

var count = 1

func _init():
	item_name = "Clock"
	description = "reduce CDR"
	stats = {
		"CDR": -40
	}

