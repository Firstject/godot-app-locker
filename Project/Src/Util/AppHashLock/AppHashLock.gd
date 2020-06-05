# AppHashLock
# Written by: First

extends Reference

class_name AppHashLock

"""
	AppHashLock generates request code and unlock code for use in unlocking
	application. Can check whether an unlock code matches with a request code.
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

# Length of request code and unlock code
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

# Returns a request code in String.
# First parameter is a password of your application,
# second optional parameter is current year concatenated with current month and
# total days passed,
# and third optional parameter is a unique device id.
func get_request_code(
	unique_pass : String,
	day_passed : String = _get_day_code(),
	unique_device_id : String = OS.get_unique_id()
) -> String:
	
	var concat_code = str(unique_pass, day_passed, unique_device_id)
	var encoded_text = _get_encoded_text(concat_code)
	
	return encoded_text

# Return unlock code from a request code and a unique password of your
# application.
func get_unlock_code(request_code : String, unique_pass : String) -> String:
	return _get_encoded_text(request_code + unique_pass)

# Returns true if an unlock code match with a request code from unique password.
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
