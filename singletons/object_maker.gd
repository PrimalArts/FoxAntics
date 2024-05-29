extends Node

enum Bullet_Key {ENEMY, PLAYER}
enum Scene_Key {Explosion, Pickup}

const Bullets =  {
	Bullet_Key.ENEMY: preload("res://bullets/enemy_bullet/enemy_bullet.tscn"),
	Bullet_Key.PLAYER: preload("res://bullets/player_bullet/pllayer_bullet.tscn")
}

const Simple_Scenes  ={
	Scene_Key.Explosion : preload("res://enemy_explosion/enemy_explosion.tscn"),
	Scene_Key.Pickup : preload("res://fruit_pickup/fruit_pick_up.tscn")
}




func add_child_differed(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)

func call_add_child(child_to_add) -> void:
	call_deferred("add_child_differed", child_to_add)

func create_bullet(speed: float, direction: Vector2, start_pos: Vector2,
 				life_span: float, key: Bullet_Key ):
	var new_b = Bullets[key].instantiate()
	new_b.setup(direction, life_span, speed)
	new_b.global_position = start_pos
	call_add_child(new_b)
	
func create_simple_scene(start_pos: Vector2, key: Scene_Key):
	var new_exp = Simple_Scenes[key].instantiate()
	new_exp.global_position = start_pos
	call_add_child(new_exp)



