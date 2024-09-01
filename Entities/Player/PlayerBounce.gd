extends Node3D

#IMPORTS
var bounce = load("res://bounce_mechanic.gd").new()
@onready var player = %"PlayerRigidBody"

var rayList = []

func _ready():
	rayList.append($Feet)
	rayList.append($Head)
	rayList.append($Front)
	rayList.append($Back)
	rayList.append($Left)
	rayList.append($Right)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	bounce.bounce(rayList, player, true)
