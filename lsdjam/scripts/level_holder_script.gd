extends Node3D


# холдер нужен чтобы плавно переключать уровни через какие-нибудь анимации, переходы и тд
# это главная нода, из которой будет запускаться игра


# выбор сцены для запуска, по умолчанию это МЕНЮ
@export_file("*.tscn") var start_scene = "res://mesta/mesto_02_mirror.tscn"

var current_scene = null
var current_level_name

signal menu_toggle(turn_on)
signal start_dream()
signal change_scene(next_scene)

func _ready():
	pass

func _process(delta):
	
	if Input.is_action_just_released("menu") and current_scene != null:
		emit_signal("menu_toggle")

func _input(event):
	pass
	#if Input.mouse_mode == Input.MOUSE_MODE_CONFINED:
	#	Input.warp_mouse($MouseZone.position)

# функция создания сцены и удаления (если есть) текущей
func scene_instance(next_scene):
	var new_scene = load(next_scene)
	new_scene = new_scene.instantiate()
	add_child(new_scene)
	
	if current_scene:
		current_scene.queue_free()
	current_scene = new_scene
	current_level_name = new_scene.name
	$LevelName.text = current_level_name # для удобства тут отображается название сцены


# пока заглушка для перехода с транзишеном
func _on_change_scene(next_scene):
	print("baka")
	scene_instance(next_scene)


# начало игры
func _on_start_dream():
	scene_instance(start_scene)
	emit_signal("menu_toggle")


# переключение менюшки, захват мыши и пауза сцены, если загружена сцена
# MouseZone нужен, чтобы считывать положение мыши в Captured моде
func _on_menu_toggle():
	$Menu.visible = !$Menu.visible
	if $Menu.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		if current_scene:
			get_tree().paused = true
	else:
		#Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		get_tree().paused = false
	
	
	
