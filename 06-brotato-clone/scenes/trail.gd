extends Line2D
class_name Trail

@export var player: Player
@export var train_length := 25
@export var trail_duation := 1.0

@onready var trail_timer: Timer = %TrailTimer


var points_array: Array[Vector2] = []
var is_active := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_active:
		return
	points_array.append(player.global_position)
	
	if points_array.size() > train_length:
		points_array.pop_front()
	
	points = points_array
	pass
	
func start_trail() -> void:
	is_active = true
	clear_points()
	points_array.clear()
	trail_timer.start(trail_duation)
	


func _on_trail_timer_timeout() -> void:
	is_active = false
	clear_points()
	points_array.clear()
	pass # Replace with function body.
