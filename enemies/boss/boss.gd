extends Node2D

const Trigger_Condition: String = "parameters/conditions/on_trigger"
const Hit_Condition: String = "parameters/conditions/on_hit"

@onready var animation_tree = $AnimationTree
@onready var visual = $Visual

@export var lives: int = 2
@export var points: int = 5
@onready var sound = $Sound

var _invincible: bool = false

func _exit_tree():
	print("Exit tree")
	
func _enter_tree():
	print("Enter tree")

func tween_hit() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(visual, "position", Vector2.ZERO, 1.0)

func reduce_lives() -> void:
	lives -=1
	if lives <= 0:
		SignalManager.on_boss_killed.emit(points)
		set_process(false)
		queue_free()

func set_invincible(v: bool) -> void:
	_invincible = v
	animation_tree[Hit_Condition] = v

func take_damage() -> void:
	if _invincible == true:
		return
	
	set_invincible(true)
	tween_hit()
	reduce_lives()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_trigger_area_entered(area):
	if !animation_tree[Trigger_Condition]:
		SoundManager.play_clip(sound, SoundManager.SOUND_BOSS_ARRIVE)
		animation_tree[Trigger_Condition] = true


func _on_hit_box_area_entered(area):
	take_damage()
