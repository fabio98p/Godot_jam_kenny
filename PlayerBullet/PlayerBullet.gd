extends Node2D

var velocity: int = 500
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Destroy Bullet after 5 sec
	destroyItselfAfterTime(5)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position -= transform.y * velocity * delta

func destroyItself():
	queue_free()
	
func destroyItselfAfterTime(time):
	await get_tree().create_timer(time).timeout
	queue_free()
