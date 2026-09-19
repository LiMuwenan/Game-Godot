extends Node2D

@onready var player = $Objects/Player
var plant_scene: PackedScene = preload("res://scenes/plant/plant.tscn")
@export var day_time_gradient: Gradient

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("day_switch"):
		day_switch()
	$CanvasModulate.color = day_time_gradient.sample(1.0 - $DayTimer.time_left / $DayTimer.wait_time)
	pass


func _on_player_tool_use(tool: int, pos: Vector2) -> void:
	var grid_pos = Vector2i(int(pos.x / 16), int(pos.y / 16))
	if tool == Global.Tools.HOE:
		var cell = $layers/GrassLayer.get_cell_tile_data(grid_pos) as TileData
		if cell and cell.get_custom_data("usable"):
			await $Objects/Player/AnimationTree.animation_finished
			$layers/SoilLayer.set_cells_terrain_connect([grid_pos], 0, 0)
	
	if tool == Global.Tools.WATER:
		var cell = $layers/SoilLayer.get_cell_tile_data(grid_pos) as TileData
		if cell and cell.get_custom_data("soil"):
			await $Objects/Player/AnimationTree.animation_finished
			$layers/SoilWaterLayer.set_cell(grid_pos, 0, Vector2i(randf_range(0, 2), 0))
	if tool == Global.Tools.AXE:
		for tree in get_tree().get_nodes_in_group("trees"):
			if tree.position.distance_to(pos) < 20:
				tree.hit()
	pass # Replace with function body.


func _on_player_seed_use(current_seed: int, pos: Vector2) -> void:
	var grid_pos = Vector2i(int(pos.x / 16), int(pos.y / 16))
	var cell = $layers/SoilLayer.get_cell_tile_data(grid_pos) as TileData
	if cell:
		var plant = plant_scene.instantiate()
		plant.position = Vector2(grid_pos.x * 16 + 8, grid_pos.y * 16 - 4)
		$Objects.add_child(plant)
		plant.setup(current_seed, grid_pos)
	pass # Replace with function body.

func day_switch():
	var tween = create_tween()
	tween.tween_property($CanvasLayer/ColorRect, "modulate:a", 1.0, 1.0)
	tween.tween_callback(level_reset)
	tween.tween_interval(2.0)
	tween.tween_property($CanvasLayer/ColorRect, "modulate:a", 0.0, 1.0)

func level_reset():
	for plant in get_tree().get_nodes_in_group("plants"):
		var cell = $layers/SoilWaterLayer.get_cell_tile_data(plant.grid_pos) as TileData
		plant.grow(cell != null)
	$DayTimer.start()


func _on_day_timer_timeout() -> void:
	day_switch()
	pass # Replace with function body.
