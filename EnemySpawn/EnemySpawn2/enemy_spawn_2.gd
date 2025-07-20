extends Node2D

@export var spawn_radius : float = 300.0

@export var enemy_to_spawn : PackedScene
var can_spawn:bool

var initial_spawn_positions = {
	"top_left": Vector2(-100, -100), 
	"top_right": Vector2(1300, -100), 
	"bottom_left": Vector2(-100, 700), 
	"bottom_right": Vector2(1300, 700)  
}

var corner_positions = {
	"top_left": Vector2(50, 50),
	"top_right": Vector2( 1120, 50),
	"bottom_left": Vector2(50,  600),
	"bottom_right": Vector2( 1120, 600)
}

var angolo_nemici = {
	"top_left": false,
	"top_right": false,
	"bottom_left": false,
	"bottom_right": false
}

@export var spawn_rate: float = 1

func _ready() -> void:
	can_spawn = false
	spawn_enemy_loop()


func _process(delta: float) -> void:
	pass
	
func spawn_enemy_loop():
	while true:
		await get_tree().create_timer(spawn_rate).timeout
		if can_spawn:
			spawn_enemy_to_corner()
		
func spawn_enemy_to_corner():
	var available_corners = []
	for corner_name in angolo_nemici:
		if not angolo_nemici[corner_name]:
			available_corners.append(corner_name)

	if available_corners.is_empty():
		print("Tutti gli angoli sono occupati. Impossibile spawnare.")
		return

	var chosen_corner_name = available_corners[randi() % available_corners.size()]
	var target_position = corner_positions[chosen_corner_name]

	var new_enemy = enemy_to_spawn.instantiate()
	new_enemy.global_position = initial_spawn_positions[chosen_corner_name]
	var tween = new_enemy.create_tween()
	tween.tween_property(new_enemy, "global_position", target_position, 1.0)
	
	get_parent().add_child(new_enemy)
	
	new_enemy.set_assigned_corner(chosen_corner_name)

	# 2. Connetti il segnale 'enemy_died' del nemico a una funzione in questo script
	# Assicurati che "enemy_died" sia il nome esatto del segnale definito nel tuo script del nemico
	new_enemy.connect("enemy_died", on_enemy_died)

	angolo_nemici[chosen_corner_name] = true

func on_enemy_died(corner_name_param: String):
	if angolo_nemici.has(corner_name_param):
		angolo_nemici[corner_name_param] = false
