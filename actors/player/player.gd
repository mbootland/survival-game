extends CharacterBody3D

@export var NORMAL_SPEED := 5.0
@export var SPRINT_SPEED := 10.0
@export var JUMP_VELOCITY := 4.5
@export var GRAVITY := 0.2
@export var MOUSE_SENSITIVITY := 0.005

@onready var head: Node3D = $Head
@onready var interaction_raycast: RayCast3D = $Head/InteractionRaycast



func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Equivelent to update
func _process(_delta: float) -> void:
	interaction_raycast.check_interaction()
	
#Equivelent to fixed_update
func _physics_process(_delta: float) -> void:
	move()
	
func move() -> void:
	var is_sprinting : bool
	if is_on_floor():
		is_sprinting = Input.is_action_pressed("sprint")
		
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
	else:
		velocity.y -= GRAVITY
		is_sprinting = false
	
	
	var speed := NORMAL_SPEED if not is_sprinting else SPRINT_SPEED
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	
	velocity.z = direction.z * speed
	velocity.x = direction.x * speed
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_around(event.relative)
		
func look_around(relative : Vector2) -> void:
	rotate_y(-relative.x * MOUSE_SENSITIVITY)
	head.rotate_x(-relative.y * MOUSE_SENSITIVITY)
	head.rotation_degrees.x = clampf(head.rotation_degrees.x, -90, 90)
	
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	elif event.is_action_pressed("open_crafting_menu"):
		EventSystem.BUL_create.emit(BulletinConfig.Keys.CraftingMenu)
