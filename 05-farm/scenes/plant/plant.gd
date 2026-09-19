extends Node2D

var current_seed: Global.Seeds
var grid_pos: Vector2i

var max_age: int
var age: float = 0.0
var grow_speed: float

const plant_data = {
	Global.Seeds.CORN:{
		'texture': preload('res://graphics/plants/corn.png'), 'max_age': 3, "grow_speed": 0.2
	},
	Global.Seeds.TOMATO:{
		'texture': preload('res://graphics/plants/tomatoes.png'), 'max_age': 1, "grow_speed": 0.1
	},
	Global.Seeds.PUNMKIN:{
		'texture': preload('res://graphics/plants/pumpkin.png'), 'max_age': 10, "grow_speed": 0.3
	},
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setup(seed_enum: Global.Seeds, grid_position: Vector2i):
	current_seed = seed_enum
	grid_pos = grid_position
	max_age = plant_data[seed_enum]['max_age']
	grow_speed = plant_data[seed_enum]['grow_speed']
	$Sprite2D.texture = plant_data[seed_enum]['texture']
	
func grow(water: bool):
	if water:
		age += grow_speed
		$Sprite2D.frame = min(int(age / max_age * 3), 3)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if age >= max_age:
		queue_free()
	pass # Replace with function body.
