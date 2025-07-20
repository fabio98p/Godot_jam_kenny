extends Node2D

@export var animated_sprite_scene: PackedScene # Assegna qui la scena AnimatedSprite.tscn
@export var spawn_point_a: Vector2 = Vector2(100, 100) # Punto di partenza per gli sprite
@export var spawn_point_b: Vector2 = Vector2(700, 500) # Punto di arrivo per gli sprite
@export var movement_duration: float = 2.0    # Durata del movimento di ogni sprite in secondi
@export var random_offset_range: float = 50.0 # Forza della casualità (in pixel) per la traiettoria
var num_sprites_to_spawn: int = 10     # Quanti sprite generare

func _ready():
	# Inizializza il generatore di numeri casuali una sola volta all'avvio del gioco.
	# Cruciale per avere animazioni diverse ad ogni esecuzione.
	randomize()

	# Avvia l'animazione quando la scena è pronta.

func start_animation():
	if animated_sprite_scene == null:
		print("Errore: la scena AnimatedSprite non è stata assegnata nell'Inspector.")
		return

	for i in range(num_sprites_to_spawn):
		# Istanzia una nuova copia della scena AnimatedSprite
		var sprite_instance = animated_sprite_scene.instantiate()
		# Aggiungi lo sprite come figlio di questo manager.
		# Questo lo rende parte della scena e visibile.
		add_child(sprite_instance)

		# Applica un leggero offset casuale anche al punto di partenza.
		# Questo evita che tutti gli sprite partano esattamente dallo stesso pixel.
		var start_offset = Vector2(
			randf_range(-10, 10),
			randf_range(-10, 10)
		)
		var actual_start_point = spawn_point_a + start_offset

		# Avvia il movimento per lo sprite corrente.
		sprite_instance.start_movement(actual_start_point, spawn_point_b, movement_duration, random_offset_range)

		# Aggiunge un breve ritardo casuale tra lo spawn di ogni sprite.
		# Crea un effetto di "scia" o "arrivo graduale".
		await get_tree().create_timer(randf_range(0.005, 0.02)).timeout
