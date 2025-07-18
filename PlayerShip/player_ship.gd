extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var bullet_scene: PackedScene

@export var MAX_SPEED: float = 500.0
@export var ACCEL: float = 1500.0

func _physics_process(delta: float) -> void:

	#handle the movement right and left
	var directionx := Input.get_axis("Left", "Right")
	if directionx:
		velocity.x = move_toward(velocity.x, directionx * MAX_SPEED, ACCEL * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, ACCEL * delta) 
		
	#handle the movement Up and Downaw
	var directiony := Input.get_axis("Up", "Down")
	if directiony:
		velocity.y = move_toward(velocity.y, directiony * MAX_SPEED, ACCEL * delta)
	else:
		velocity.y = move_toward(velocity.y, 0, ACCEL * delta) 

	#handle ship rotation in direction to the mouse
	look_at(get_global_mouse_position())
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Fire"):
		# instantiate bulletd
		var bullet_instance = bullet_scene.instantiate()
		get_parent().add_child(bullet_instance)
		bullet_instance.global_position = global_position 
		bullet_instance.global_rotation_degrees = global_rotation_degrees + 90


func _on_enemy_bullet_collision_area_entered(area: Area2D) -> void:
	print("ship destroyed")
