extends StaticBody2D

const frames_list = [0, 1]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.frame =  frames_list.pick_random()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hit():
	var tween = create_tween()
	tween.tween_property($Sprite2D.material, "shader_parameter/progress", 1.0, 0.2)
	tween.tween_property($Sprite2D.material, "shader_parameter/progress", 0, 0.3)
