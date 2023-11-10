extends Node3D

signal radio_active_on
signal radio_active_off

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_knob_area_input_event(camera, event, position, normal, shape_idx):
	fm_up(0.1)

func fm_up(value):
	var currentfreq = get_node("SubViewport/Frequency").text
	get_node("SubViewport/Frequency").text = str(float(currentfreq) + value)
	get_node("CSGCombiner3D/Knob").rotate_x(0.05)
