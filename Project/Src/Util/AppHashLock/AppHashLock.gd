# AppHashLock
# Written by: First

extends Reference

class_name AppHashLock

"""
	AppHashLock 
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

const REQ_CODE_LENGTH = 6

#-------------------------------------------------
#      Properties
#-------------------------------------------------

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

func get_request_code(
	unique_pass : String,
	day_passed : String = _get_day_code(),
	unique_device_id : String = OS.get_unique_id()
) -> String:
	
	var concat_code = str(unique_pass, day_passed, unique_device_id)
	var encoded_text = _get_encoded_text(concat_code)
	
	return encoded_text

func get_unlock_code(request_code : String, unique_pass : String) -> String:
	return _get_encoded_text(request_code + unique_pass)

func is_match(unlock_code : String, unique_pass : String) -> bool:
	return unlock_code == get_unlock_code(get_request_code(unique_pass), unique_pass)

#-------------------------------------------------
#      Connections
#-------------------------------------------------

#-------------------------------------------------
#      Private Methods
#-------------------------------------------------

func _get_day_code() -> String:
	var year = OS.get_date().get("year")
	var month = OS.get_date().get("month")
	var day = OS.get_date().get("day")
	
	return str(year, month, day)

func _get_encoded_text(txt : String) -> String:
	return txt.sha256_text().left(REQ_CODE_LENGTH)

#-------------------------------------------------
#      Setters & Getters
#-------------------------------------------------
