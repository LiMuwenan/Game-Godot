extends Area2D

var direction = Vector2.LEFT
var speed = 100
var textures = [
	preload('res://assets/graphics/cars/green.png'),
	preload('res://assets/graphics/cars/red.png'),
	preload('res://assets/graphics/cars/yellow.png'),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = textures.pick_random()
	if position.x < 0:
		direction = Vector2.RIGHT
		$Sprite2D.flip_h = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += delta * speed * direction.x


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
