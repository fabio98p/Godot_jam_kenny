extends Node2D

@onready var timer_label: Label = $TimerLabel

var elapsed_time: float = 0.0
var is_running: bool = false

func _process(delta: float):
	if is_running:
		elapsed_time += delta
		update_timer_display()

func update_timer_display():
	var minutes: int = int(elapsed_time / 60)
	var seconds: int = int(fmod(elapsed_time, 60))
	var milliseconds: int = int(fmod(elapsed_time * 100, 100))

	# MM:SS.mm
	timer_label.text = "%02d:%02d.%02d" % [minutes, seconds, milliseconds]

func start_timer():
	is_running = true

func stop_timer():
	is_running = false

func reset_timer():
	elapsed_time = 0.0
	is_running = false 
	update_timer_display()
