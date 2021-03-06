# AppLockWindow
# Written by: First

extends Node

"""
	A singleton UI that appears when the application starts.
	
	See editor description for more info.
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

enum VerifyStatus {
	VERIFY_STATUS_OK,
	VERIFY_STATUS_INVALID
}

const VERIFY_DELAY_TIME = 0.8
const TXT_VERIFY_ONGOING = "Verifying..."
const TXT_VERIFY_FAILED = "Verification failed"
const TXT_VERIFY_SUCCESS = "Verification success"

const SUCCESS_COLOR = Color.green
const FAIL_COLOR = Color.red
const NORMAL_COLOR = Color.white

#-------------------------------------------------
#      Properties
#-------------------------------------------------

onready var ask_code_label = $CanvasLayer/MarginContainer/Control/VBox/AskCodeHBox/AskCodeLabel
onready var pwd_line_edit = $CanvasLayer/MarginContainer/Control/VBox/PasswordLineEdit
onready var verify_btn = $CanvasLayer/MarginContainer/Control/VBox/VerifyButton
onready var status_label = $CanvasLayer/MarginContainer/Control/VBox/StatusLabel

# Change this to your own custom password for increased security.
var my_unique_code = "123456789"

# Change this to your own custom password for increased security.
var my_hash_pass = "0246813579"

#-------------------------------------------------
#      Notifications
#-------------------------------------------------

func _ready() -> void:
	_do_unlocked()
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

# Verify to remove this window if completed or raise an error message if
# verification fails.
func verify():
	_set_buttons_disabled(true)
	status_label.add_color_override("font_color", NORMAL_COLOR)
	status_label.set_text(TXT_VERIFY_ONGOING)
	status_label.show()
	
	# Wait x seconds
	yield(get_tree().create_timer(VERIFY_DELAY_TIME), "timeout")
	
	if not _is_code_match():
		status_label.add_color_override("font_color", FAIL_COLOR)
		status_label.set_text(TXT_VERIFY_FAILED)
	else:
		status_label.add_color_override("font_color", SUCCESS_COLOR)
		status_label.set_text(TXT_VERIFY_SUCCESS)
		
		yield(get_tree().create_timer(VERIFY_DELAY_TIME), "timeout")
		
		_save_and_qfree()
	
	_set_buttons_disabled(false)

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

# Queue free itself if already verified. Otherwise, do nothing.
func _do_unlocked():
	var app_unlock_saver = AppUnlockSaver.new()
	app_unlock_saver.set_hash_pass(my_hash_pass)
	
	if app_unlock_saver.is_unlocked():
		queue_free()
		return
	else:
		_set_paused(true)

# Save the verification state by writing file to user's app directory
# and then free itself from instance.
func _save_and_qfree():
	var app_unlock_saver = AppUnlockSaver.new()
	app_unlock_saver.set_hash_pass(my_hash_pass)	
	app_unlock_saver.save()
	
	_set_paused(false)
	queue_free()

# Update request code's text.
func _update_request_code():
	var ahl = AppHashLock.new()
	ask_code_label.set_text(ahl.get_request_code(my_unique_code))

func _is_code_match() -> bool:
	var ahl = AppHashLock.new()
	return ahl.is_match(pwd_line_edit.text, my_unique_code)

func _set_buttons_disabled(set : bool):
	pwd_line_edit.set_editable(!set)
	verify_btn.set_disabled(set)

func _set_paused(set : bool):
	get_tree().paused = set

#-------------------------------------------------
#      Setters & Getters
#-------------------------------------------------
