extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = Vector3(0, 0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_node("../../../Cameraman").position)
