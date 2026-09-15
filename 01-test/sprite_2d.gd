extends Sprite2D

var speed = 400
var angular_speed = PI
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = 1
	if Input.is_action_pressed('ui_right'):
		direction = 1
	if Input.is_action_pressed("ui_left"):
		direction = -1
	
	rotation += delta * angular_speed * direction
	
	direction = 1
	if Input.is_action_pressed('ui_up'):
		direction = 1
	if Input.is_action_pressed("ui_down"):
		direction = -1
	var velo = Vector2.UP.rotated(rotation) * speed * direction
	position += velo * delta


func _on_button_pressed() -> void:
	set_process(not is_processing())
	
func _on_timer_timeout():
	visible = not visible
