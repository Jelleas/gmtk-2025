extends Sprite2D

func _ready():
	set_price(5)

func set_price(price: int):
	$HBoxContainer/Price.text = str(price)
	$HBoxContainer/Price.modulate.a = 0.5
	$HBoxContainer/TextureRect.texture = BonesTracker.get_bones_image(69, 69)

func set_color(color: Color):
	color.a = 0.25
	self.self_modulate = color

func destroy():
	queue_free()
