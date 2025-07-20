extends Control

@onready var star_container: Node2D = $StarContainer
@onready var star: Sprite2D = $StarContainer/Star

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var animation_feed_star: Node2D = $AnimationFeedStar

@onready var button_start: Button = $ButtonStart
@onready var button_exit: Button = $ButtonExit
var totalDrop: int
var newScale

func _ready() -> void:
	newScale=star_container.scale.x+GC.totalDrop/600
	star_container.scale = Vector2(newScale, newScale)
	#star.texture = load(GC.setDimensionAndSpriteStar())
	animation_feed_star.num_sprites_to_spawn = GC.collectedDrop
	GC.setTotalDrop()
	await get_tree().create_timer(2).timeout 
	animation_feed_star.start_animation()
	
func _on_button_start_pressed() -> void:
	animation_player.play("PlayerStartGame")
	await get_tree().create_timer(1.6).timeout 
	get_tree().change_scene_to_file("res://Levels/Level1.tscn")

func _on_button_power_up_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/upgrade_menu.tscn")

func _on_button_exit_pressed() -> void:
	get_tree().quit()

func _process(delta: float) -> void:
	if GC.starAnimation:
		await get_tree().create_timer(2).timeout 
		star.texture = load(GC.setDimensionAndSpriteStar())
