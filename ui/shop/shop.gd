extends VBoxContainer

class_name Shop

@export var shop_item: PackedScene
@export var inventory: Inventory
@export var totem_interface: TotemInterface
@export var bones_tracker: BonesTracker
@export var monster_path: MonsterPath

signal totem_piece_unlocked(piece: TotemPieces.TotemPiece)

const N_MODIFIER_SLOTS: int = 3
const N_BASE_SLOTS: int = 2
const REROLL_COST: int = 10

var items: Array[ShopItem] = []

var totem: Totem
var current_wave: int = 0

var inflation: float = 1

func _ready() -> void:
	reroll()
	$RerollButton.button_up.connect(_on_reroll_button_button_up)
	totem_interface.TotemSelected.connect(_on_totem_selected)
	inventory.TotemPieceRemoved.connect(_on_totem_piece_removed)
	bones_tracker.bones_updated.connect(sync)
	monster_path.wave_started.connect(on_new_wave)
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

func _on_item_bought(item, price: int) -> void: # TODO type hint
	if bones_tracker.spend(price):
		inventory.add(item)
		reroll()

func apply_inflation() -> void:
	inflation = 1.2**totem.modifiers.size()
	
	for item in items:
		item.apply_inflation(inflation)

func reroll() -> void:
	for item in items:
		item.queue_free()

	items = []
	var available_modifiers = TotemPieces.modifiers.filter(func (it): return it.unlocks_at_wave <= current_wave)
	for it in get_random_sample(available_modifiers, N_MODIFIER_SLOTS):
		items.append(create_item(it))
		
	var available_bases = TotemPieces.base_types.filter(func (it): return it.unlocks_at_wave <= current_wave)	
	for it in get_random_sample(available_bases, N_BASE_SLOTS):
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
	
	apply_inflation()
	
	for it in items:
		var is_base_piece = it.item.is_base_type
		var has_base = totem.base != null
		var cannot_buy = !bones_tracker.has(it.current_price)
		var incompatible_base = has_base and is_base_piece
		var incompatible_modifier = not has_base and not is_base_piece
		
		if incompatible_base or incompatible_modifier or cannot_buy:
			it.disable()
		else:
			it.enable()
		
	
func get_random_sample(items: Array, n: int) -> Array:
	var items_copy = items.duplicate()
	var chosen = []
	for i in range(n):
		if items_copy.is_empty(): # otherwise it complains about picking random from empty
			break
		var item = items_copy.pick_random()
		if item == null:
			break
		items_copy.erase(item)
		chosen.append(item)
	return chosen

func create_item(modifier: TotemPieces.TotemPiece) -> ShopItem:
	var shop_item_ = shop_item.instantiate()
	shop_item_.init(modifier)
	add_child(shop_item_)
	
	shop_item_.item_bought.connect(_on_item_bought)
	
	return shop_item_

func on_new_wave(wave_number: int, next_wave_in: float):
	current_wave = wave_number
	for it in TotemPieces.base_types:
		if it.unlocks_at_wave == wave_number:
			totem_piece_unlocked.emit(it)
			print("unlocked: ", it.name)
	for it in TotemPieces.modifiers:
		if it.unlocks_at_wave == wave_number:
			totem_piece_unlocked.emit(it)
			print("unlocked: ", it.name)
