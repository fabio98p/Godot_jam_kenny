extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

# manage drop os ship
@export var bullet_scene: PackedScene
@export var drop_scene: PackedScene

# manage fire rate of ship
@export var bulletPerSecond: int = 1
var can_shoot: bool = false

# manage speed and ai of ship
@export var speed: float = 150

func _ready() -> void:
	startFireBulletLoop()

func _process(delta: float) -> void:
	look_at(GC.getPlayerPosition())
	
	var distance_from_player: float = position.distance_to(GC.getPlayerPosition())
	print(distance_from_player)	
	if distance_from_player > 300.0:
		position += transform.x * speed * delta
	elif distance_from_player < 250.0: 
		position -= transform.x * speed * delta
	
	if distance_from_player < 300.0 and distance_from_player > 250.0:
		can_shoot = true
	else:
		can_shoot = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	spownDrop()
	queue_free()

func startFireBulletLoop():
	while true:
		await get_tree().create_timer(bulletPerSecond).timeout
		if can_shoot:
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
