extends Node2D

@onready var drop: Label = $Drop
@onready var timer: Node2D = $Timer
@onready var player_ship: CharacterBody2D = $PlayerShip
@onready var ui_shield: Sprite2D = $"UI shield"

func _ready() -> void:
	timer.start_timer()
	player_ship.can_move = true
	

func _process(delta: float) -> void:
	drop.text = str( GC.collectedDrop )
	setUiShield()

func setUiShield():
	
	pass
