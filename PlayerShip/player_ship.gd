extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var bullet_sound: AudioStreamPlayer2D = $BulletSound

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

func _physics_process(delta: float) -> void:
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
	if can_move:
		if event.is_action_pressed("Fire"):
			# instantiate bulletd
			spownBullet()

func spownBullet():
	var bullet_instance = bullet_scene.instantiate()
	get_parent().add_child(bullet_instance)
	bullet_instance.global_position = global_position 
	bullet_instance.global_rotation_degrees = global_rotation_degrees + 90

func _on_enemy_bullet_collision_area_entered(area: Area2D) -> void:
	current_shield -= 1
	if current_shield == 0:
		GC.setTotalDrop()
		#get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
		 
