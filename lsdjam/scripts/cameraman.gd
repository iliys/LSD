extends CharacterBody3D

@export var SPEED = 3.0
@export var cam_speed = 2.0
@export var JUMP_VELOCITY = 4.5

var mouse_input = Vector2()
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		


	var input_updown = Input.get_axis("ui_up", "ui_down")
	var input_side = Input.get_axis("ui_left", "ui_right")
	
	var mouse_input = Input.get_last_mouse_velocity()
	var cam_rotation = -mouse_input * delta * 0.005
	
	$CameraHolder.rotate_y(cam_rotation.x)
	$CameraHolder.rotation.x =	clamp($CameraHolder.rotation.x + cam_rotation.y, -0.5, 0.15)
	$AnimatedSprite3D.rotation.y = $CameraHolder.rotation.y
	
	var direction = ($CameraHolder.transform.basis * transform.basis * Vector3(input_side, 0, input_updown)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
		
	

	move_and_slide()
