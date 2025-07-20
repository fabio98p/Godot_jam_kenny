extends Node2D

@onready var speed_upgrade_panel: Panel = $SpeedUpgrade/SpeedUpgradePanel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_speed_upgrade_pressed() -> void:
	print(GC.settingPlayerMaxVelocity)
	GC.settingPlayerMaxVelocity += 1
	speed_upgrade_panel.size.y += (1 * 3.6)
	speed_upgrade_panel.position.y -= (1 * 3.6)

func _on_button_upgrade_button_pressed(costUpgrade, levelUpgrade) -> void:
	GC.settingPlayerMaxVelocity == levelUpgrade
