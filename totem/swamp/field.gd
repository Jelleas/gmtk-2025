extends Area2D

var target:Area2D = null
var damage: int
var mat
var in_swamp: Array[Monster] = []
var damage_spec: DamageSpec

func _ready():
	monitoring = true
	monitorable = true
	collision_layer = 2
	collision_mask = 1
	add_to_group("projectile")
	self.area_entered.connect(on_swamp_entered)
	self.area_exited.connect(on_swamp_exited)
	start_damage_cycle()

func on_swamp_entered(body: Area2D):
	if(body.is_in_group("monster")):
		var monster = body.get_parent() as Monster
		monster.get_hit(damage_spec)
		in_swamp.append(monster)

func on_swamp_exited(body: Area2D):
	if(body.is_in_group("monster")):
		var monster = body.get_parent() as Monster
		var copy_spec = damage_spec.duplicate()
		copy_spec.speed_modifier = - damage_spec.speed_modifier
		monster.get_hit(copy_spec)
		in_swamp.erase(monster)

func hit_area():
	var in_area = get_overlapping_areas()
	for area in in_area:
		if area.is_in_group("monster"):
			var monster = area.get_parent() as Monster
			var copy_spec = damage_spec.duplicate()
			copy_spec.speed_modifier = 0
			monster.get_hit(copy_spec)

func start_damage_cycle():
	while true:
		await get_tree().create_timer(1.0).timeout
		hit_area()

func setup_shape(range: float):
	$CollisionShape2D.shape.radius = range
	mat = $GPUParticles2D.process_material as ParticleProcessMaterial
	mat.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_SPHERE
	mat.emission_sphere_radius = range
	$GPUParticles2D.emitting = true
	

func destroy():
	queue_free()
