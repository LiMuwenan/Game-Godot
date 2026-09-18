extends CharacterBody2D

var dir: Vector2
var speed := 50
var player : CharacterBody2D
var blood := 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Boom/BoomSprite.hide()

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if player:
		dir = (player.position - position).normalized()
		velocity = dir * speed
		move_and_slide()
	pass


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.has_method('attack_marker'):
		player = body
	pass # Replace with function body.


func _on_detect_area_body_exited(body: Node2D) -> void:
	if body.has_method('attack_marker'):
		player = null

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
	pass # Replace with function body.


func drone_destroy():
	speed = 0
	$AnimatedSprite2D.hide()
	$Boom/BoomSprite.show()
	$Boom/AnimationPlayer.play("boom")


func _on_attack_body_entered(body: CharacterBody2D) -> void:
	if body.has_method("attack_marker"):
		drone_destroy()
	pass # Replace with function body.

func hit():
	blood -= 1
		
	var tween = get_tree().create_tween()
	tween.tween_property($PointLight2D, "energy", 1.2, 0.1)
	tween.tween_property($PointLight2D, "energy", 0.0, 0.5)
	
	if blood <= 0:
		drone_destroy()
		
func is_chain_boom():
	var nodes = get_tree().get_nodes_in_group('drones_group')
	for node in nodes:
		if position.distance_to(node.position) < 100:
			node.drone_destroy()
