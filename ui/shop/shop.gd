extends VBoxContainer

@export var shop_item: PackedScene

const N_SLOTS: int = 3

const STARTER_ITEMS: Array = [
	"foo",
	"bar",
	"baz"
]

const item_pool: Array = [
	"foo",
	"bar",
	"baz"
]

var items: Array[ShopItem] = []

func _ready() -> void:
	for content in STARTER_ITEMS:
		items.append(create_item(content))

func _on_item_bought(item) -> void: # TODO type hint
	print("bought, ", item)
	reroll()

func reroll() -> void:
	for item in items:
		item.queue_free()
	items = []
	
	var indices = []
	while len(indices) < N_SLOTS:
		var index = randi() % item_pool.size()
		if not indices.has(index):
			indices.append(index)
			
	for index in indices:
		items.append(create_item(item_pool[index]))

func create_item(content) -> ShopItem: # TODO type hint
	var shop_item = shop_item.instantiate()
	shop_item.init(content)
	add_child(shop_item)
	
	shop_item.item_bought.connect(_on_item_bought)
	
	return shop_item
