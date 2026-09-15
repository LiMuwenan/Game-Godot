extends Node2D

@export var car_secene: PackedScene = preload('res://assets/secene/car.tscn')


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_target_area_body_entered(body: Node2D) -> void:
	print('body', body)


func _on_car_timer_timeout() -> void:
	var car = car_secene.instantiate()
		
	var car_marker = $Car/Mark.get_children().pick_random()
	
	car.position = car_marker.position
	$Car.add_child(car)
	
	car.connect('body_entered', go_to_title)
	
func go_to_title(body: Node2D):
	print('go_to_title',body)
