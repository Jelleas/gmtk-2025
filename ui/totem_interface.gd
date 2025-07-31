extends Control

@export var resource_manager: Path2D
@export var totem_scene: PackedScene

func _ready() -> void:
	$CreateProducers/CreateProducer1.init(resource_manager, totem_scene, Res.Type.WOOD, 51, 52)
	$CreateProducers/CreateProducer2.init(resource_manager, totem_scene, Res.Type.WOOD, 47, 48)
	$CreateProducers/CreateProducer3.init(resource_manager, totem_scene, Res.Type.FROG, 43, 44)
	$CreateProducers/CreateProducer4.init(resource_manager, totem_scene, Res.Type.FROG, 39, 40)
	
	$CreateConsumers/CreateConsumer1.init(resource_manager, totem_scene, 0, 1)
	$CreateConsumers/CreateConsumer2.init(resource_manager, totem_scene, 3, 4)
	$CreateConsumers/CreateConsumer3.init(resource_manager, totem_scene, 9, 10)
	$CreateConsumers/CreateConsumer4.init(resource_manager, totem_scene, 15, 15)
	$CreateConsumers/CreateConsumer5.init(resource_manager, totem_scene, 18, 19)
	$CreateConsumers/CreateConsumer6.init(resource_manager, totem_scene, 21, 22)
	$CreateConsumers/CreateConsumer7.init(resource_manager, totem_scene, 27, 28)
	$CreateConsumers/CreateConsumer8.init(resource_manager, totem_scene, 33, 34)
	$CreateConsumers/CreateConsumer9.init(resource_manager, totem_scene, 36, 37)
	$CreateConsumers/CreateConsumer10.init(resource_manager, totem_scene, 39, 40)
	$CreateConsumers/CreateConsumer11.init(resource_manager, totem_scene, 45, 46)
	$CreateConsumers/CreateConsumer12.init(resource_manager, totem_scene, 51, 52)
	$CreateConsumers/CreateConsumer13.init(resource_manager, totem_scene, 54, 55)
	$CreateConsumers/CreateConsumer14.init(resource_manager, totem_scene, 57, 58)
	$CreateConsumers/CreateConsumer15.init(resource_manager, totem_scene, 63, 64)
	$CreateConsumers/CreateConsumer16.init(resource_manager, totem_scene, 69, 70)
