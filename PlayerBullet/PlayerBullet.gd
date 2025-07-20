extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Destroy Bullet after 5 sec
	destroyItselfAfterTime(5)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !GC.stopGame:
		position -= transform.y * GC.bulletVelocity * delta

func destroyItself():
	queue_free()
	
func destroyItselfAfterTime(time):
	await get_tree().create_timer(time).timeout
	destroyItself()

func _on_area_2d_area_entered(area: Area2D) -> void:
	destroyItself()
