extends VBoxContainer

@export var shop_item: PackedScene
@export var inventory: Inventory
@export var totem_interface: TotemInterface
@export var bones_tracker: BonesTracker

const N_MODIFIER_SLOTS: int = 3
const N_BASE_SLOTS: int = 1
const REROLL_COST: int = 10

var items: Array[ShopItem] = []

var totem: Totem

func _ready() -> void:
	reroll()
	$RerollButton.button_up.connect(_on_reroll_button_button_up)
	totem_interface.TotemSelected.connect(_on_totem_selected)
	inventory.TotemPieceRemoved.connect(_on_totem_piece_removed)
	bones_tracker.bones_updated.connect(sync)
	hide()

func _on_totem_selected(totem_: Totem) -> void:
	totem = totem_
	show()
	pop_on_screen()

func _on_totem_piece_removed(totem_piece: TotemPieces.TotemPiece) -> void:
	sync()

func _on_reroll_button_button_up() -> void:
	if !bones_tracker.spend(REROLL_COST): return
	reroll()

func _on_item_bought(item) -> void: # TODO type hint
	if bones_tracker.spend(item.price):
		inventory.add(item)
		reroll()

func reroll() -> void:
	for item in items:
		item.queue_free()

	items = []
	
	for it in get_random_sample(TotemPieces.modifiers, N_MODIFIER_SLOTS):
		items.append(create_item(it))
		
	for it in get_random_sample(TotemPieces.base_types, N_BASE_SLOTS):
		items.append(create_item(it))

	pop_on_screen()
	
func pop_on_screen():
	for item in items:
		item.modulate.a = 0.5
		item.disable()

	for item in items:
		var tween = create_tween()
		tween.tween_property(item, "modulate:a", 1.0, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	sync()
	
func sync() -> void:
	if totem == null:
		return
	
	for it in items:
		var is_base_piece = it.item.is_base_type
		var has_base = totem.base != null
		var cannot_buy = !bones_tracker.has(it.item.price)
		var incompatible_base = has_base and is_base_piece
		var incompatible_modifier = not has_base and not is_base_piece
		
		if incompatible_base or incompatible_modifier or cannot_buy:
			it.disable()
		else:
			it.enable()
		
	
func get_random_sample(items: Array, n: int) -> Array:
	var indices = []
	while len(indices) < n:
		var index = randi() % items.size()
		if not indices.has(index):
			indices.append(index)
	
	var random_items = []
	for index in indices:
		random_items.append(items[index])

	return random_items

func create_item(modifier: TotemPieces.TotemPiece) -> ShopItem:
	var shop_item_ = shop_item.instantiate()
	shop_item_.init(modifier)
	add_child(shop_item_)
	
	shop_item_.item_bought.connect(_on_item_bought)
	
	return shop_item_
