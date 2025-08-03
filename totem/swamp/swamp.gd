extends Node2D

var totem: Totem

var global_pos: Vector2
var local_pos: Vector2

var targets: Array[Area2D] = []
var attack_area: Area2D

var current_field: Node2D = null

func init(parent_ref: Totem):
	totem = parent_ref
	
	global_pos = totem.global_pos
	local_pos = totem.local_pos
	
	totem.sprite.modulate = totem.base.sprite_color

	attack_area = $AttackArea
	attack_area.global_position = local_pos
	$AttackArea/CollisionShape2D.shape.radius = totem.base.range

	attack_area.area_entered.connect(_on_attack_area_entered)
	attack_area.area_exited.connect(_on_attack_area_exited)
	attack_area.collision_mask = 1
	attack_area.set_physics_process(true)
	attack_area.monitoring = true
	attack_area.monitorable = false	

func _on_attack_area_entered(body: Node2D) -> void:
	if(body.is_in_group("monster")):
		targets.append(body)

func _on_attack_area_exited(body: Node2D) -> void:
	targets.erase(body)

func totem_action(base: TotemPieces.TotemBase) -> bool:
	$AttackArea/CollisionShape2D.shape.radius = base.range
	if current_field:
		current_field.destroy()
	if targets.size():
		drop(base, local_pos, targets[0])
		return true
	return false

func drop(base: TotemPieces.TotemBase, from: Vector2, target: Area2D):
	var projectile_scene = preload("res://totem/swamp/field.tscn")

	current_field = projectile_scene.instantiate()
	current_field.setup_shape(base.range / 10)	

	var to = totem.tile_map_layer.to_local(target.global_position)
	current_field.damage_spec = base.damage_spec.duplicate()
	current_field.global_position = to
	add_child(current_field)
