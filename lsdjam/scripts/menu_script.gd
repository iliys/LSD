extends Control

var is_dream_started = false

var exit_on = false
var ExitTimer = null
var current_volume = 0

signal dream_started

# предварительная настройка кнопок
func _ready():
	get_node("ButtonsContainer/NewDreamButton").disabled = false
	get_node("ButtonsContainer/ContinueButton").disabled = true
	get_node("ButtonsContainer/OptionsButton").disabled = true
	
	get_node("OptionsContainer/VolumeSlider").value = remap(AudioServer.get_bus_volume_db(0), -30, 3 , 0, 100)
	#get_node("OptionsContainer/FullscreenButton")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if exit_on:
		turn_off_music(ExitTimer.time_left)


func volume_remap(value):
	value = remap(value, 0, 100, -30, 3)
	return value
	

func turn_off_music(time):
	var decibels = clamp(-1/time, -72, current_volume)
	AudioServer.set_bus_volume_db(0, decibels)


func _on_new_dream_button_pressed():
	emit_signal("dream_started")
	get_parent().emit_signal("start_dream")

func _on_continue_button_pressed():
	get_parent().emit_signal("menu_toggle")



func _on_exit_button_pressed():
	get_node("ButtonsContainer/ExitButton").disabled = true
	
	exit_on = true
	ExitTimer = get_tree().create_timer(1)
	await ExitTimer.timeout
	get_tree().quit()


func _on_dream_started():
	get_node("ButtonsContainer/NewDreamButton").disabled = true
	get_node("ButtonsContainer/ContinueButton").disabled = false
	$ColorRect.queue_free()


func _on_volume_slider_value_changed(value):
	current_volume = volume_remap(value)
	AudioServer.set_bus_volume_db(0, current_volume)


func _on_fullscreen_button_button_down():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_fullscreen_button_button_up():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
