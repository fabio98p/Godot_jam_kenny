extends Node2D

@onready var button: Button = $Button
@onready var panel: Panel = $Panel
@onready var button_icon: Sprite2D = $ButtonIcon
@onready var descriptionLabel: Label = $Description
@onready var price: Label = $Price
@onready var star_medium: Sprite2D = $StarMedium

@export var icon: String = "res://Assets/kenney_cursor-pack/PNG/Basic/Default/steps.png"
@export var how_many_click_i_can_do: float = 10
@export var description: String = "test"
@export var priceInitial: int = 50
@export var priceAddNextLevel: int = 50

var currentPrice: int
var howManyTimePressButton: int = 0

signal button_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(Callable(self, "_on_button_pressed"))
	
	button_icon.texture = load(icon)
	descriptionLabel.text = description
	
	currentPrice = priceInitial
	price.text = str(currentPrice)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	howManyTimePressButton += 1
	if howManyTimePressButton <= how_many_click_i_can_do: 
		button_pressed.emit(currentPrice, howManyTimePressButton)
		# menage green part of button
		GC.settingPlayerMaxVelocity += 1
		panel.size.y += (36 / how_many_click_i_can_do)
		panel.position.y -= (36 / how_many_click_i_can_do)
		
		#update price
		currentPrice += priceAddNextLevel
		price.text = str(currentPrice)
		
		if howManyTimePressButton == how_many_click_i_can_do:
			price.text = "Max"
			star_medium.visible = false



func _on_button_mouse_entered() -> void:
	descriptionLabel.visible = true


func _on_button_mouse_exited() -> void:
	descriptionLabel.visible = false
