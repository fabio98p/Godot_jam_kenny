extends RigidBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var explosion: AudioStreamPlayer2D = $explosion
@onready var area_2d: Area2D = $Area2D
@onready var explosion_wave: AnimationPlayer = $ExplosionWave
var enemyDestroy

# manage drop os ship
@export var bullet_scene: PackedScene
@export var drop_scene: PackedScene

# manage fire rate of ship
@export var bulletPerSecond: int = 1
var can_shoot: bool = false

# manage speed and ai of ship
@export var speed: float = 150

func _ready() -> void:
	enemyDestroy == false
	#startFireBulletLoop()

func _physics_process(delta: float) -> void:
	if !GC.stopGame:
		look_at(GC.getPlayerPosition())
		enemyMoviment(delta)

func _on_area_2d_area_entered(area: Area2D) -> void:
	#nave colpita e distrutta
	enemyDestroy = true
	can_shoot = false
	sprite_2d.queue_free()
	area_2d.queue_free()
	explosion.play()
	explosion_wave.play("ExplosionWave")
	spownDrop()

#func startFireBulletLoop():
	#while true:
		#await get_tree().create_timer(bulletPerSecond).timeout
		#if can_shoot:
			#spownBullet()

#func spownBullet():
	#var bullet_instance = bullet_scene.instantiate()
	#get_parent().add_child(bullet_instance)
	#bullet_instance.global_position = global_position 
	#bullet_instance.global_rotation_degrees = global_rotation_degrees + 90
	
func spownDrop():
	var drop_instance = drop_scene.instantiate()
	get_parent().add_child(drop_instance)
	drop_instance.global_position = global_position 
	drop_instance.global_rotation_degrees = global_rotation_degrees + 90


func _on_explosion_finished() -> void:
	queue_free()

func enemyMoviment(delta):
	if !enemyDestroy:
		# Ottieni la posizione del player
		var player_position = GC.getPlayerPosition()
		# Calcola la direzione dal nemico al player
		var direction_to_player = (player_position - global_position).normalized()

		# Applica una forza costante per spingere il RigidBody2D verso il player
		# L'uso di 'apply_central_force' è appropriato per un RigidBody2D
		apply_central_force(direction_to_player * speed * 100) # Moltiplica per un fattore per avere una forza notevole

		# Limita la velocità lineare per evitare che acceleri all'infinito
		if linear_velocity.length() > speed:
			linear_velocity = linear_velocity.normalized() * speed

		# Con un attacco suicida, la logica can_shoot non è più rilevante
		can_shoot = false # Imposta sempre a false se l'obiettivo è schiantarsi
			
func explodeToPlayer():
	#qua piu avanti metterò la logica
	pass
