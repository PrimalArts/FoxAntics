extends BaseEnemy

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var jump_timer = $JumpTimer


const Jump_velocity: Vector2 = Vector2(100, -150)
const Jump_Wait_range: Vector2 = Vector2(2.5, 5.0)

var _jump = false
var _seen_player: bool = false

func _ready():
	super._ready()
	start_timer()


func _physics_process(delta):
	super._physics_process(delta)
	if !is_on_floor():
		velocity.y += _gravity * delta
		
	else: 
		velocity.x = 0
		animated_sprite_2d.play("idle")
	
	apply_jump()
	move_and_slide()
	flip_me()
	
func start_timer() -> void:
	jump_timer.wait_time = randf_range(Jump_Wait_range.x, Jump_Wait_range.y)
	jump_timer.start()

func apply_jump():
	if !is_on_floor():
		return
		
	if !_seen_player or !_jump:
		return
		
	velocity = Jump_velocity
	
	if !animated_sprite_2d.flip_h:
		velocity.x = velocity.x * -1
	
	_jump = false
	
	animated_sprite_2d.play("jump")
	start_timer()

func flip_me():
	if(_player_ref.global_position.x > global_position.x
		and animated_sprite_2d.flip_h == false):
		animated_sprite_2d.flip_h  = true
	elif (_player_ref.global_position.x < global_position.x
		and animated_sprite_2d.flip_h == true):
			animated_sprite_2d.flip_h = false

func _on_jump_timer_timeout():
	_jump = true


func _on_visible_on_screen_notifier_2d_screen_entered():
	_seen_player = true
