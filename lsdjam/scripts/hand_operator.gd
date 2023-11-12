extends Node3D

var hand_moving = Vector2.ZERO
var hand_speed = 20.0
var hand_sprite

var choosen_sweet = null
var sweets_list = []
# Called when the node enters the scene tree for the first time.
func _ready():
	hand_sprite = get_node("Hand/HandSprite")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	hand_moving = lerp(hand_moving, Vector2.ZERO, 0.1)
	$Hand.linear_velocity = Vector3(hand_moving.x, -hand_moving.y, 0) * delta
	if hand_moving.x == 0:
		$Hand.linear_velocity.x = lerp($Hand.linear_velocity.x, 0.0, 0.2)
	if hand_moving.y == 0:
		$Hand.linear_velocity.y = lerp($Hand.linear_velocity.y, 0.0, 0.2)
	
	if choosen_sweet:
		print(choosen_sweet.position)

# манипуляции рукой
func _input(event):
	if event is InputEventMouseMotion:
		hand_moving = event.relative
		hand_moving = hand_moving.normalized() * hand_speed
	if event is InputEventMouseButton and event.button_index == 1:
		hand_sprite.frame = ! bool(hand_sprite.frame)
		
		if event.is_pressed():
			if sweets_list:
				choosen_sweet = sweets_list.pick_random()
				var new_sweet = choosen_sweet.duplicate()
				choosen_sweet.queue_free()
				choosen_sweet = new_sweet
		
		else:
			if choosen_sweet:
				var new_pos = get_node("Hand").position
				new_pos.y -= 0.3
				choosen_sweet.position = new_pos
				add_child(choosen_sweet)
				choosen_sweet = null


func _on_palm_zone_sweet_entered(sweet):
	sweets_list.append(sweet)


func _on_palm_zone_sweet_exited(sweet):
	sweets_list.erase(sweet)
