extends VBoxContainer

class_name Inventory

@export var inventory_slot: PackedScene

const N_SLOTS: int = 5

var slots = []

func _ready() -> void:
	for i in range(N_SLOTS):
		slots.append(_create_slot())

func add_item(item): # TODO type hint
	for slot in slots:
		if slot.is_empty():
			slot.load(item)
			break

func _create_slot(): # TODO type hint
	var inventory_slot = inventory_slot.instantiate()
	add_child(inventory_slot)
	return inventory_slot
