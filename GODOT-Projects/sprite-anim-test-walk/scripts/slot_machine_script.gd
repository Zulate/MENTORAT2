extends Node3D

@onready var material = get_node("Plane").get_surface_override_material(0)
@onready var timer = Timer.new()
const delay : float = 0.5

func _ready() -> void:
	add_child(timer)
	timer.wait_time = delay
	timer.one_shot = false
	timer.connect("timeout", timer_timeout)
	timer.start()
	material.emission_energy_multiplier = 0.0

func timer_timeout() -> void:
	GlobalVariables.generate_random_number()
	material.emission_energy_multiplier = GlobalVariables.my_random_number
