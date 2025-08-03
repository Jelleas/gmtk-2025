extends HBoxContainer

class_name ResourceCounter

var resource: Res.Type

func init(res: Res.Type) -> void:
	resource = res
	$ResourceRect.texture = get_image(load(Res.image_path(resource)))

func update_count(count: int) -> void:
	$MarginContainer/Label.text = str(count)

func get_image(resource: Resource) -> ImageTexture:
	var image = resource.get_image()
	image.resize(34, 24, Image.INTERPOLATE_LANCZOS)
	return ImageTexture.create_from_image(image)
