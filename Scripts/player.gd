extends CharacterBody3D

@onready var health_bar: ProgressBar = $CanvasLayer/healthBar
@onready var health_label: Label = $CanvasLayer/healthLabel

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var max_health :float = 100.0
var current_health :float = max_health

func _ready() -> void:
	update_health_bar()


func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func update_health_bar()->void:
	health_bar.value = current_health
	health_label.text = str(current_health)+ "/" + str(max_health) 
	
	
func take_damage(damage:float):
	print("damage taken")
	current_health -=damage
	update_health_bar()
