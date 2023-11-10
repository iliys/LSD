extends RigidBody3D

var random_machine = RandomNumberGenerator.new()

@export var move_range = 3
@export var wait_time = 1

var dialog_lines_counter = 0

func _physics_process(delta):
	pass
	
	
func random_vector(min, max):
	var xyz = [0, 0, 0]
	for i in range(3):
		xyz[i] = random_machine.randf_range(min, max)
	return Vector3(xyz[0], xyz[1], xyz[2])
	
func _on_dialog_timer_timeout():
	$DialogProjection.visible = false

func _on_walking_timer_timeout():
	linear_velocity = random_vector(-move_range, move_range)
	$WalkingTimer.set_wait_time(wait_time)
	
	dialog_lines_counter += 1


func _on_input_event(camera, event, position, normal, shape_idx):
	
	$DialogProjection.visible = true
	$DialogTimer.start()
	$WalkingTimer.set_wait_time(0.1)



