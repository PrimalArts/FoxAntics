extends CharacterBody2D

class_name BaseEnemy

enum Facing {Left = -1, Right = 1}
const Off_screen_kill_me: float = 1000.0

@export var default_facing: Facing = Facing.Left
@export var points: int = 1
@export var speed: float = 30.0


var _gravity: float = 800.0
var _facing: Facing = default_facing
var _player_ref: Player 
var _dying: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	_player_ref = get_tree().get_nodes_in_group(GameManager.Group_Player)[0]


func _physics_process(delta):
	pass
	
func falling_off():
	if global_position.y > Off_screen_kill_me:
		queue_free()
func die():
	if _dying:
		return
	
	_dying = true
	SignalManager.on_enemy_hit.emit(points, global_position)
	set_physics_process(false)
	hide()
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered():
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited():
	pass # Replace with function body.
