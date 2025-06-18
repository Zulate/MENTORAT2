extends Node3D

@onready var outline_material = load("res://materials/outline_material.tres")
@onready var insideLight : bool = false
@onready var fin_val : Vector3 = $".".rotation_degrees

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("KeyF") && insideLight == true:
		fin_val += Vector3(0, 45, 0)
		rotate_light()
		insideLight = false
		await get_tree().create_timer(2.0).timeout
		insideLight = true
		fin_val = $".".rotation_degrees
		print($".".rotation_degrees)

func rotate_light() -> void:
	var tween_light = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween_light.tween_property($".", "rotation_degrees", fin_val, 2.0)

func _on_area_3d_body_entered(_body: Node3D) -> void:
	$Lampe.material_overlay = outline_material
	insideLight = true

func _on_area_3d_body_exited(_body: Node3D) -> void:
	$Lampe.material_overlay = null
	insideLight = false
