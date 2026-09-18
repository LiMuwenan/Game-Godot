extends CharacterBody2D


var direction: Vector2 = Vector2.ZERO
const SPEED = 120
@export var gravity := 800
@export var JUMP_VELOCITY := -400
signal attack(pos: Vector2, direction: Vector2)
var pre_dir: Vector2

const gun_dir = {
	Vector2i(0,0): 0,
	Vector2i(1,0): 0,
	Vector2i(1,1): 1,
	Vector2i(0,1): 2,
	Vector2i(-1,1): 3,
	Vector2i(-1,0): 4,
	Vector2i(-1,-1): 5,
	Vector2i(0,-1): 6,
	Vector2i(1,-1): 7,
}

func get_input():
	if direction.x != 0:
		pre_dir = direction
	direction.x = Input.get_axis("left", 'right')
	if Input.is_action_just_pressed("space"):
		velocity.y = JUMP_VELOCITY
	if $AttackTimer.time_left == 0 and Input.is_action_just_pressed("attack"):
		attack.emit(position, get_local_mouse_position().normalized())
		$AttackTimer.start()
		
		var tween = get_tree().create_tween()
		tween.tween_property($Marker, "scale", Vector2(0.1, 0.1), 0.2)
		tween.tween_property($Marker, "scale", Vector2(0.2, 0.2), 0.4)
		
func _physics_process(delta: float) -> void:
	get_input()
	velocity.x = direction.x * SPEED

	apply_gravity(delta)
	move_and_slide()
	attack_marker()
	animation()

func apply_gravity(delta: float):
	velocity.y += gravity * delta


func _on_attack_timer_timeout() -> void:
	pass

func animation():
	if direction.x == 0:
		$Legs.flip_h = pre_dir.x < 0
	else:
		$Legs.flip_h = direction.x < 0
	
	var mp = get_local_mouse_position().normalized()
	var v2 = Vector2i(round(mp.x), round(mp.y))
	
	$BodyPlayer.current_animation = 'body' + str(gun_dir[v2])
		
	if is_on_floor():
		$LegsPlayer.current_animation = 'walk' if direction.x != 0 else 'idle'
	else:
		$LegsPlayer.current_animation = 'jump'

func attack_marker():
	$Marker.position = get_local_mouse_position()
