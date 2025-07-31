extends PathFollow2D

class_name Monster

signal monster_escape(cost: int)

const LOOP_SECONDS = 20

var escape_cost = 10
var speed = 20
var type: Monster.Type

enum Type {
	BLOB
}

func _process(delta: float) -> void:
	progress_ratio += delta / (LOOP_SECONDS / speed)
	
	if progress_ratio >= 1.0:
		escape()

func init(type_: Monster.Type):
	type = type_

func escape():
	print("escaped")
	monster_escape.emit(escape_cost)
	queue_free()
	
