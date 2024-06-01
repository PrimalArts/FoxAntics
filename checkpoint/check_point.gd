extends Area2D
const Trigger_Condition: String = "parameters/conditions/on_trigger"
@onready var animation_tree = $AnimationTree
@onready var sound = $Sound

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_boss_killed.connect(on_boss_killed)


func on_boss_killed(_p: int) -> void:
	animation_tree[Trigger_Condition] = true
	monitoring = true
	SoundManager.play_clip(sound, SoundManager.SOUND_CHECKPOINT)
	


func _on_area_entered(area):
	SoundManager.play_clip(sound, SoundManager.SOUND_WIN)
