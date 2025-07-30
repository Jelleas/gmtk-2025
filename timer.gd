extends Timer

@export var resource_path: Path2D;

var content = null;	

func _ready() -> void:
	self.timeout.connect(_on_timeout)

func _process(_delta: float) -> void:
	if content == null:
		return
	
	if resource_path.deposit(Res.Type.WOOD, 0, 0):
		content = null
		
	#resource_path.consume(Res.Type.WOOD, 0, 0)

func _on_timeout():
	content = "foo"
