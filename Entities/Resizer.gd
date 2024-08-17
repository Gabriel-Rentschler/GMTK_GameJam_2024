extends MeshInstance3D

@onready var raycast = %GunRay

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#raycast
	if Input.is_action_just_pressed("fire") and raycast.is_colliding():
		
		var obj = raycast.get_collider()
		if (!get_tree().get_nodes_in_group("resizable").find(obj)):
			var obj_mesh = obj.get_node("Mesh")
			obj_mesh.scale.y = 2
		
			var obj_shape = obj.get_node("Collision")
			obj_shape.scale.y = 2
