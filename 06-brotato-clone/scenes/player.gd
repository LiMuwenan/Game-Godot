extends Unit
class_name Player

@export var dash_duration := 1.0
@export var dash_cool_down := 1.0
@export var dash_speed_muli_rate := 1.25


@onready var dash_cool_down_timer: Timer = $DashCoolDownTimer
@onready var dash_duration_timer: Timer = $DashDurationTimer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var trail: Trail = %Trail


var move_dir: Vector2
var is_dashing := false
var dash_available := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dash_duration_timer.wait_time = dash_duration
	dash_cool_down_timer.wait_time = dash_cool_down
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var vel = move_dir * stats.speed
	if is_dashing:
		vel *= dash_speed_muli_rate
	position += vel * delta
	if can_dash():
		start_dash()
	update_animation()
	update_forward()
	pass

func update_animation():
	if move_dir:
		animation_player.play('move')
	else:
		animation_player.play('idle')

func update_forward():
	if move_dir:
		sprite.flip_h = move_dir.x > 0


func start_dash():
	is_dashing = true
	dash_duration_timer.start()
	trail.start_trail()
	visuals.modulate.a = 0.5
	collision_shape_2d.set_deferred("disabled", true) # 延迟调用。如果正在碰撞处理时关闭碰撞会引发异常
	
	
func can_dash() -> bool:
	return not is_dashing and \
		dash_cool_down_timer.is_stopped() and \
		Input.is_action_just_pressed("dash") and \
		move_dir != Vector2.ZERO

func _on_dash_duration_timer_timeout() -> void:
	is_dashing = false
	visuals.modulate.a = 1.0
	dash_cool_down_timer.start()
	collision_shape_2d.set_deferred("disabled", false)
	pass # Replace with function body.
