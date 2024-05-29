extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
const Fruits: Array = ["melon", "banana", "kiwi", "cherry"]
const Gravity: float = 100.0
const Jump: float = -30.0
const Points: int = 2

var _start_y: float
var _speed_y: float = Jump
var _stopped: bool = false

func _ready():
	_start_y = global_position.y
	animated_sprite_2d.play(Fruits.pick_random())

func _process(delta):
	if _stopped:
		return
	
	position.y += _speed_y * delta
	_speed_y += Gravity * delta
	
	if global_position.y > _start_y:
		_stopped = true

func kill_me() -> void:
	set_process(false)
	hide()
	queue_free()

func _on_life_timer_timeout():
	kill_me()


func _on_area_entered(area):
	SignalManager.on_pickup_hit.emit()
	kill_me()
