extends CharacterBody2D

@onready var move_state_machine : AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/MoveStateMachine/playback") 
@onready var tool_state_machine : AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/ToolStateMachine/playback") 

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var dir : Vector2 = Vector2.DOWN

enum Tools {NONE, HOE, AXE, WATER}
var tool: Tools = Tools.NONE
const tool_dict = {
	Tools.NONE: "NONE",
	Tools.HOE: "HOE",
	Tools.AXE: "AXE",
	Tools.WATER: "WATER",
}
var can_move = true

func _physics_process(delta: float) -> void:
	if can_move:
		get_input()
	velocity = dir * SPEED * int(can_move)
	animation()
	move_and_slide()

func get_input():
	dir = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_just_pressed("action"):
		tool_state_machine.travel(tool_dict[tool]) # ToolMachine中到End的转换需要设置为AtEnd
		$AnimationTree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		can_move = tool == 0
		
	if Input.is_action_just_pressed("tool_backward"):
		tool = (tool - 1 + Tools.size()) % Tools.size()
	if Input.is_action_just_pressed("tool_forward"):
		tool = (tool + 1 + Tools.size()) % Tools.size()

		

func animation():
	if dir:
		# 修改动画参数, AnimationTree machine blendspace的方向和游戏相反
		# dir最好归一化和取整,处理斜向动画错乱
		move_state_machine.travel("walk")
		$AnimationTree.set(
			"parameters/MoveStateMachine/walk/blend_position", 
			Vector2(round(dir.x), round(dir.y)))
		$AnimationTree.set(
			"parameters/MoveStateMachine/idle/blend_position", 
			Vector2(round(dir.x), round(dir.y)))	
		for state in tool_dict.values():
			$AnimationTree.set("parameters/ToolStateMachine/"+ state + "/blend_position", Vector2(round(dir.x), round(dir.y)))
	else:
		move_state_machine.travel("idle")
		
	


	


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	can_move = true
	pass # Replace with function body.
