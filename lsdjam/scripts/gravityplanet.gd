extends Node3D



# фут клан указывает на ноги персонажа
# камера мэн сам персонаж
# камера нод - холдер обоих камер
var foot_clan
var camera_man
var camera_node
# Called when the node enters the scene tree for the first time.
func _ready():
	foot_clan = get_node("../CameraMan/FootPoint")
	camera_man = get_node("../CameraMan")
	camera_node =  get_node("../CameraMan/CameraHolder")

# планета вертит протагониста
func _process(delta):
	
	foot_clan.rotation = self.position.direction_to(camera_man.position)
	
	#camera_man.rotation = foot_clan.rotation
	camera_man.set_up_direction(foot_clan.rotation)
	camera_man.GravityVector = foot_clan.rotation
	camera_man.get_node("CollisionShape3D").rotation = foot_clan.rotation
