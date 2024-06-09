extends Node


const HS_FILE: String = "user://scores.dat"
const HS_KEY: String = "highscore"

var _score: int = 0
var _high_score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	load_high_score()
	SignalManager.on_boss_killed.connect(on_boss_killed)
	SignalManager.on_pickup_hit.connect(on_pickup_hit)
	SignalManager.on_enemy_hit.connect(on_enemy_hit)
	
	SignalManager.on_level_complete.connect(on_level_complete)
	SignalManager.on_game_over.connect(on_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func save_high_score() -> void:
	var file = FileAccess.open(HS_FILE, FileAccess.WRITE)
	var data = {
			HS_KEY: _high_score
		}
	file.store_string(JSON.stringify(data))
	
func update_score(points: int) -> void:
	_score += points
	if _high_score < _score:
		_high_score = _score
	SignalManager.on_score_update.emit()
		
func get_score() -> int:
	return _score
	
func get_high_score() -> int:
	return _high_score
	
func reset_score() -> void:
	_score = 0
	
func load_high_score() -> void:
	if !FileAccess.file_exists(HS_FILE):
		return
		
	var file = FileAccess.open(HS_FILE, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	
	print("data")
	
	if HS_KEY in data:
		_high_score = data[HS_KEY]
		
		

func on_game_over():
	save_high_score()

func on_level_complete():
	save_high_score()


func on_boss_killed(points: int)->void:
	update_score(points)

func on_pickup_hit(points: int)->void:
	update_score(points)
	
func on_enemy_hit(points: int, _v: Vector2) -> void:
	update_score(points)
