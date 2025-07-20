extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !GC.stopGame:
		look_at(GC.getPlayerPosition())
		position += transform.x * GC.dropVelocity * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	GC.setCollectDrop()
	queue_free()
