extends PathFollow2D

var content = null
#
func init(content_, progress_ratio_: float, loop_seconds_: float):
	progress_ratio = progress_ratio_
	content = content_
