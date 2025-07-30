extends PathFollow2D

class_name Res

enum Type {
	WOOD,
	FROG,
	FISH
}

var type: Res.Type
#
func init(type_: Res.Type, progress_ratio_: float):
	progress_ratio = progress_ratio_
	type = type_
