extends VBoxContainer

@export var shop_item: PackedScene
@export var inventory: Inventory

const N_SLOTS: int = 3

var items: Array[ShopItem] = []

func _ready() -> void:
	reroll()

func _on_item_bought(item) -> void: # TODO type hint
	print("bought, ", item)
	reroll()
	inventory.add_item(item)

func reroll() -> void:
	for item in items:
		item.queue_free()
	items = []
	
	var indices = []
	while len(indices) < N_SLOTS:
		var index = randi() % TotemPieces.modifiers.size()
		if not indices.has(index):
			indices.append(index)
			
	for index in indices:
		items.append(create_item(TotemPieces.modifiers[index]))

func create_item(modifier: TotemPieces.Modifier) -> ShopItem: # TODO type hint
	var shop_item = shop_item.instantiate()
	shop_item.init(modifier)
	add_child(shop_item)
	
	shop_item.item_bought.connect(_on_item_bought)
	
	return shop_item
