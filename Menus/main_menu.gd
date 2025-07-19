extends Control

@onready var star_container: Node2D = $StarContainer
@onready var star: Sprite2D = $StarContainer/Star

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var button_start: Button = $ButtonStart
@onready var button_exit: Button = $ButtonExit
var totalDrop: int
var newScale

func _ready() -> void:
	newScale=star_container.scale.x+GC.totalDrop/60
	star_container.scale = Vector2(newScale, newScale)
	star.texture = load(GC.setDimensionAndSpriteStar())
	

func _on_button_start_pressed() -> void:
	animation_player.play("PlayerStartGame")
	await get_tree().create_timer(5).timeout 
	get_tree().change_scene_to_file("res://Levels/Level1.tscn")

func _on_button_power_up_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/upgrade_menu.tscn")

func _on_button_exit_pressed() -> void:
	get_tree().quit()

func _process(delta: float) -> void:
	star
