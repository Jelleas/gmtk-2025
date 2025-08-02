extends VBoxContainer

class_name Inventory

signal TotemPieceRemoved(totem_piece: TotemPieces.TotemPiece)

@export var totem_interface: TotemInterface
@export var inventory_slot: PackedScene

var slots: Array[InventorySlot] = []

var totem: Totem = null

func _ready() -> void:
	$Label.text = ""
	totem_interface.TotemSelected.connect(_on_totem_selected)

func _on_totem_selected(totem: Totem):
	set_totem(totem)
	
func set_totem(totem_: Totem):
	totem = totem_
	
	var totem_pieces: Array[TotemPieces.TotemPiece] = []
	
	if totem.base != null:
		totem_pieces.append(totem.base)
	for mod in totem.modifiers:
		totem_pieces.append(mod)
	
	fill(totem_pieces)
	
	if totem.base != null:
		$Label.text = totem.base.name.capitalize()
	else:
		$Label.text = 'Totem'
	
	# Enable the delete button only for top totem piece
	for i in range(slots.size() - 1, -1, -1):
		var slot = slots[i]
		
		if not slot.is_empty():
			slot.show_delete()
			break
	
func fill(items: Array[TotemPieces.TotemPiece]) -> void:
	var n_slots = items.size() + 1
	_init_slots(n_slots)

	for i in range(items.size()):
		var item: TotemPieces.TotemPiece = items[i]
		var slot = slots[i]
		slot.fill(item)
	
func add(item): # TODO type hint
	if item.is_base_type:
		totem.set_base(item)
	else:
		totem.add_modifier(item)
	
	set_totem(totem)

func _init_slots(n_slots: int) -> void:
	const MIN_SLOTS = 5
	
	n_slots = max(n_slots, MIN_SLOTS)
	
	for i in range(slots.size() - n_slots):
		_pop_slot()
	
	for i in range(n_slots - slots.size()):
		slots.append(_create_slot())
		
	for slot in slots:
		slot.empty()
		
	for slot in slots:
		slot.refresh()

func _create_slot() -> InventorySlot:
	var inventory_slot_ = inventory_slot.instantiate()
	$ScrollContainer/VBoxContainer.add_child(inventory_slot_)
	$ScrollContainer/VBoxContainer.move_child(inventory_slot_, 0)
	inventory_slot_.ItemDeleted.connect(_on_item_deleted)
	return inventory_slot_
	
func _pop_slot() -> void:
	var slot = slots.pop_back()
	$ScrollContainer/VBoxContainer.remove_child(slot)
	
func _on_item_deleted(item) -> void:
	if item.is_base_type:
		totem.remove_base()
	else:
		totem.remove_modifier(item)
		
	TotemPieceRemoved.emit(item)

	set_totem(totem)
