extends Path3D

var speed = 0.5
var object_to_follow
var camera
# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node("PathFollow3D/Camera3D")
	object_to_follow = get_node("../../Jar")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera.look_at(object_to_follow.position)
	
	if Input.is_action_pressed("ui_up") and $PathFollow3D.progress_ratio < 0.99:
		$PathFollow3D.progress += speed * delta
	elif Input.is_action_pressed("ui_down") and $PathFollow3D.progress_ratio > 0.01:
		$PathFollow3D.progress -= speed * delta
