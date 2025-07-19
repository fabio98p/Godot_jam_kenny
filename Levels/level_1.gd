extends Node2D

@onready var drop: Label = $Drop
@onready var timer: Node2D = $Timer
@onready var player_ship: CharacterBody2D = $PlayerShip

func _ready() -> void:
	timer.start_timer()
	player_ship.can_move = true

func _process(delta: float) -> void:
	drop.text = str( GC.collectedDrop )
