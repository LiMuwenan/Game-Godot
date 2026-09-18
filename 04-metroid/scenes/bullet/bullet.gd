extends Node2D

var DIRECTION: Vector2 = Vector2.ZERO
var SPEED = 150
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Area2D/Sprite2D, "scale", Vector2.ONE, 0.05).from(Vector2.ZERO)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += DIRECTION * SPEED * delta
	pass

func setup(pos: Vector2, dir: Vector2):
	position = pos
	DIRECTION = dir
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("hit"):
		body.hit()
		queue_free()
	else:
		queue_free()
	pass # Replace with function body.
