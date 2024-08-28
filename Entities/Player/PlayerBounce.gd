extends Node3D

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
	#Throw object up when bottom object is scaling
	for ray in rayList:
		if (ray.is_colliding()):
			var obj = ray.get_collider()
			if obj is RigidBody3D and obj.get_groups().find("resizable") and obj.is_scaling:
					player.apply_central_impulse(-ray.target_position * 5.0)
	
