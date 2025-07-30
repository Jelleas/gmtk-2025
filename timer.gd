extends Timer

@export var resource_path: Path2D;

var content = null;	

func _ready() -> void:
	self.timeout.connect(_on_timeout)

func _process(delta: float) -> void:
	if content == null:
		return
	
	if resource_path.deposit(content, 0, 0):
		content = null;

func _on_timeout():
	content = "foo"
