extends Node2D

@onready var timer: Node2D = $Timer

func _ready() -> void:
	timer.start_timer()
