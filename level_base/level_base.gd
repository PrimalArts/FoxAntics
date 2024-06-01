extends Node2D

@onready var player = $Player
@onready var player_cam = $PlayerCam



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame.a aaelapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	player_cam.position = player.position
