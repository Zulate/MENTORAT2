extends CanvasLayer

@onready var CHAR_READ_RATE = 0.1

enum State{
	READY,
	READING,
	FINISHED
}

@onready var tween
var dialogue_queue: Array = []
var dialogue_index: int = 0

@onready var current_state = State.READY

@onready var DialogueBox = $DialogueBox
@onready var start_symbol = $DialogueBox/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $DialogueBox/MarginContainer/HBoxContainer/End
@onready var label = $DialogueBox/MarginContainer/HBoxContainer/Label

func _ready() -> void:
	print("Starting state: State.READY")
	hide_textbox()
	var lines = [
		StaticData.textData["start_dialogue"]["start_dialogue_1"],
		StaticData.textData["start_dialogue"]["start_dialogue_2"],
		StaticData.textData["start_dialogue"]["start_dialogue_3"],
		StaticData.textData["start_dialogue"]["start_dialogue_4"],
		StaticData.textData["start_dialogue"]["start_dialogue_5"],
		StaticData.textData["start_dialogue"]["start_dialogue_6"]
	]
	start_dialogue(lines)

func _process(_delta):
	match current_state:
		State.READY:
			pass
		State.READING:
			GlobalVariables.Speed = 0
			if Input.is_action_just_pressed("enter"):
				label.visible_ratio = 1
				tween.stop()
				end_symbol.text = "v"
				change_state(State.FINISHED)
				
		State.FINISHED:
			if Input.is_action_just_pressed("enter"):
				tween.stop()
				dialogue_index += 1
				change_state(State.READING)
				show_next_line()

func hide_textbox() -> void:
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	DialogueBox.hide()

func show_textbox() -> void:
	start_symbol.text = "*"
	DialogueBox.show()

func add_text(next_text) -> void:
	label.text = next_text
	change_state(State.READING)
	show_textbox()
	tween.tween_property(label, "visible_ratio", 1.0, len(next_text) * CHAR_READ_RATE)
	tween.play()
	tween.tween_callback(_on_tween_finished)
	

func _on_tween_finished() -> void:
	end_symbol.text = "v"
	change_state(State.FINISHED)

func change_state(next_state) -> void:
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing State to: State_READY")
		State.READING:
			print("Changing State to: State_READING")
		State.FINISHED:
			print("Changing State to: State_FINISHED")

func show_next_line():
	if dialogue_index < dialogue_queue.size():
		var next_text = dialogue_queue[dialogue_index]
		label.text = next_text
		label.visible_ratio = 0
		change_state(State.READING)
		show_textbox()
		
		tween = create_tween()
		tween.tween_property(label, "visible_ratio", 1.0, next_text.length() * CHAR_READ_RATE)
		tween.tween_callback(_on_tween_finished)
	else:
		# All lines done
		hide_textbox()
		GlobalVariables.Speed = 2.5
		change_state(State.READY)

func start_dialogue(text_list: Array) -> void:
	dialogue_queue = text_list
	dialogue_index = 0
	show_next_line()

func _on_textactivator_body_entered(_body: CharacterBody3D) -> void:
	var lines = [
		StaticData.textData["denialDialogue_1"]["cube_dialogue_1"],
		StaticData.textData["denialDialogue_1"]["cube_dialogue_2"]
	]
	start_dialogue(lines)
