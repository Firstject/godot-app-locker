# AppUnlockSaver
# Written by: First

extends Reference

class_name AppUnlockSaver

"""
	Saves, checks, and remove verification file in user's app data directory,
	remembering the state whether a client succeed in verifying the unlock code.
	Hash password can be used for verification process when the application
	is launched, which prevents client from replacing a verification file from
	another source.
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

const SAVE_PATH = "user://AppUnlock/"
const SAVE_FILE = "session.dat"

#-------------------------------------------------
#      Properties
#-------------------------------------------------

# Hash password for verification process when the application starts
var hash_pass : String setget set_hash_pass, get_hash_pass

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

# Save state to user's app data directory.
# Hash password kept in this class is used for additional security.
# An optional parameter can be used to override current hash password.
func save(hash_pass_override : String = get_hash_pass()):
	_make_dir()
	_store_save_data(get_data(hash_pass_override))

# Remove verification file from user's app data directory.
func relock():
	var dir := Directory.new()
	dir.remove(SAVE_PATH + SAVE_FILE)

# Check whether the verification file exists and is match with the current
# hash password. Returns true if all of the above are correct, or false if not.
# An optional parameter can be used to override current hash password.
func is_unlocked(hash_pass_override : String = get_hash_pass()) -> bool:
	var f := File.new()
	var f_open_result = f.open(SAVE_PATH + SAVE_FILE, File.READ)
	var result : bool = true
	
	if not f_open_result == OK:
		return false
	
	# Read the content from saved file and compare
	# if the session is equal to this unique device id.
	if f.get_as_text() != get_data(hash_pass_override):
		result = false
	
	f.close()
	
	return result

# Returns MD5 hash of unique_device_id and current hash password in String.
# An optional parameter can be used to override current hash password.
func get_data(hash_pass_override : String = get_hash_pass()) -> String:
	return str(OS.get_unique_id(), hash_pass_override).md5_text()

#-------------------------------------------------
#      Connections
#-------------------------------------------------

#-------------------------------------------------
#      Private Methods
#-------------------------------------------------

func _make_dir():
	var dir := Directory.new()
	var dir_open_result = dir.open(SAVE_PATH)
	if not dir_open_result == OK:
		dir.make_dir(SAVE_PATH)

func _store_save_data(data : String):
	var f := File.new()
	var f_open_result = f.open(SAVE_PATH + SAVE_FILE, File.WRITE)
	
	if f_open_result == OK:
		f.store_string(data)
	else:
		push_error("Save failed. Return " + str(f_open_result))
	
	f.close()

#-------------------------------------------------
#      Setters & Getters
#-------------------------------------------------

func set_hash_pass(val : String) -> void:
	hash_pass = val

func get_hash_pass() -> String:
	return hash_pass
