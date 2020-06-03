# AppLockWindow
# Written by: First

extends Node

"""
	Desc
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

const VERIFY_DELAY_TIME = 0.8

#-------------------------------------------------
#      Properties
#-------------------------------------------------

onready var ask_code_label = $CanvasLayer/MarginContainer/Control/VBox/AskCodeHBox/AskCodeLabel
onready var pwd_line_edit = $CanvasLayer/MarginContainer/Control/VBox/PasswordLineEdit

var my_unique_code = "123456789"

#-------------------------------------------------
#      Notifications
#-------------------------------------------------

func _ready() -> void:
	_update_request_code()

#-------------------------------------------------
#      Virtual Methods
#-------------------------------------------------

#-------------------------------------------------
#      Override Methods
#-------------------------------------------------

#-------------------------------------------------
#      Public Methods
#-------------------------------------------------

func verify():
	if not _is_code_match():
		print("NOT MATCH!")
	else:
		print('wdf hacker')

#-------------------------------------------------
#      Connections
#-------------------------------------------------

func _on_CopyLinkButton_pressed() -> void:
	OS.set_clipboard(ask_code_label.text)

func _on_VerifyButton_pressed() -> void:
	verify()

#-------------------------------------------------
#      Private Methods
#-------------------------------------------------

func _update_request_code():
	var ahl = AppHashLock.new()
	ask_code_label.set_text(ahl.get_request_code(my_unique_code))

func _is_code_match() -> bool:
	var ahl = AppHashLock.new()
	return ahl.is_match(pwd_line_edit.text, my_unique_code)

#-------------------------------------------------
#      Setters & Getters
#-------------------------------------------------
