extends VBoxContainer

class_name Inventory

@export var inventory_slot: PackedScene

const DEFAULT_N_SLOTS: int = 2

var slots: Array[InventorySlot] = []

func _ready() -> void:
	_init_slots(DEFAULT_N_SLOTS)

func fill(items: Array[TotemPieces.TotemPiece]) -> void:
	var n_slots = items.size() + 1
	_init_slots(n_slots)

	for i in range(items.size()):
		var item = items[i]
		var slot = slots[i]
		slot.fill(item)
	
func add(item: TotemPieces.TotemPiece): # TODO type hint
	for slot in slots:
		if slot.is_empty():
			slot.fill(item)
			break

func _init_slots(n_slots: int) -> void:
	for i in range(slots.size() - n_slots):
		_pop_slot()
	
	for i in range(n_slots - slots.size()):
		slots.append(_create_slot())
		
	for slot in slots:
		slot.empty()

func _create_slot() -> InventorySlot:
	var inventory_slot = inventory_slot.instantiate()
	$ScrollContainer/VBoxContainer.add_child(inventory_slot)
	$ScrollContainer/VBoxContainer.move_child(inventory_slot, 0)
	return inventory_slot
	
func _pop_slot() -> void:
	var slot = slots.pop_back()
	$ScrollContainer/VBoxContainer.remove_child(slot)
