extends CanvasLayer

const CHAR_READ_RATE = 0.1

@onready var DialogueBox = $DialogueBox
@onready var start_symbol = $DialogueBox/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $DialogueBox/MarginContainer/HBoxContainer/End
@onready var label = $DialogueBox/MarginContainer/HBoxContainer/Label

var tween = create_tween()

func _ready() -> void:
	hide_textbox()
	add_text(StaticData.textData["denialDialogue"]["cube_dialogue_1"])

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	DialogueBox.hide()

func show_textbox():
	start_symbol.text = "*"
	DialogueBox.show()
	end_symbol.text = "v"
	

func add_text(next_text):
	label.text = next_text
	show_textbox()
	tween.tween_property(label, "visible_ratio", 1.0, len(next_text) * CHAR_READ_RATE)
	tween.play()
	tween.finished.connect(func() -> void: )
