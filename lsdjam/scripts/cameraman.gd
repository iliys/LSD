extends CharacterBody3D

@export_category("CameraMan")
@export_group("CameraManParam")
@export var SPEED = 3.0
@export var cam_speed = 2.0
@export var JUMP_VELOCITY = 4.5

# запреты и разрешения устанавливаемые в конкретной локации
@export_group("CameraManRules")
#@export var caninteracthere = true
#@export var canspeakhere = true
@export var canjumphere = true
@export var canchangecamera = true

var mouse_input = Vector2()
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var GravityVector = Vector3.UP

const FPSCAM = "CameraHolder/FirstPersonCamera"
const TPSCAM = "CameraHolder/ThirdPersonCamera"

func _physics_process(delta):
	if not is_on_floor():
		#velocity.y -= gravity * delta
		velocity -= gravity * delta * (GravityVector)
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and canjumphere:
		#velocity.y = JUMP_VELOCITY
		velocity = JUMP_VELOCITY * GravityVector
		


	var input_updown = Input.get_axis("ui_up", "ui_down")
	var input_side = Input.get_axis("ui_left", "ui_right")
	
	var mouse_input = Input.get_last_mouse_velocity()
	var cam_rotation = -mouse_input * delta * 0.005
	
	$CameraHolder.rotate_y(cam_rotation.x)
	$CameraHolder.rotation.x =	clamp($CameraHolder.rotation.x + cam_rotation.y, -0.5, 0.15)
	$AnimatedSprite3D.rotation.y = $CameraHolder.rotation.y
	
	if Input.is_action_just_pressed("camera") and canchangecamera:
		get_node(FPSCAM).current = get_node(TPSCAM).current
		get_node(TPSCAM).current = !get_node(FPSCAM).current
	
	var direction = ($CameraHolder.transform.basis * transform.basis * Vector3(input_side, 0, input_updown)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
