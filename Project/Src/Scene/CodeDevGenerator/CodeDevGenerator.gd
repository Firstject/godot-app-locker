# CodeDevGenerator
# Written by: First

extends Node

"""
	A scene for the game developer
"""

#-------------------------------------------------
#      Classes
#-------------------------------------------------

#-------------------------------------------------
#      Signals
#-------------------------------------------------

#-------------------------------------------------
#      Constants
#-------------------------------------------------

#-------------------------------------------------
#      Properties
#-------------------------------------------------

onready var request_line_edit = $MarginContainer/Control/VBox/RequestLineEdit
onready var output_label = $MarginContainer/Control/VBox/OutputHbox/OutputLabel

export (String) var unique_app_id = "123456789"

#-------------------------------------------------
#      Notifications
#-------------------------------------------------

#-------------------------------------------------
#      Virtual Methods
#-------------------------------------------------

#-------------------------------------------------
#      Override Methods
#-------------------------------------------------

#-------------------------------------------------
#      Public Methods
#-------------------------------------------------

func generate():
	var ahl = AppHashLock.new()
	output_label.set_text(ahl.get_unlock_code(request_line_edit.get_text(), unique_app_id))

#-------------------------------------------------
#      Connections
#-------------------------------------------------

func _on_GenerateButton_pressed() -> void:
	generate()

func _on_CopyLinkButton_pressed() -> void:
	OS.set_clipboard(output_label.text)

#-------------------------------------------------
#      Private Methods
#-------------------------------------------------

#-------------------------------------------------
#      Setters & Getters
#-------------------------------------------------
