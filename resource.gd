extends PathFollow2D

@export var loop_seconds: float = 10
var content = null
#
func init(content_, progress_ratio_: float, loop_seconds_: float):
	loop_seconds = loop_seconds_
	progress_ratio = progress_ratio_
	content = content_
