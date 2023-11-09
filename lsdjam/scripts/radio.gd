extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			print("mouse")
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_knob_area_input_event(camera, event, position, normal, shape_idx):
	fm_up(0.1)
	print("здраститя")

func fm_up(value):
	var currentfreq = get_node("SubViewport/Frequency").text
	get_node("SubViewport/Frequency").text = str(float(currentfreq) + value)
