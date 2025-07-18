extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var bullet_scene: PackedScene

const SPEED = 300.0

func _physics_process(delta: float) -> void:

	#handle the movement right and left
	var directionx := Input.get_axis("Left", "Right")
	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#handle the movement Up and Down
	var directiony := Input.get_axis("Up", "Down")
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	#handle ship rotation in direction to the mouse
	look_at(get_global_mouse_position())
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Fire"):
		# instantiate bulletd
		var bullet_instance = bullet_scene.instantiate()
		get_parent().add_child(bullet_instance)
		bullet_instance.global_position = global_position 
		bullet_instance.global_rotation = global_rotation + 90
