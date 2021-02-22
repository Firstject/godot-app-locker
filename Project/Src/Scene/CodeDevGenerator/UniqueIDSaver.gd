# UniqueIDSaver

extends Reference
class_name UniqueIDSaver

"""
	Responsible for saving and loading Unique ID for CodeDevGenerator.tscn
"""


const CONFIG_FILE_PATH = "user://AppUnlock/"
const CONFIG_FILE_NAME = "dev_unique_id.cfg"


# Returns ID string from saved file. Returns empty if the file is not exist.
func load() -> String:
	var cfg = ConfigFile.new()
	var err = cfg.load_encrypted_pass(CONFIG_FILE_PATH + CONFIG_FILE_NAME, OS.get_unique_id())
	
	if err != OK:
		return ""
	
	return cfg.get_value("UniqueID", "unique_app_id", "")

func save(id : String):
	# Make directory (if not exist)
	var dir = Directory.new()
	if not dir.dir_exists(CONFIG_FILE_PATH):
		dir.make_dir(CONFIG_FILE_PATH)
	
	var cfg = ConfigFile.new()
	cfg.set_value("UniqueID", "unique_app_id", id)
	cfg.save_encrypted_pass(CONFIG_FILE_PATH + CONFIG_FILE_NAME, OS.get_unique_id())
