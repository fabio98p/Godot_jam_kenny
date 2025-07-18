extends Node2D

@export var Velocity = 30
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(GC.getPlayerPosition())
	position += transform.x * Velocity * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("drop")
	GC.setCollectDrop()
	queue_free()
