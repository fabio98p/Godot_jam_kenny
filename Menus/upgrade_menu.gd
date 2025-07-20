extends Node2D

@onready var speed_upgrade_panel: Panel = $SpeedUpgrade/SpeedUpgradePanel
@onready var drop_label: Label = $DropLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	drop_label.text = str(GC.totalDrop)


func _on_speed_upgrade_pressed() -> void:
	print(GC.settingPlayerMaxVelocity)
	GC.settingPlayerMaxVelocity += 1
	speed_upgrade_panel.size.y += (1 * 3.6)
	speed_upgrade_panel.position.y -= (1 * 3.6)

func _on_button_upgrade_button_pressed(costUpgrade, levelUpgrade) -> void:
	GC.settingPlayerMaxVelocity == levelUpgrade


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")

func _on_max_shild_upgrade_button_pressed() -> void:
	GC.playerMaxShield = 1 + GC.sett

func _on_max_velocity_upgrade_button_pressed() -> void:
	GC.playerMaxVelocity = 200 + GC.settingPlayerMaxVelocity * 40

func _on_accelleration_upgrade_button_pressed() -> void:
	GC.playerAccel = 400 + (GC.settingPlayerAccel * 110)

func _on_bullet_velocity_upgrade_button_pressed() -> void:
	GC.bulletVelocity = 300 + (GC.settingBulletVelocity * 100)

func _on_bullet_per_fire_upgrade_button_pressed() -> void:
	pass # Replace with function body.

func _on_auto_fire_upgrade_button_pressed() -> void:
	pass # Replace with function body.

func _on_drop_value_upgrade_button_pressed() -> void:
	GC.bulletVelocity = 1 + GC.settingBulletVelocity

func _on_drop_velocity_upgrade_button_pressed() -> void:
	GC.dropVelocity = 0 + (GC.settingDropVelocity * 100)
