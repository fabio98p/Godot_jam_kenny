extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var bullet_sound: AudioStreamPlayer2D = $BulletSound
@onready var shield: Sprite2D = $Shield
@onready var fire_timer: Timer = $Fire_Timer

@export var autofire: bool = false # Controlla se l'autofire è attivo
@export var velocitàproiettiliautofire: float = 0.2


@export var bullet_scene: PackedScene

@export var can_move: bool = false

var max_velocity: float 
var accel: float
var max_shield: int
var current_shield: int

func _ready() -> void:
	max_velocity = GC.playerMaxVelocity
	accel = GC.playerAccel
	max_shield = GC.playerMaxShield
	current_shield = max_shield
	
	fire_timer.timeout.connect(_on_fire_timer_timeout)
	fire_timer.wait_time = GC.bulletPerFire
	fire_timer.one_shot = false

	if autofire:
		fire_timer.start()
	
	

func _physics_process(delta: float) -> void:
	if !GC.stopGame:
		if can_move:
			GC.setPlayerPosition(position)
			
			#handle the movement right and left
			var directionx := Input.get_axis("Left", "Right")
			if directionx:
				velocity.x = move_toward(velocity.x, directionx * max_velocity, accel * delta)
			else:
				velocity.x = move_toward(velocity.x, 0, accel * delta) 
				
			#handle the movement Up and Downaw
			var directiony := Input.get_axis("Up", "Down")
			if directiony:
				velocity.y = move_toward(velocity.y, directiony * max_velocity, accel * delta)
			else:
				velocity.y = move_toward(velocity.y, 0, accel * delta) 

			#handle ship rotation in direction to the mouse
			look_at(get_global_mouse_position())
			
			move_and_slide()

func _input(event: InputEvent) -> void:
	if !GC.stopGame:
		if can_move:
			if !GC.autoFire: # Sparo manuale solo se l'autofire NON è attivo
				if event.is_action_pressed("Fire"):
					bullet_sound.play()
					spownBullet()

#func _input(event: InputEvent) -> void:
	#if can_move:
		#if event.is_action_pressed("Fire"):
			## instantiate bulletd
			#bullet_sound.play()
			#spownBullet()
func _on_fire_timer_timeout():
	print("sparo autofire")
	if can_move and GC.autoFire: # Spara solo se il player può muoversi e l'autofire è attivo
		bullet_sound.play()
		spownBullet()

func set_autofire_status(status: bool):
	autofire = status
	if autofire:
		fire_timer.start()
	else:
		fire_timer.stop()

func spownBullet():
	var bullet_instance = bullet_scene.instantiate()
	get_parent().add_child(bullet_instance)
	bullet_instance.global_position = global_position 
	bullet_instance.global_rotation_degrees = global_rotation_degrees + 90

func _on_enemy_bullet_collision_area_entered(area: Area2D) -> void:
	current_shield -= 1
	GC.currentShield = current_shield
	if current_shield == 0:
		shield.visible = false
	if current_shield == -1:
		get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
		 
