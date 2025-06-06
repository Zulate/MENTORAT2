extends Node

#this script adds logic for parsing the JSON-File

var textData = {}

var data_file_path = "res://assets/Textfiles/dialogueFile.JSON"

func _ready():
	textData = load_json_file(data_file_path)


func load_json_file(filePath : String):
	
	if FileAccess.file_exists(filePath):
		
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Dictionary:
			return parsedResult
			
		else:
			print("Error reading File")
	
	else:
		print("File doesnt exist");
