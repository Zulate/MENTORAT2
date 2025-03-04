extends CharacterBody3D


const SPEED = 2.5
const JUMP_VELOCITY = 2.5


func _physics_process(delta: float) -> void:
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
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	$"../mesh-instancer-gras".set("instance_shader_parameters/player_position", position + Vector3(0, -0.1, 0))
# position 1 -> self.position = Vector3(5, 4, 9.5);



func _on_arearight_body_entered(_body: CharacterBody3D) -> void:
	$"../Camera3D".position = Vector3(12.5, 4, 9.5);

func _on_arealeft_body_entered(_body: CharacterBody3D) -> void:
	$"../Camera3D".position = Vector3(5, 4, 9.5);

func _on_entergrasslevel_body_entered(_body: CharacterBody3D) -> void:
	get_tree().change_scene_to_file("res://grass-map.tscn");

func _on_enterredlevel_body_entered(_body: CharacterBody3D) -> void:
	get_tree().change_scene_to_file("res://red.tscn");
