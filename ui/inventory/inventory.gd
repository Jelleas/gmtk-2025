extends VBoxContainer

class_name Inventory

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
	
	totem_pieces.append(totem.base)
	for mod in totem.modifiers:
		totem_pieces.append(mod)
	
	fill(totem_pieces)
	
	$Label.text = totem.base.name.capitalize() + ' Totem'

func fill(items: Array[TotemPieces.TotemPiece]) -> void:
	var n_slots = items.size() + 1
	_init_slots(n_slots)

	for i in range(items.size()):
		var item = items[i]
		var slot = slots[i]
		slot.fill(item)
	
func add(item): # TODO type hint
	if item is TotemPieces.BaseType:
		totem.set_base(item)
	else:
		totem.add_modifier(item)
	
	set_totem(totem)

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
