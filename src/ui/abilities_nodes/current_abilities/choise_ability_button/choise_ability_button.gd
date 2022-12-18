extends TextureButton

class_name Choise_button

var ability_name = ''

func set_ability_name(a_name):
	ability_name = a_name

func set_ability_texture(texture):
	texture_normal = texture

func _on_TextureButton_button_up():
	print(ability_name)
