extends Node3D

@onready var material = get_node("Plane").get_surface_override_material(0)
@onready var rng = RandomNumberGenerator.new()
@onready var timer = Timer.new()
const delay : float = 2.0
@onready var my_random_number : float = rng.randf_range(0.0, 1.0)

func _ready() -> void:
	add_child(timer)
	timer.wait_time = delay
	timer.one_shot = false
	timer.connect("timeout", timer_timeout)
	timer.start()
	material.emission_energy_multiplier = 0.0

func timer_timeout() -> void:
	my_random_number = rng.randf_range(0.0, 1.0)
	material.emission_energy_multiplier = my_random_number
