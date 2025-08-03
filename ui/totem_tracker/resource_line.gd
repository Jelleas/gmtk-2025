extends HBoxContainer

class_name ResourceLine

var resource: Res.Type
var quantity: int

func set_resource(resource_: Res.Type, quantity_: int) -> void:
	resource = resource_
	quantity = quantity_
	var path = Res.image_path(resource_)
	var texture = load(path)
#
	var image = texture.get_image()
	image.resize(32, 32, Image.INTERPOLATE_LANCZOS)

	var resized_texture = ImageTexture.create_from_image(image)
	$TextureRect.texture = resized_texture
