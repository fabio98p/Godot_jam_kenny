extends Node2D

@onready var drop: Label = $Drop
@onready var timer: Node2D = $Timer

func _ready() -> void:
	timer.start_timer()

func _process(delta: float) -> void:
	drop.text = str( GC.collectedDrop )
