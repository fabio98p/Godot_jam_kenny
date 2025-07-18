extends Control


@onready var button_start: Button = $ButtonStart
@onready var button_exit: Button = $ButtonExit

func _on_button_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Level1.tscn")

func _on_button_power_up_pressed() -> void:
	#potenzia in qualche modo la nave
	pass # Replace with function body.

func _on_button_exit_pressed() -> void:
	get_tree().quit()
