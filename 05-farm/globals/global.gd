extends Node

enum Seeds { TOMATO, CORN, PUNMKIN }
const current_seed = {
	Seeds.TOMATO: "TOMATO",
	Seeds.CORN: "CORN",
	Seeds.PUNMKIN: "PUNMKIN",
}

enum Tools {NONE, HOE, AXE, WATER}
const tool_dict = {
	Tools.NONE: "NONE",
	Tools.HOE: "HOE",
	Tools.AXE: "AXE",
	Tools.WATER: "WATER",
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
