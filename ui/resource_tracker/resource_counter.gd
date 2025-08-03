extends HBoxContainer

class_name ResourceCounter

var resource_path: Path2D
var initialized = false
var resource: Res.Type

func init(resource_path_: Path2D, res: Res.Type) -> void:
	resource_path = resource_path_
	resource = res
	$ResourceRect.texture = get_image(load(Res.image_path(resource)))
	initialized = true

func _process(delta: float) -> void:
	if !initialized:
		return
	
	var count = 0
	for c in resource_path.contents:
		if c != null and c.type == resource:
			count += 1

	$MarginContainer/Label.text = str(count)

func get_image(resource: Resource) -> ImageTexture:
	var image = resource.get_image()
	image.resize(34, 24, Image.INTERPOLATE_LANCZOS)
	return ImageTexture.create_from_image(image)
