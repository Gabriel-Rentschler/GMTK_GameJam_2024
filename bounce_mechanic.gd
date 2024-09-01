extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func bounce(rayList: Array, rigidBody: RigidBody3D, is_player: bool) -> void:
	#Throw object up when bottom object is scaling
	for ray in rayList:
		if (ray.is_colliding()):
			var obj = ray.get_collider()
			if obj is RigidBody3D and obj.get_groups().find("resizable") and obj.is_scaling:
					if is_player:
						rigidBody.apply_central_impulse(-ray.target_position * obj.player_throw_force)
						return
					rigidBody.apply_central_impulse(-ray.target_position * obj.object_throw_force)
