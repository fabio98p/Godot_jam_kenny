extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var explosion: AudioStreamPlayer2D = $explosion
@onready var area_2d: Area2D = $Area2D
@onready var explosion_wave: AnimationPlayer = $ExplosionWave
signal enemy_died(corner_name: String)
var enemyDestroy
var assigned_corner_name: String
# manage drop os ship
@export var bullet_scene: PackedScene
@export var drop_scene: PackedScene

# manage fire rate of ship
@export var bulletPerSecond: float = 1
var can_shoot: bool = false

# manage speed and ai of ship
@export var speed: float = 150

func _ready() -> void:
	enemyDestroy == false
	startFireBulletLoop()

func _process(delta: float) -> void:
	look_at(GC.getPlayerPosition())
	enemyMoviment(delta)
	
func set_assigned_corner(name: String):
	assigned_corner_name = name
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	#nave colpita e distrutta
	enemyDestroy = true
	can_shoot = false
	sprite_2d.queue_free()
	area_2d.queue_free()
	explosion.play()
	explosion_wave.play("ExplosionWave")
	spownDrop()

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


func _on_explosion_finished() -> void:
	print("esploso")
	# Emette il segnale prima
	if assigned_corner_name:
		emit_signal("enemy_died", assigned_corner_name)
	queue_free()

func enemyMoviment(delta):
	if !enemyDestroy:
		can_shoot = true
		
