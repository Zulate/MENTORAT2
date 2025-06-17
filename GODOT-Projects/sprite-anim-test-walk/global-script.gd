extends Node

#preloading scenes
#@onready var spirit_character = preload("res://scenes/spirit-character.tscn")
@onready var scene_transition = preload("res://scenes/scene_transition_animation.tscn")

#global variables
@onready var player_position
@onready var Speed : float = 2.5
@onready var Trigger : bool = false

@onready var insideGate : bool = false

#denial scene
@onready var insideFragment1 : bool = false
@onready var insideFragment2 : bool = false
@onready var insideFragment3 : bool = false
@onready var fragmentsCollected : float = 0
@onready var denialDialogue1Status : bool = false
@onready var denialDialogue2Status : bool = false

#anger scene
@onready var insidePillar : bool = false
@onready var insideTriangle : bool = false
@onready var insideSphere : bool = false
@onready var angerDialogue1Status : bool = false
@onready var angerDialogue2Status : bool = false
@onready var insideAngerSphere : bool = false
@onready var angerBetweenStatus : bool = false

#bargaining scene

@onready var insideCoin : bool = false
@onready var insideLetter : bool = false
@onready var insideMirror : bool = false
@onready var promisesCollected : float = 0
@onready var bargainingStatus1 : bool = false

#depression scene

@onready var weightStatus : bool = false
@onready var insideWeight : bool = false




@onready var pressFdisplay : bool = false

@onready var rng = RandomNumberGenerator.new()
@onready var my_random_number : float = rng.randf_range(0.0, 1.0)

func _ready() -> void:
	pass

func camera_transition(node, property, fin_val, duration):
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(node, property, fin_val, duration)

func generate_random_number() -> void:
	my_random_number = floor(rng.randf_range(0.0, 5.0))
