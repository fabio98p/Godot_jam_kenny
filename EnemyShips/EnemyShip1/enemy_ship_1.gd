extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var bullet_scene: PackedScene
@export var drop_scene: PackedScene

@export var bulletPerSecond: int = 1

func _ready() -> void:
	startFireBulletLoop()

func _process(delta: float) -> void:
	look_at(GC.getPlayerPosition())

func _on_area_2d_area_entered(area: Area2D) -> void:
	spownDrop()
	queue_free()

func startFireBulletLoop():
	while true:
		await get_tree().create_timer(bulletPerSecond).timeout
		spownBullet()

func spownBullet():
	var bullet_instance = bullet_scene.instantiate()
	get_parent().add_child(bullet_instance)
	bullet_instance.global_position = global_position 
	bullet_instance.global_rotation_degrees = global_rotation_degrees + 90
	
func spownDrop():
	var drop_instance = drop_scene.instantiate()
	get_parent().add_child(drop_instance)
	drop_instance.global_position = global_position 
	drop_instance.global_rotation_degrees = global_rotation_degrees + 90
