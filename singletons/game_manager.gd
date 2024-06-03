extends Node

const Group_Player: String = "player"

const Total_Levels: int = 4
const Main_Scene: PackedScene = preload("res://main/main.tscn")

var _current_level: int = 0 
var _level_scenes = {

}


func _ready():
	init_level_scenes()
	
func init_level_scenes() -> void:
	for ln in range(1, Total_Levels+1):
		_level_scenes[ln] = load("res://level_base/levels/level_%s.tscn" % ln)
	
func load_main_scene() -> void:
	get_tree().change_scene_to_packed(Main_Scene)

func load_next_level_scene() -> void:
	set_next_level()
	get_tree().change_scene_to_packed(_level_scenes[_current_level])

func set_next_level() -> void:
	_current_level +=1
	if _current_level > Total_Levels:
		_current_level = 1
