extends Node2D

@onready var drop: Label = $Drop
@onready var timer: Node2D = $Timer
@onready var player_ship: CharacterBody2D = $PlayerShip
@onready var ui_shield: Sprite2D = $"UI shield"
@onready var ui_shield_2: Sprite2D = $"UI shield2"
@onready var enemy_spawn: Node2D = $EnemySpawn
@onready var enemy_spawn_2: Node2D = $EnemySpawn2
@onready var enemy_spawn_3: Node2D = $EnemySpawn4

@export var shield_textures: Array[Texture2D]

func _ready() -> void:
	timer.start_timer()
	player_ship.can_move = true
	GC.currentShield = GC.playerMaxShield
	

func _process(delta: float) -> void:
	drop.text = str( GC.collectedDrop )
	setUiShield()
	difficultyIncrese()
		

func difficultyIncrese():
	enemy_spawn.can_spawn = true
	await get_tree().create_timer(20).timeout
	enemy_spawn_2.can_spawn = true
	await get_tree().create_timer(40).timeout
	enemy_spawn_3.can_spawn = true
		
		
func setUiShield():
	var currentShield = GC.currentShield

	var max_base_shield = shield_textures.size() - 1

	if currentShield <= max_base_shield:
		# se lo scudo è nei limiti del primo indicatore (0-4)
		if currentShield >= 0:
			ui_shield.texture = shield_textures[currentShield]
		else:
			# se per qualche motivo currentShield è negativo ah boh
			ui_shield.texture = shield_textures[0] 
		ui_shield_2.visible = false
	else:
		# se lo scudo è superiore a al maxshield
		ui_shield_2.visible = true 

		# calcola lo scudo per il primo indicatore (sarà sempre il massimo, cioè 4)
		ui_shield.texture = shield_textures[max_base_shield] # Sempre la texture "piena" per il primo indicatore

		# prendo e calcol lo scudo "residuo" per il secondo indicatore
		# esempio per te fabio che non capisci: se currentShield è 5, allora 5 - (4 + 1) = 0. In questo caso, lo scudo è 1 per il secondo indicatore.
		# O il modulo per ripartire da 1
		var second_indicator_value = (currentShield - (max_base_shield + 1)) % (max_base_shield + 1)

		if second_indicator_value >= 0 and second_indicator_value < shield_textures.size():
			ui_shield_2.texture = shield_textures[second_indicator_value]
		else:
			
			ui_shield_2.texture = shield_textures[0] # O una texture di default		
