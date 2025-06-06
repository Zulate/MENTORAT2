extends CharacterBody3D

const JUMP_VELOCITY = 2.5
@onready var Findicator = $"../pressFIndicator"

func _physics_process(delta: float) -> void:
	var SPEED = GlobalVariables.Speed
	$"../pressFIndicator".position = position + Vector3(-0.05, 0.7, 0)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED * 2
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	if(GlobalVariables.Trigger == false):
		move_and_slide()
		GlobalVariables.player_position = position + Vector3(0, -0.1, 0)
	elif (GlobalVariables.Trigger == true):
		pass
		
	if GlobalVariables.pressFdisplay == true:
		Findicator.visible = true
	else:
		Findicator.visible = false
# position 1 -> self.position = Vector3(5, 4, 9.5);

func _on_canvas_layer_stop_movement() -> void:
	GlobalVariables.Trigger = true
