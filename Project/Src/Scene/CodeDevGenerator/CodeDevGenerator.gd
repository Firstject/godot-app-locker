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

onready var ctrl = $MarginContainer/Control
onready var output_ctrl = $MarginContainer/OutputCtrl
onready var request_line_edit = $MarginContainer/Control/VBox/RequestLineEdit
onready var output_label = $MarginContainer/OutputCtrl/VBox/OutputLabel
onready var unique_id_panel = $MarginContainer/Control/SettingsToggleButton/UniqueIDPanel
onready var unique_id_line_edit = $MarginContainer/Control/SettingsToggleButton/UniqueIDPanel/VBox/UniqueLineEdit

onready var copied_label_anim = $MarginContainer/OutputCtrl/VBox/OutputLabel/CopiedLabel/AnimationPlayer

export (String) var unique_app_id = "123456789"


var unique_id_saver := UniqueIDSaver.new()

#-------------------------------------------------
#      Notifications
#-------------------------------------------------

func _ready() -> void:
	var _unique_app_id = unique_id_saver.load() # Load previous entered value from previous session
	if not _unique_app_id.empty(): # Session file exists, begin loading
		unique_app_id = _unique_app_id
	
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
	unique_id_saver.save(unique_app_id)
	_to_output_page()

func _on_CopyButton_pressed() -> void:
	OS.set_clipboard(output_label.text)
	copied_label_anim.play("Float")

func _on_SettingsToggleButton_pressed() -> void:
	_toggle_unique_id_panel_visible()

func _on_UniqueLineEdit_text_changed(new_text: String) -> void:
	_update_unique_id_setting(new_text)

func _on_ReturnBtn_pressed() -> void:
	_to_generate_page()

#-------------------------------------------------
#      Private Methods
#-------------------------------------------------

func _toggle_unique_id_panel_visible():
	unique_id_panel.visible = !unique_id_panel.visible

func _update_unique_id_setting_text():
	unique_id_line_edit.text = unique_app_id

func _update_unique_id_setting(new_text: String):
	unique_app_id = new_text

func _to_generate_page():
	ctrl.visible = true
	output_ctrl.visible = false

func _to_output_page():
	ctrl.visible = false
	output_ctrl.visible = true

#-------------------------------------------------
#      Setters & Getters
#-------------------------------------------------
