extends CanvasLayer

var CHAR_READ_RATE = 0.1

@onready var DialogueBox = $DialogueBox
@onready var start_symbol = $DialogueBox/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $DialogueBox/MarginContainer/HBoxContainer/End
@onready var label = $DialogueBox/MarginContainer/HBoxContainer/Label

enum State{
	READY,
	READING,
	FINISHED
}

var tween = create_tween()

var current_state = State.READY

func _ready() -> void:
	print("Starting state: State.READY")
	hide_textbox()
	add_text(StaticData.textData["denialDialogue"]["spirit_dialogue_1"])

func _process(_delta):
	match current_state:
		State.READY:
			pass
		State.READING:
			pass
		State.FINISHED:
			if Input.is_action_just_pressed("enter"):
				hide_textbox()

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	DialogueBox.hide()

func show_textbox():
	start_symbol.text = "*"
	DialogueBox.show()

func add_text(next_text):
	label.text = next_text
	change_state(State.READING)
	show_textbox()
	tween.tween_property(label, "visible_ratio", 1.0, len(next_text) * CHAR_READ_RATE)
	tween.play()
	tween.tween_callback(_on_tween_finished)
	

func _on_tween_finished():
	end_symbol.text = "v"
	change_state(State.FINISHED)

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing State to: State_READY")
		State.READING:
			print("Changing State to: State_READING")
		State.FINISHED:
			print("Changing State to: State_FINISHED")
