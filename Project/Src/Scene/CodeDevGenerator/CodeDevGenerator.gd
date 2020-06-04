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
onready var unique_id_panel = $MarginContainer/Control/SettingsToggleButton/UniqueIDPanel
onready var unique_id_line_edit = $MarginContainer/Control/SettingsToggleButton/UniqueIDPanel/VBox/UniqueLineEdit

export (String) var unique_app_id = "123456789"

#-------------------------------------------------
#      Notifications
#-------------------------------------------------

func _ready() -> void:
	_update_unique_id_setting_text()

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

func _on_SettingsToggleButton_pressed() -> void:
	_toggle_unique_id_panel_visible()

func _on_UniqueLineEdit_text_changed(new_text: String) -> void:
	_update_unique_id_setting(new_text)

#-------------------------------------------------
#      Private Methods
#-------------------------------------------------

func _toggle_unique_id_panel_visible():
	unique_id_panel.visible = !unique_id_panel.visible

func _update_unique_id_setting_text():
	unique_id_line_edit.text = unique_app_id

func _update_unique_id_setting(new_text: String):
	unique_app_id = new_text

#-------------------------------------------------
#      Setters & Getters
#-------------------------------------------------
