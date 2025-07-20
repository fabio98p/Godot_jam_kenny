extends Node2D

@export var spawn_radius : float = 700.0

@export var enemy_to_spawn : PackedScene

@export var spawn_rate: float = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_enemy_loop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawn_enemy_loop():
	while true:
		await get_tree().create_timer(spawn_rate).timeout
		spawn_enemy_on_circumference()

func spawn_enemy_on_circumference():

	var new_enemy = enemy_to_spawn.instantiate()

	# Genera un angolo randomico completo (da 0 a 2*PI radianti)
	var angle = randf() * TAU # TAU è una costante di GDScript equivalente a 2 * PI

	# Calcola la posizione randomica usando coordinate polari
	# Il raggio è fisso a 'spawn_radius' per rimanere sulla circonferenza
	var random_x = cos(angle) * spawn_radius
	var random_y = sin(angle) * spawn_radius

	# La posizione randomica è relativa alla global_position del nodo CircumferenceSpawner
	new_enemy.global_position = global_position + Vector2(random_x, random_y)

	# Aggiunge il nuovo oggetto all'albero della scena
	# Potrebbe essere il nodo padre dello spawner, o un nodo specifico per i nemici
	get_parent().add_child(new_enemy)
	print("Spawnato nemico a: ", new_enemy.global_position)
