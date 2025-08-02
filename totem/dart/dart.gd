extends Node2D

var totem: Totem

var global_pos: Vector2
var local_pos: Vector2

var locked_target: Area2D
var attack_area: Area2D

func init(parent_ref):
	totem = parent_ref
	
	global_pos = totem.global_pos
	local_pos = totem.local_pos
	
	totem.sprite.modulate = totem.base.sprite_color

	attack_area = $AttackArea
	attack_area.global_position = local_pos
	$AttackArea/CollisionShape2D.shape = $AttackArea/CollisionShape2D.shape.duplicate()
	$AttackArea/CollisionShape2D.shape.radius = totem.base.range
	attack_area.area_entered.connect(_on_attack_area_entered)
	attack_area.area_exited.connect(_on_attack_area_exited)
	attack_area.collision_mask = 1
	attack_area.set_physics_process(true)
	attack_area.monitoring = true
	attack_area.monitorable = false
	
func _on_attack_area_entered(body: Node2D) -> void:
	if(!locked_target && body.is_in_group("monster")):
		locked_target = body

func _on_attack_area_exited(body: Node2D) -> void:
	if locked_target == body:
		locked_target = null
		var target_list = attack_area.get_overlapping_bodies()
		if(target_list.size() > 0 && target_list[0].is_in_group("monster")):
			locked_target = target_list[0]

func totem_action(base: TotemPieces.TotemBase) -> bool:
	print("BEFORE ACTION ", $AttackArea/CollisionShape2D.shape.radius, " ", $AttackArea/CollisionShape2D.shape)
	$AttackArea/CollisionShape2D.shape.radius = base.range
	print("AFTER ACTION ", $AttackArea/CollisionShape2D.shape.radius, " ",  $AttackArea/CollisionShape2D.shape)
	if(locked_target):
		shoot(base, local_pos, locked_target)
		return true
	return false
		
func shoot(base: TotemPieces.TotemBase, from: Vector2, target: Area2D):
	var to = totem.tile_map_layer.to_local(target.global_position)
	var projectile_scene = preload("res://totem/dart/dart_projectile.tscn")
	var proj = projectile_scene.instantiate()
	proj.damage = base.damage
	proj.global_position = from
	proj.direction = (to - from).normalized()

	add_child(proj)
