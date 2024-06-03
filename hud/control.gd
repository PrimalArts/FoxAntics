extends Control

@onready var color_rect = $ColorRect
@onready var vb_level_complete = $ColorRect/VB_LevelComplete
@onready var vb_game_over = $ColorRect/VB_GameOver
@onready var hb_hearts = $"12/HB/HB_Hearts"

var _hearts: Array
# Called when the node enters the scene tree for the first time.
func _ready():
	_hearts = hb_hearts.get_children()
	SignalManager.on_level_complete.connect(on_level_complete)
	SignalManager.on_game_over.connect(on_game_over)
	SignalManager.on_player_hit.connect(on_player_hit)

func _process(delta):
	if vb_level_complete.visible == true:
		if Input.is_action_just_pressed("jump"):
			GameManager.load_next_level_scene()
	
	if vb_game_over.visible == true:
		if Input.is_action_just_pressed("jump"):
			GameManager.load_main_scene()

func show_hud() -> void:
	Engine.time_scale = 0
	color_rect.visible = true

func on_game_over():
	show_hud()
	vb_game_over.visible = true

func on_level_complete():
	show_hud()
	vb_level_complete.visible = true
	
func on_player_hit(lives: int) -> void:
	for life in range(_hearts.size()):
		_hearts[life].visible = lives > life

