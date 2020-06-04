# AppUnlockSaver
# Written by: First

extends Reference

class_name AppUnlockSaver

"""
	Todo: Add desc
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

# Change this to anything (for minor security)
const HASH_PASSWORD = "Chnage_This"

const SAVE_PATH = "user://AppUnlock/"
const SAVE_FILE = "session.dat"

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

func save():
	_make_dir()
	_store_save_data(get_data())

func relock():
	var dir := Directory.new()
	dir.remove(SAVE_PATH + SAVE_FILE)

func is_unlocked() -> bool:
	var f := File.new()
	var f_open_result = f.open(SAVE_PATH + SAVE_FILE, File.READ)
	var result : bool = true
	
	if not f_open_result == OK:
		return false
	
	# Read the content from saved file and compare
	# if the session is equal to this unique device id.
	if f.get_as_text() != get_data():
		result = false
	
	f.close()
	
	return result

func get_data() -> String:
	return str(OS.get_unique_id(), HASH_PASSWORD).md5_text()

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
