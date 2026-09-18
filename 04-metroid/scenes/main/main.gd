extends Node2D



const bullet_scene: PackedScene = preload("res://scenes/bullet/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_attack(pos: Vector2, dir: Vector2) -> void:
	var bullet = bullet_scene.instantiate() as Node2D
	$Bullets.add_child(bullet)
	bullet.setup(pos, dir)
	pass # Replace with function body.
