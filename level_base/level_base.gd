extends Node2D

@onready var player = $Player
@onready var player_cam = $PlayerCam



# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 1


# Called every frame.a aaelapsed time since the previous frame.
func _process(delta):
	player_cam.position = player.position
	#
	#if Input.is_action_just_pressed("left"):
		#GameManager.load_main_scene()
	#
	#if Input.is_action_just_pressed("right"):
		#GameManager.load_next_level_scene()
		
