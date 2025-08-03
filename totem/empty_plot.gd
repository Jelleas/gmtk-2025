extends Sprite2D

func set_price(price: int):
	$PriceContainer/Price.text = "%5d" % price
	$PriceContainer/Price.modulate.a = 0.5
	$PriceContainer/TextureRect.texture = BonesTracker.get_bones_image(69, 69)

func set_color(color: Color):
	color.a = 0.25
	self.self_modulate = color

func destroy():
	queue_free()
