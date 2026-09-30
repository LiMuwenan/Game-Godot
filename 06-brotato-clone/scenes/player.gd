extends Unit
class_name Player

var move_dir: Vector2
var speed: int = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position += move_dir * speed * delta
	update_animation()
	pass

func update_animation():
	if move_dir:
		animation_player.play('move')
	else:
		animation_player.play('idle')
	
