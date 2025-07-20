extends Node2D

var velocity: int = 500
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Destroy Bullet after 5 sec
	destroyItselfAfterTime(5)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !GC.stopGame:
		position -= transform.y * velocity * delta

func destroyItself():
	queue_free()
	
func destroyItselfAfterTime(time):
	if !GC.stopGame:
		await get_tree().create_timer(time).timeout
		queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	destroyItself()
