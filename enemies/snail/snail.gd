extends BaseEnemy


@onready var floor_detection = $FloorDetection
@onready var animated_sprite_2d = $AnimatedSprite2D


func _ready():
	pass
	
func _physics_process(delta):
	super._physics_process(delta)

	if !is_on_floor():
		velocity.y += _gravity * delta
	else:
		velocity.x = speed * _facing
	
	move_and_slide()
	
	if is_on_floor():
		if is_on_wall() or !floor_detection.is_colliding():
			flip_me()


func flip_me() -> void:
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	floor_detection.position.x = floor_detection.position.x * -1
	if _facing == Facing.Left:
		_facing = Facing.Right
	else: 
		_facing = Facing.Left
