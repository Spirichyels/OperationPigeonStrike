extends CharacterBody3D



@export
var movementSpeed: float = 10;
@export
var jumpVelocity: float = 300;
@export
var gravitySpeed: float = 20;
@export
var mouseSensitivity: float = 0.5;

var movementInputVector:Vector2=Vector2(0,0);
var currentyYVeljcity: float = 0;



@onready var camera = $Camera3D
var mouse_sensitivity: float = 0.2
var camera_pitch: float = 0.0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Горизонталь — вращаем тело игрока
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		
		
		# Вертикаль — вращаем только камеру (ограничиваем угол)
		camera_pitch = clamp(camera_pitch - event.relative.y * mouse_sensitivity, -80, 80)
		camera.rotation_degrees.x = camera_pitch


func _physics_process(delta: float) -> void:
	movementInputVector = Input.get_vector("move_left", "move_right", "move_forward", "move_back") * movementSpeed
	if is_on_floor():
		currentyYVeljcity = 0;
		if Input.is_action_just_pressed("jump"):
			print("jump ")
			currentyYVeljcity - jumpVelocity
	else:
		currentyYVeljcity = maxf(currentyYVeljcity - gravitySpeed, -2000);
		
	velocity = transform.basis * Vector3(movementInputVector.x, currentyYVeljcity, movementInputVector.y);
	
	move_and_slide()
