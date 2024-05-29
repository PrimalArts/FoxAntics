extends CharacterBody2D

class_name Player

@onready var animation_player = $AnimationPlayer

@onready var player_sprite = $PlayerSprite
@onready var debug_label = $debug_label
@onready var sound_player = $SoundPlayer
@onready var shooter = $Shooter
@onready var animation_invincible = $AnimationInvincible
@onready var timer = $Timer

const Gravity: float = 1000.0
const Run_Speed: float = 120
const Max_Fall: float = 400
const Hurt_time: float = 0.3
const Jump_velocity: float = -400

enum Player_State { Idle, Run, Jump, Fall, Hurt}

var invincible: bool = false

var _state: Player_State = Player_State.Idle

func _ready():
	pass # Replace with function body.
	
	
func shoot() -> void:
	if player_sprite.flip_h :
		shooter.shoot(Vector2.LEFT)
	else:
		shooter.shoot(Vector2.RIGHT)

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += Gravity * delta 
		
	get_input()
	move_and_slide()
	calculate_states()
	update_debug_label()
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	

func update_debug_label() -> void:
	debug_label.text = "floor: %s\n%s\n%.0f %0.f" % [
		is_on_floor(),
		Player_State.keys()[_state],
		velocity.x, velocity.y
	]
	
func get_input() -> void:
	velocity.x = 0
	
	if Input.is_action_pressed("left"):
		player_sprite.flip_h = true
		velocity.x = -Run_Speed
	elif Input.is_action_pressed("right"):
		player_sprite.flip_h = false
		velocity.x = Run_Speed
	if Input.is_action_pressed("jump"):
		velocity.y = Jump_velocity
		SoundManager.play_clip(sound_player, SoundManager.SOUND_JUMP)
	if Input.is_action_pressed("shoot"):
		shoot()
		
func calculate_states():
	if _state == Player_State.Hurt:
		return
	
	if is_on_floor():
		if velocity.x == 0:
			set_state(Player_State.Idle)
		else: 
			set_state(Player_State.Run)
	else:
		if  velocity.y > 0:
			set_state(Player_State.Fall)
		else: 
			set_state(Player_State.Jump)
		
func set_state(new_state: Player_State) -> void:
	if new_state == _state:
		return
		
	if _state == Player_State.Fall:
		if  new_state == Player_State.Idle or new_state == Player_State.Run:
			SoundManager.play_clip(sound_player, SoundManager.SOUND_LAND)
	
	_state = new_state
	
	match _state:
		Player_State.Idle:
			animation_player.play("idle")
		Player_State.Run:
			animation_player.play("run")
		Player_State.Jump:
			animation_player.play("jump")
		Player_State.Fall:
			animation_player.play("fall")
		Player_State.Hurt:
			animation_player.play("hurt")


func go_invincible():
	invincible = true
	animation_invincible.play("invincible")
	timer.start()


func apply_hit():
	if invincible:
		return
	go_invincible()
	SoundManager.play_clip(sound_player, SoundManager.SOUND_DAMAGE)

func _on_hitbox_area_entered(area):
	apply_hit()


func _on_timer_timeout():
	invincible = false
	animation_invincible.stop()
