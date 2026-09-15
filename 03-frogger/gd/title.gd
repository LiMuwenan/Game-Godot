extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.score == 10000:
		$Label.text = 'High Score: 0'
	else:
		$Label.text = 'High Score: ' + str(Global.score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed('space'):
		call_deferred('change_secene')
	pass
func change_secene():
	get_tree().change_scene_to_file("res://assets/secene/game.tscn")
