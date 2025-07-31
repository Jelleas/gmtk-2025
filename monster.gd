extends PathFollow2D

class_name Monster

const LOOP_SECONDS = 20

var speed = 1
var type: Monster.Type

enum Type {
	BLOB
}

func _process(delta: float) -> void:
	progress_ratio += delta / (LOOP_SECONDS / speed)

func init(type_: Monster.Type):
	type = type_
