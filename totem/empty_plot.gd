extends Sprite2D

func set_price(price: int):
	$Price.text = str(price)
	$Price.modulate.a = 0.5

func set_color(color: Color):
	color.a = 0.25
	self.self_modulate = color

func destroy():
	queue_free()
