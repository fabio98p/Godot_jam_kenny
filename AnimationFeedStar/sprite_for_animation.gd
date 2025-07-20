extends Sprite2D

# Questo Tween gestirà l'animazione di movimento dello sprite
var movement_tween: Tween

# Funzione per avviare il movimento dello sprite
func start_movement(start_position: Vector2, end_position: Vector2, duration: float, random_offset_strength: float):
	# Imposta la posizione iniziale dello sprite
	global_position = start_position

	# Calcola un offset casuale per la destinazione finale.
	# Questo è il segreto per le traiettorie non lineari e "carine".
	var random_offset = Vector2(
		randf_range(-random_offset_strength, random_offset_strength),
		randf_range(-random_offset_strength, random_offset_strength)
	)
	var final_destination = end_position + random_offset

	# Crea un nuovo Tween o ne riutilizza uno esistente.
	# Se il tween precedente è ancora attivo, lo ferma.
	if movement_tween:
		movement_tween.kill()
	movement_tween = create_tween()

	# Anima la proprietà 'global_position' dello sprite dal punto di partenza al punto finale.
	movement_tween.tween_property(self, "global_position", final_destination, duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)

	# Quando l'animazione è completata, il nodo si auto-elimina dall'albero della scena.
	movement_tween.finished.connect(queue_free)
